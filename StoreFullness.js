/**
 * STORE FULLNESS MODULE
 * Extrae datos de Rayon Occupancy de correos diarios de BIREPORT@lcwaikiki.com
 * Soporta ambos formatos de asunto:
 *   - "Store Occupancy Alert Report - [País]"
 *   - "Store Occupancy Report - [País]"
 *
 * Ejecutar manualmente: testStoreFullness()
 * Producción: extractStoreFullness() vía trigger diario a las 6 AM
 */

// ─────────────────────────────────────────────
//  CONSTANTES
// ─────────────────────────────────────────────

const SF_SHEET_NAME   = 'Store_Fullness';
const SF_SENDER       = 'BIREPORT@lcwaikiki.com';
const SF_STATUS_VALS  = ['Full Occupancy', 'Empty-Available Stock', 'Empty-Unavailable Stock', 'Low Occupancy', 'Critical Low'];
const SF_MERCH_GROUPS = { BG: 1, BU: 1, CK: 1, CU: 1, EV: 1, ST: 1, SH: 1 };
const SF_STORE_CODE   = /^[A-Z]{2}\d{2,3}$/;  // GT01, PA01, VE100, etc.

const SF_HEADERS = [
  'Fecha', 'País', 'Tienda', 'Código',
  'Merch Group', 'Merch Age Group', 'Rayon Status',
  'Rayon Occ % (Current)', 'Actual Occ % (Current)',
  'Rayon Stock (Current)', 'Warehouse Stock (Current)',
  'Store Net Final LCM Occ %',
  'Last 7 Days Sales', 'Store Cover'
];

const SF_DASHBOARD_TEST_SHEET = 'TEST_Fullness';
const SF_MASTER_REYON_SS_ID   = '1FPb2ll7x1Y_HivI9jcyWNVwaz_OjcUjbNisbbiTlSDM';
const SF_MASTER_REYON_TAB     = 'Master';
const SF_MASTER_CACHE_TTL     = 900;

// Índices en el array de 23 valores de datos tras el Status
// 0: Rayon Occ % LCM Current        6: Actual Occ % LCM Last Night
// 1: Actual Occ % LCM Current       7: Rayon Stock LCM Last Night
// 2: Rayon Stock LCM Current        8: Warehouse Stock LCM Last Night
// 3: Warehouse Stock LCM Current    9: Rayon Occ % UNITS Last Night
// 4: Rayon Occ % UNITS Current     10: Approval Limit
// 5: Rayon Occ % LCM Last Night    11: Total Capacity
// 12: Rayon Capacity               15: Store Net Final LCM Occ %
// 13: Warehouse Capacity           16: Stock On The Way
// 14: Store LCM Occ Exc Reg Wh %   17: Approved Reserve Units
//                                  18: Non-Approved Reserve Units
//                                  19: Transfer IN - OUT
//                                  20: Last 7 Days Sales Units
//                                  21: Store Cover
//                                  22: Sales Forecast 7 Days
const SF_IDX = {
  rayonOccCurrent:    0,
  actualOccCurrent:   1,
  rayonStockCurrent:  2,
  whStockCurrent:     3,
  netFinalLCM:       15,
  last7DaysSales:    20,
  storeCover:        21
};


// ─────────────────────────────────────────────
//  FUNCIÓN PRINCIPAL (producción)
// ─────────────────────────────────────────────

function extractStoreFullness() {
  const today = new Date();
  const dateQuery = Utilities.formatDate(today, Session.getScriptTimeZone(), 'yyyy/MM/dd');
  const query = `from:${SF_SENDER} subject:"Store Occupancy" after:${dateQuery}`;

  const threads = GmailApp.search(query);
  if (threads.length === 0) {
    Logger.log('No se encontraron correos de Store Occupancy para hoy.');
    return;
  }

  const allRows = _processThreads(threads);
  _writeToSheet(allRows);

  Logger.log(`Store Fullness actualizado: ${allRows.length} filas, ${threads.length} países.`);
}


// ─────────────────────────────────────────────
//  FUNCIÓN DE PRUEBA (ejecutar manualmente)
// ─────────────────────────────────────────────

function testStoreFullness() {
  // Busca los últimos 2 días para asegurar captura
  const query = `from:${SF_SENDER} subject:"Store Occupancy" newer_than:2d`;
  const threads = GmailApp.search(query);

  if (threads.length === 0) {
    _notifyStoreFullness('No se encontraron correos en los últimos 2 días.');
    return;
  }

  const allRows = _processThreads(threads);

  // Escribe en hoja de prueba separada para no afectar producción
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  let sheet = ss.getSheetByName('TEST_Fullness');
  if (!sheet) sheet = ss.insertSheet('TEST_Fullness');
  sheet.clearContents();
  sheet.appendRow(SF_HEADERS);

  if (allRows.length > 0) {
    sheet.getRange(2, 1, allRows.length, SF_HEADERS.length).setValues(allRows);
  }

  // Formato visual rápido
  _applySheetFormat(sheet);

  _notifyStoreFullness(
    `Prueba completada. Se encontraron ${threads.length} correos (países) y se extrajeron ${allRows.length} filas. Revisa la pestaña "TEST_Fullness".`
  );
}


// ─────────────────────────────────────────────
//  PROCESAMIENTO DE THREADS
// ─────────────────────────────────────────────

function _processThreads(threads) {
  const allRows = [];

  threads.forEach(thread => {
    thread.getMessages().forEach(message => {
      const subject = message.getSubject();
      const dateMsg  = message.getDate();
      const dateFmt  = Utilities.formatDate(dateMsg, Session.getScriptTimeZone(), 'dd/MM/yyyy');

      // Extrae país del asunto: "Store Occupancy [Alert] Report - [País]"
      const countryMatch = subject.match(/Store Occupancy(?:\s+Alert)?\s+Report\s*[-–]\s*(.+)$/i);
      const country = countryMatch ? countryMatch[1].trim() : 'Unknown';

      const body = message.getPlainBody();
      const rows = _parseEmailBody(body, dateFmt, country);
      allRows.push(...rows);

      Logger.log(`${country}: ${rows.length} filas extraídas`);
    });
  });

  return allRows;
}


// ─────────────────────────────────────────────
//  PARSER DEL CUERPO DEL CORREO
// ─────────────────────────────────────────────

function _parseEmailBody(body, dateFmt, country) {
  const rows = [];

  // Tokenizar: split por líneas, limpiar espacios, filtrar vacíos
  const tokens = body.split(/\r\n|\n/)
    .map(t => t.trim())
    .filter(t => t.length > 0);

  // Encontrar inicio de datos: justo después de la última columna de encabezado
  let dataStart = -1;
  for (let i = 0; i < tokens.length; i++) {
    if (tokens[i].includes('Sales Forecast')) {
      dataStart = i + 1;
      break;
    }
  }
  if (dataStart === -1) {
    Logger.log(`No se encontró inicio de datos para: ${country}`);
    return rows;
  }

  let i = dataStart;
  let currentStore = '';
  let currentCode  = '';
  let currentStoreTotalCaptured = false;

  while (i < tokens.length) {
    const tok = tokens[i];

    // Fin de datos: inicio del pie de página
    if (tok.includes('Reyon Doluluk') || tok.startsWith('___') || tok.includes('LC Waikiki E-Posta')) {
      break;
    }

    // Guardar filas "Total" para usar el fullness total exacto de la tienda.
    if (tok === 'Total') {
      i++;
      if (i < tokens.length && _isStatus(tokens[i])) {
        const status = tokens[i];
        i++;

        const data = [];
        while (data.length < 23 && i < tokens.length && !_isRecognizable(tokens, i)) {
          data.push(tokens[i]);
          i++;
        }

        if (data.length >= 16 && currentStore && currentCode && !currentStoreTotalCaptured) {
          rows.push(_buildStoreFullnessRow(dateFmt, country, currentStore, currentCode, 'TOTAL', 'TOTAL', status, data));
          currentStoreTotalCaptured = true;
        }
      }
      continue;
    }

    // Detectar Store Code (ej: GT01, PA01, VE100)
    if (SF_STORE_CODE.test(tok)) {
      currentCode = tok;
      currentStoreTotalCaptured = false;
      i++;
      continue;
    }

    // Detectar Store Name: el token inmediatamente antes de un Store Code
    if (i + 1 < tokens.length && SF_STORE_CODE.test(tokens[i + 1])) {
      currentStore = tok;
      currentStoreTotalCaptured = false;
      i++;
      continue;
    }

    // Saltar nombre del país si aparece en el cuerpo
    // Venezuela llega como "VENEZUELA, BOLIVARIAN REPUBLIC OF" — usar startsWith
    if (tok.toUpperCase().startsWith(country.toUpperCase())) {
      i++;
      continue;
    }

    // Detectar fila de Merch Group
    if (SF_MERCH_GROUPS[tok]) {
      const merchGroup = tok;
      i++;
      if (i >= tokens.length) break;

      const merchAgeGroup = tokens[i];
      i++;
      if (i >= tokens.length) break;

      const status = tokens[i];
      if (!_isStatus(status)) {
        // EV u otras categorías con datos incompletos — saltar
        continue;
      }
      i++;

      // Recolectar hasta 23 valores de datos
      const data = [];
      while (data.length < 23 && i < tokens.length && !_isRecognizable(tokens, i)) {
        data.push(tokens[i]);
        i++;
      }

      // Solo guardar si tenemos suficientes columnas (al menos hasta Net Final LCM)
      if (data.length >= 16) {
        rows.push(_buildStoreFullnessRow(dateFmt, country, currentStore, currentCode, merchGroup, merchAgeGroup, status, data));
      }
      continue;
    }

    // Detectar fila de Merch Age Group sin Merch Group repetido
    // Ej: CK4 / CU4 pueden venir como segunda línea del mismo grupo en el correo.
    if (_isMerchAgeGroupRow(tokens, i)) {
      const merchAgeGroup = tok;
      const merchGroup = merchAgeGroup.substring(0, 2);
      i++;

      const status = tokens[i];
      i++;

      const data = [];
      while (data.length < 23 && i < tokens.length && !_isRecognizable(tokens, i)) {
        data.push(tokens[i]);
        i++;
      }

      if (data.length >= 16) {
        rows.push(_buildStoreFullnessRow(dateFmt, country, currentStore, currentCode, merchGroup, merchAgeGroup, status, data));
      }
      continue;
    }

    i++;
  }

  return rows;
}


// ─────────────────────────────────────────────
//  HELPERS
// ─────────────────────────────────────────────

function _isStatus(tok) {
  return SF_STATUS_VALS.includes(tok);
}

function _isMerchAgeGroupRow(tokens, i) {
  const tok = tokens[i];
  if (!tok || i + 1 >= tokens.length || !_isStatus(tokens[i + 1])) return false;

  const match = String(tok).match(/^([A-Z]{2})\d+$/);
  return !!(match && SF_MERCH_GROUPS[match[1]]);
}

function _isRecognizable(tokens, i) {
  const tok = tokens[i];
  if (!tok) return true;
  if (tok === 'Total')              return true;
  if (SF_MERCH_GROUPS[tok])         return true;
  if (_isMerchAgeGroupRow(tokens, i)) return true;
  if (SF_STORE_CODE.test(tok))      return true;
  if (tok.includes('Reyon Doluluk')) return true;
  if (tok.startsWith('___'))        return true;
  // El token anterior a un store code es el nombre de tienda
  if (i + 1 < tokens.length && SF_STORE_CODE.test(tokens[i + 1])) return true;
  return false;
}

function _cleanPct(val) {
  if (!val) return '';
  return parseFloat(String(val).replace('%', '').replace(/\s/g, '').replace(',', '.')) || val;
}

function _cleanNum(val) {
  if (!val) return '';
  return parseFloat(String(val).replace(/\./g, '').replace(',', '.')) || val;
}

function _buildStoreFullnessRow(dateFmt, country, store, code, merchGroup, merchAgeGroup, status, data) {
  return [
    dateFmt,
    country,
    store,
    code,
    merchGroup,
    merchAgeGroup,
    status,
    _cleanPct(data[SF_IDX.rayonOccCurrent]),
    _cleanPct(data[SF_IDX.actualOccCurrent]),
    _cleanNum(data[SF_IDX.rayonStockCurrent]),
    _cleanNum(data[SF_IDX.whStockCurrent]),
    _cleanPct(data[SF_IDX.netFinalLCM]),
    _cleanNum(data[SF_IDX.last7DaysSales] || ''),
    _cleanNum(data[SF_IDX.storeCover]     || '')
  ];
}

function _notifyStoreFullness(message) {
  Logger.log(message);

  try {
    SpreadsheetApp.getUi().alert(message);
  } catch (err) {
    // Algunos contextos de ejecución no tienen UI; el Logger queda como salida segura.
  }
}

function getStoreFullnessDashboardData(filters) {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName(SF_DASHBOARD_TEST_SHEET) || ss.getSheetByName(SF_SHEET_NAME);
    if (!sheet || sheet.getLastRow() < 2) {
      return { rows: [], dates: [], sourceSheet: sheet ? sheet.getName() : SF_DASHBOARD_TEST_SHEET };
    }

    const values = sheet.getDataRange().getValues();
    const headers = values[0].map(h => String(h || '').trim());
    const idx = {
      fecha: headers.indexOf('Fecha'),
      pais: headers.indexOf('País'),
      tienda: headers.indexOf('Tienda'),
      codigo: headers.indexOf('Código'),
      merchGroup: headers.indexOf('Merch Group'),
      merchAgeGroup: headers.indexOf('Merch Age Group'),
      status: headers.indexOf('Rayon Status'),
      rayonOcc: headers.indexOf('Rayon Occ % (Current)'),
      actualOcc: headers.indexOf('Actual Occ % (Current)'),
      rayonStock: headers.indexOf('Rayon Stock (Current)'),
      warehouseStock: headers.indexOf('Warehouse Stock (Current)'),
      netFinal: headers.indexOf('Store Net Final LCM Occ %'),
      last7Days: headers.indexOf('Last 7 Days Sales'),
      storeCover: headers.indexOf('Store Cover')
    };

    const targetStore = String((filters && filters.store) || '').trim().toUpperCase();
    const requestedDate = String((filters && filters.date) || '').trim();
    const rows = values.slice(1)
      .filter(r => String(r[idx.codigo] || '').trim())
      .map(r => ({
        fecha: _formatFullnessDate(r[idx.fecha]),
        pais: String(r[idx.pais] || '').trim(),
        tienda: String(r[idx.tienda] || '').trim(),
        codigo: String(r[idx.codigo] || '').trim(),
        merchGroup: String(r[idx.merchGroup] || '').trim(),
        merchAgeGroup: String(r[idx.merchAgeGroup] || '').trim(),
        status: String(r[idx.status] || '').trim(),
        rayonOcc: _toFullnessNumber(r[idx.rayonOcc]),
        actualOcc: _toFullnessNumber(r[idx.actualOcc]),
        rayonStock: _toFullnessNumber(r[idx.rayonStock]),
        warehouseStock: _toFullnessNumber(r[idx.warehouseStock]),
        netFinal: _toFullnessNumber(r[idx.netFinal]),
        last7Days: _toFullnessNumber(r[idx.last7Days]),
        storeCover: _toFullnessNumber(r[idx.storeCover])
      }))
      .filter(r => !targetStore || r.codigo.toUpperCase() === targetStore);

    const dateSet = {};
    rows.forEach(r => { if (r.fecha) dateSet[r.fecha] = true; });
    const dates = Object.keys(dateSet).sort((a, b) => _dateKeyFullness(b) - _dateKeyFullness(a));
    const selectedDate = requestedDate || dates[0] || '';
    const visibleRows = selectedDate ? rows.filter(r => r.fecha === selectedDate) : rows;
    const totalRow = visibleRows.find(r => _isStoreFullnessTotalRow(r)) || null;
    const detailRows = visibleRows.filter(r => !_isStoreFullnessTotalRow(r));
    const stats = _buildFullnessStats(detailRows, totalRow);

    return {
      rows: detailRows,
      totalRow: totalRow,
      dates: dates,
      selectedDate: selectedDate,
      sourceSheet: sheet.getName(),
      store: targetStore,
      stats: stats
    };

  } catch (e) {
    console.error('getStoreFullnessDashboardData error: ' + e.message);
    return { rows: [], dates: [], selectedDate: '', sourceSheet: SF_DASHBOARD_TEST_SHEET, error: e.message };
  }
}

function _buildFullnessStats(rows, totalRow) {
  const stats = {
    totalRows: rows.length,
    totalRayonOcc: '',
    totalActualOcc: '',
    avgActualOcc: 0,
    fullOccupancy: 0,
    emptyAvailable: 0,
    emptyUnavailable: 0,
    rayonStock: 0,
    warehouseStock: 0,
    last7Days: 0,
    avgStoreCover: 0,
    byStatus: {}
  };

  let actualOccSum = 0;
  let actualOccCount = 0;
  let coverSum = 0;
  let coverCount = 0;

  rows.forEach(r => {
    const status = r.status || 'Sin status';
    if (!stats.byStatus[status]) stats.byStatus[status] = 0;
    stats.byStatus[status]++;
    if (status === 'Full Occupancy') stats.fullOccupancy++;
    if (status === 'Empty-Available Stock') stats.emptyAvailable++;
    if (status === 'Empty-Unavailable Stock') stats.emptyUnavailable++;

    if (typeof r.actualOcc === 'number') {
      actualOccSum += r.actualOcc;
      actualOccCount++;
    }
    if (typeof r.storeCover === 'number') {
      coverSum += r.storeCover;
      coverCount++;
    }
    if (typeof r.rayonStock === 'number') stats.rayonStock += r.rayonStock;
    if (typeof r.warehouseStock === 'number') stats.warehouseStock += r.warehouseStock;
    if (typeof r.last7Days === 'number') stats.last7Days += r.last7Days;
  });

  stats.avgActualOcc = actualOccCount ? actualOccSum / actualOccCount : 0;
  stats.totalRayonOcc = totalRow && typeof totalRow.rayonOcc === 'number' ? totalRow.rayonOcc : stats.avgActualOcc;
  stats.totalActualOcc = totalRow && typeof totalRow.actualOcc === 'number' ? totalRow.actualOcc : stats.avgActualOcc;
  if (totalRow && typeof totalRow.rayonStock === 'number') stats.rayonStock = totalRow.rayonStock;
  if (totalRow && typeof totalRow.warehouseStock === 'number') stats.warehouseStock = totalRow.warehouseStock;
  stats.avgStoreCover = coverCount ? coverSum / coverCount : 0;
  return stats;
}

function _isStoreFullnessTotalRow(row) {
  return String(row && row.merchGroup || '').trim().toUpperCase() === 'TOTAL' ||
         String(row && row.merchAgeGroup || '').trim().toUpperCase() === 'TOTAL';
}

function _formatFullnessDate(value) {
  if (value instanceof Date) {
    return Utilities.formatDate(value, Session.getScriptTimeZone(), 'dd/MM/yyyy');
  }
  return String(value || '').trim();
}

function _dateKeyFullness(value) {
  const parts = String(value || '').split('/');
  if (parts.length !== 3) return 0;
  return Number(parts[2] + parts[1].padStart(2, '0') + parts[0].padStart(2, '0')) || 0;
}

function _toFullnessNumber(value) {
  if (value === null || value === undefined || value === '') return '';
  if (typeof value === 'number') return value;
  const raw = String(value).trim();
  if (!raw) return '';
  const parsed = parseFloat(raw.replace(/\./g, '').replace(',', '.').replace('%', ''));
  return isNaN(parsed) ? raw : parsed;
}

function getStoreFullnessDrilldown(storeCode, merchGroup, merchAgeGroup) {
  try {
    const targetStore = String(storeCode || '').trim().toUpperCase();
    const targetGroup = String(merchGroup || '').trim().toUpperCase();
    const targetAge = String(merchAgeGroup || '').trim().toUpperCase();
    if (!targetStore || !targetGroup || !targetAge) return { rows: [], count: 0 };

    const rows = _getFullnessMasterRowsForGroup(targetStore, targetGroup, targetAge);

    return {
      rows: rows,
      count: rows.length,
      storeCode: targetStore,
      merchGroup: targetGroup,
      merchAgeGroup: targetAge
    };
  } catch (e) {
    console.error('getStoreFullnessDrilldown error: ' + e.message);
    return { rows: [], count: 0, error: e.message };
  }
}

function _getFullnessMasterRowsForGroup(storeCode, merchGroup, merchAgeGroup) {
  const cache = CacheService.getScriptCache();
  const cacheKey = ['fullness_master_v2', storeCode, merchGroup, merchAgeGroup].join('_');
  const cached = cache.get(cacheKey);
  if (cached) return JSON.parse(cached);

  const ss = SpreadsheetApp.openById(SF_MASTER_REYON_SS_ID);
  const sheet = ss.getSheetByName(SF_MASTER_REYON_TAB);
  if (!sheet || sheet.getLastRow() < 2) return [];

  const values = sheet.getDataRange().getValues();
  const headers = values[0].map(h => String(h || '').trim());
  const idx = {
    country: headers.indexOf('Country'),
    storeName: headers.indexOf('Store Name'),
    storeCode: headers.indexOf('Store Code'),
    merchGroup: headers.indexOf('Merch Group'),
    merchAgeGroup: headers.indexOf('Merch Age Group'),
    merchBrandAgeGroup: headers.indexOf('Merch Brand Age Group'),
    merchSubGroup: headers.indexOf('Merch Sub Group'),
    category: headers.indexOf('Grupo Categoría'),
    status: headers.indexOf('Rayon Occupancy Status'),
    rayonOcc: headers.indexOf('LCM Rayon Occ %'),
    actualOcc: headers.indexOf('LCM Actual Occ %'),
    rayonStock: headers.indexOf('Rayon Stock'),
    warehouseStock: headers.indexOf('Warehouse Stock'),
    unitsRayonOcc: headers.indexOf('Units Rayon Occ %')
  };

  const rows = values.slice(1)
    .filter(r => String(r[idx.storeCode] || '').trim().toUpperCase() === storeCode)
    .filter(r => String(r[idx.merchGroup] || '').trim().toUpperCase() === merchGroup)
    .filter(r => String(r[idx.merchAgeGroup] || '').trim().toUpperCase() === merchAgeGroup)
    .map(r => ({
      country: String(r[idx.country] || '').trim(),
      storeName: String(r[idx.storeName] || '').trim(),
      storeCode: String(r[idx.storeCode] || '').trim(),
      merchGroup: String(r[idx.merchGroup] || '').trim(),
      merchAgeGroup: String(r[idx.merchAgeGroup] || '').trim(),
      merchBrandAgeGroup: String(r[idx.merchBrandAgeGroup] || '').trim(),
      merchSubGroup: String(r[idx.merchSubGroup] || '').trim(),
      category: String(r[idx.category] || '').trim(),
      status: String(r[idx.status] || '').trim(),
      rayonOcc: _toMasterPercentNumber(r[idx.rayonOcc]),
      actualOcc: _toMasterPercentNumber(r[idx.actualOcc]),
      rayonStock: _toFullnessNumber(r[idx.rayonStock]),
      warehouseStock: _toFullnessNumber(r[idx.warehouseStock]),
      unitsRayonOcc: _toMasterPercentNumber(r[idx.unitsRayonOcc])
    }))
    .filter(r => r.merchBrandAgeGroup || r.merchSubGroup || r.category)
    .filter(_hasUsefulFullnessMetric)
    .sort(_sortFullnessDrilldownRows)
    .slice(0, 1000);

  cache.put(cacheKey, JSON.stringify(rows), SF_MASTER_CACHE_TTL);
  return rows;
}

function _hasUsefulFullnessMetric(row) {
  return _isMeaningfulFullnessValue(row.rayonOcc) ||
         _isMeaningfulFullnessValue(row.actualOcc) ||
         _isMeaningfulFullnessValue(row.rayonStock) ||
         _isMeaningfulFullnessValue(row.warehouseStock) ||
         _isMeaningfulFullnessValue(row.unitsRayonOcc);
}

function _isMeaningfulFullnessValue(value) {
  if (value === null || value === undefined || value === '') return false;
  if (typeof value === 'number') return true;
  const text = String(value).trim();
  return !!text && text !== '—' && text !== '-';
}

function _toMasterPercentNumber(value) {
  if (value === null || value === undefined || value === '') return '';
  if (typeof value === 'number') return Math.abs(value) <= 10 ? value * 100 : value;
  const raw = String(value).trim();
  if (!raw) return '';
  const parsed = parseFloat(raw.replace('%', '').replace(/\s/g, '').replace(',', '.'));
  if (isNaN(parsed)) return raw;
  return raw.indexOf('%') >= 0 ? parsed : (Math.abs(parsed) <= 10 ? parsed * 100 : parsed);
}

function _sortFullnessDrilldownRows(a, b) {
  const statusRank = {
    'Empty-Available Stock': 1,
    'Empty-Unavailable Stock': 2,
    'Full Occupancy': 3
  };
  const rankA = statusRank[a.status] || 9;
  const rankB = statusRank[b.status] || 9;
  if (rankA !== rankB) return rankA - rankB;

  const occA = typeof a.rayonOcc === 'number' ? a.rayonOcc : 9999;
  const occB = typeof b.rayonOcc === 'number' ? b.rayonOcc : 9999;
  if (occA !== occB) return occA - occB;

  return String(a.merchBrandAgeGroup + a.merchSubGroup + a.category)
    .localeCompare(String(b.merchBrandAgeGroup + b.merchSubGroup + b.category));
}


// ─────────────────────────────────────────────
//  ESCRITURA EN HOJA
// ─────────────────────────────────────────────

function _writeToSheet(rows) {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  let sheet = ss.getSheetByName(SF_SHEET_NAME);
  if (!sheet) sheet = ss.insertSheet(SF_SHEET_NAME);

  sheet.clearContents();
  sheet.appendRow(SF_HEADERS);

  if (rows.length > 0) {
    sheet.getRange(2, 1, rows.length, SF_HEADERS.length).setValues(rows);
  }

  _applySheetFormat(sheet);
}

function _applySheetFormat(sheet) {
  // Encabezado
  const headerRange = sheet.getRange(1, 1, 1, SF_HEADERS.length);
  headerRange.setBackground('#1a3a5c').setFontColor('#ffffff').setFontWeight('bold');
  sheet.setFrozenRows(1);
  sheet.setFrozenColumns(4);

  // Ajustar anchos básicos
  sheet.setColumnWidth(1, 90);   // Fecha
  sheet.setColumnWidth(2, 120);  // País
  sheet.setColumnWidth(3, 140);  // Tienda
  sheet.setColumnWidth(4, 80);   // Código
  sheet.setColumnWidth(5, 80);   // Merch Group
  sheet.setColumnWidth(6, 100);  // Merch Age Group
  sheet.setColumnWidth(7, 150);  // Status

  // Colorear status si hay datos
  const lastRow = sheet.getLastRow();
  if (lastRow > 1) {
    const statusCol = 7;
    const statusRange = sheet.getRange(2, statusCol, lastRow - 1, 1);
    const statusVals  = statusRange.getValues();

    statusVals.forEach((row, idx) => {
      const cell = sheet.getRange(idx + 2, statusCol);
      switch (row[0]) {
        case 'Full Occupancy':
          cell.setBackground('#f4cccc').setFontColor('#cc0000');
          break;
        case 'Empty-Available Stock':
          cell.setBackground('#d9ead3').setFontColor('#274e13');
          break;
        case 'Empty-Unavailable Stock':
          cell.setBackground('#fce5cd').setFontColor('#783f04');
          break;
        case 'Low Occupancy':
          cell.setBackground('#fff2cc').setFontColor('#7f6000');
          break;
      }
    });
  }
}


// ─────────────────────────────────────────────
//  TRIGGER DIARIO (ejecutar una sola vez para configurar)
// ─────────────────────────────────────────────

function setupFullnessTrigger() {
  // Elimina triggers anteriores de esta función
  ScriptApp.getProjectTriggers()
    .filter(t => t.getHandlerFunction() === 'extractStoreFullness')
    .forEach(t => ScriptApp.deleteTrigger(t));

  // Crea trigger a las 6:00 AM hora local del script
  ScriptApp.newTrigger('extractStoreFullness')
    .timeBased()
    .everyDays(1)
    .atHour(6)
    .create();

  Logger.log('Trigger diario configurado para las 6:00 AM.');
  SpreadsheetApp.getUi().alert('Trigger configurado: extractStoreFullness correrá diariamente a las 6 AM.');
}
