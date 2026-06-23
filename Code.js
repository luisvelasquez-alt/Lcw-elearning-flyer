/**
 * LC WAIKIKI RETAIL PRO - SYSTEM ARCHITECTURE
 * Core Backend Logic for Daily Entry, Weekly Analysis & Admin Dashboard
 * Multi-country: Costa Rica, Curacao, Dominican Republic, El Salvador, Guatemala, Panamá, Venezuela
 */

// Country mapping used in emails and admin views
const LCW_COUNTRY_MAP = {
  'CR01': 'Costa Rica',
  'CW01': 'Curacao',
  'DO01': 'Dominican Republic', 'DO02': 'Dominican Republic',
  'SV01': 'El Salvador',
  'GT01': 'Guatemala',
  'PA01': 'Panamá', 'PA02': 'Panamá',
  'VE01': 'Venezuela', 'VE02': 'Venezuela', 'VE03': 'Venezuela',
  'VE04': 'Venezuela', 'VE05': 'Venezuela', 'VE06': 'Venezuela', 'VE100': 'Venezuela'
};

const COUNTRY_FLAGS = {
  'Costa Rica': '🇨🇷',
  'Curacao': '🇨🇼',
  'Dominican Republic': '🇩🇴',
  'El Salvador': '🇸🇻',
  'Guatemala': '🇬🇹',
  'Panamá': '🇵🇦',
  'Venezuela': '🇻🇪'
};

const LCW_COUNTRY_ALIASES = {
  'COSTA RICA': 'Costa Rica',
  'CURACAO': 'Curacao',
  'CURAZAO': 'Curacao',
  'DOMINICAN REPUBLIC': 'Dominican Republic',
  'REPUBLICA DOMINICANA': 'Dominican Republic',
  'REPÚBLICA DOMINICANA': 'Dominican Republic',
  'EL SALVADOR': 'El Salvador',
  'GUATEMALA': 'Guatemala',
  'PANAMA': 'Panamá',
  'PANAMÁ': 'Panamá',
  'VENEZUELA': 'Venezuela'
};

function normalizeCountryName_(value) {
  const raw = String(value || '').trim();
  if (!raw) return '';
  const upper = raw.toUpperCase();
  if (LCW_COUNTRY_ALIASES[upper] || LCW_COUNTRY_MAP[upper]) return LCW_COUNTRY_ALIASES[upper] || LCW_COUNTRY_MAP[upper];
  if (/\bVE\b|VENEZUELA/.test(upper)) return 'Venezuela';
  if (/\bPA\b|PANAMA|PANAMÁ/.test(upper)) return 'Panamá';
  if (/\bCR\b|COSTA RICA/.test(upper)) return 'Costa Rica';
  if (/\bCW\b|CURACAO|CURAZAO/.test(upper)) return 'Curacao';
  if (/\bDO\b|DOMINICAN|DOMINICANA/.test(upper)) return 'Dominican Republic';
  if (/\bSV\b|EL SALVADOR/.test(upper)) return 'El Salvador';
  if (/\bGT\b|GUATEMALA/.test(upper)) return 'Guatemala';
  return raw;
}

function getCountryForConfigRow_(row, headers) {
  const storeOrCountry = String(row[0] || '').trim();
  const countryCol = headers
    ? headers.findIndex(h => ['COUNTRY', 'PAIS', 'PAÍS'].includes(String(h || '').trim().toUpperCase()))
    : -1;
  return normalizeCountryName_(
    countryCol >= 0 ? row[countryCol] : (LCW_COUNTRY_MAP[storeOrCountry.toUpperCase()] || storeOrCountry)
  );
}

function doGet(e) {
  if (e && e.parameter && e.parameter.page === 'manual') {
    const html = HtmlService.createHtmlOutputFromFile('Manual').getContent();
    return ContentService.createTextOutput(html)
      .setMimeType(ContentService.MimeType.HTML);
  }
  return HtmlService.createTemplateFromFile('Index')
      .evaluate()
      .setTitle('LC Waikiki Retail Pro')
      .setFaviconUrl('https://res.cloudinary.com/dowuskauz/image/upload/w_192,h_192,c_fill/v1778940270/lc-waikiki-apple-touch-icon_rophvw.png')
      .addMetaTag('viewport', 'width=device-width, initial-scale=1')
      .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL);
}

function getManualHtml() {
  return HtmlService.createHtmlOutputFromFile('Manual').getContent();
}

function include(filename) {
  return HtmlService.createHtmlOutputFromFile(filename).getContent();
}

function getHtmlContent(filename) {
  return HtmlService.createTemplateFromFile(filename).evaluate().getContent();
}

/**
 * AUTHENTICATION: Validates against 'Config' tab including Role (Col E).
 * Passwords can be stored as "sha256$<hex>" or "sha256<hex>". Plain text is
 * still accepted once and then upgraded automatically.
 */
function authenticateUser(storeName, password) {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheet = ss.getSheetByName("Config");
  const data = sheet.getDataRange().getValues();
  const passStr = String(password || "").trim();
  const headers = data[0] || [];
  const incomingHash = _hashPassword_(storeName, passStr);
  const incomingLegacyHash = _hashPasswordLegacy_(passStr);

  for (let i = 1; i < data.length; i++) {
    // data[i][0]=Store, [1]=Pass, [2]=Email, [3]=Status, [4]=Rol
    if (String(data[i][0] || "").trim() !== String(storeName || "").trim()) continue;

    const stored = String(data[i][1] || "").trim();
    const storedHash = _normalizePasswordHash_(stored);
    const isHash = Boolean(storedHash);
    const match = isHash
      ? (storedHash === incomingHash || storedHash === incomingLegacyHash)
      : (stored === passStr);

    if (!match) continue;
    if (!String(data[i][3] || "").toLowerCase().includes("active")) break;

    if (!isHash || stored !== incomingHash) {
      sheet.getRange(i + 1, 2).setValue(incomingHash);
    }

    const role = String(data[i][4] || "STORE").trim().toUpperCase();
    return {
      success: true,
      store: data[i][0],
      role: role,
      country: role === 'RETAIL' ? getCountryForConfigRow_(data[i], headers) : (LCW_COUNTRY_MAP[String(data[i][0] || '').trim().toUpperCase()] || '')
    };
  }
  return { success: false, message: "Credenciales inválidas o cuenta inactiva." };
}

function _hashPassword_(storeName, passStr) {
  const salt = String(storeName || "").trim().toUpperCase();
  return _sha256Hex_("sha256$", salt + "::" + passStr);
}

function _hashPasswordLegacy_(passStr) {
  return _sha256Hex_("sha256$", passStr);
}

function _sha256Hex_(prefix, value) {
  const bytes = Utilities.computeDigest(
    Utilities.DigestAlgorithm.SHA_256,
    value,
    Utilities.Charset.UTF_8
  );
  let hex = "";
  for (let i = 0; i < bytes.length; i++) {
    const b = (bytes[i] + 256) % 256;
    hex += (b < 16 ? "0" : "") + b.toString(16);
  }
  return prefix + hex;
}

function _normalizePasswordHash_(value) {
  const stored = String(value || "").trim().toLowerCase();
  if (stored.indexOf("sha256$") === 0 && stored.length === 71) return stored;
  if (stored.indexOf("sha256") === 0 && stored.length === 70) {
    return "sha256$" + stored.slice(6);
  }
  return "";
}

function migrateConfigPasswordsToHash() {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheet = ss.getSheetByName("Config");
  const data = sheet.getDataRange().getValues();
  let migrated = 0;

  for (let i = 1; i < data.length; i++) {
    const store = data[i][0];
    const stored = String(data[i][1] || "").trim();
    if (!store || !stored) continue;

    const normalizedHash = _normalizePasswordHash_(stored);
    if (normalizedHash) {
      if (stored !== normalizedHash) {
        sheet.getRange(i + 1, 2).setValue(normalizedHash);
        migrated++;
      }
      continue;
    }

    const hash = _hashPassword_(store, stored);
    sheet.getRange(i + 1, 2).setValue(hash);
    migrated++;
  }
  Logger.log("Contraseñas migradas a hash: %s", migrated);
  return migrated;
}

/**
 * DYNAMIC INDEXING: Finds the starting column in Row 2 (Merged Cells)
 * Daily Sales: 6 cols per store — Ventas, Unidades, Tickets, Tráfico, Stock ICG, Stock RS
 * Dept Daily:  5 cols per store — BG, BU, CK, CU, ST
 */
function getStoreDataMap(storeName, sheetName) {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheet = ss.getSheetByName(sheetName);
  if (!sheet) return null;

  const lastCol = sheet.getLastColumn();
  if (lastCol < 1) return null;

  const storeRow = sheet.getRange(2, 1, 1, lastCol).getValues()[0];
  const target = String(storeName).trim().toUpperCase();

  let colIndex = -1;
  for (let i = 0; i < storeRow.length; i++) {
    if (String(storeRow[i] || "").trim().toUpperCase() === target) {
      colIndex = i + 1;
      break;
    }
  }

  if (colIndex === -1) return null;

  // Daily Sales / LY — 6 columns per store
  if (sheetName === "Daily Sales" || sheetName === "LY") {
    return {
      startCol:    colIndex,
      ventasCol:   colIndex,
      unidadesCol: colIndex + 1,
      ticketsCol:  colIndex + 2,
      traficoCol:  colIndex + 3,
      stockICGCol: colIndex + 4,
      stockRSCol:  colIndex + 5
    };
  }

  // Dept Daily / Dept LY — 5 columns per store (BG, BU, CK, CU, ST)
  return {
    startCol: colIndex,
    bg: colIndex,
    bu: colIndex + 1,
    ck: colIndex + 2,
    cu: colIndex + 3,
    st: colIndex + 4
  };
}

/**
 * ADMIN ENGINE: Regional data consolidation for all stores
 */
function getRegionalData(weekNumber, country) {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheetDS = ss.getSheetByName("Daily Sales");
    const dataDS = sheetDS.getDataRange().getValues();

    const targetWeek = parseInt(String(weekNumber).replace(/\D/g, ''));
    const targetYear = getRetailYear_();
    const today = new Date();
    const todayWeek = getExactWeekNum(today);
    const currentDayNum = getRetailDayOfWeek_(today);
    const cutoffDayNum = targetWeek === todayWeek ? Math.max(currentDayNum - 1, 0) : 7;

    const storeNamesRow = dataDS[1];
    let storeSummary   = {};
    let storeSummaryLY = {};
    let globalVentas   = 0;

    const cleanNum = (val) => {
      if (val === null || val === undefined || val === "") return 0;
      if (typeof val === 'number') return val;
      let s = String(val).trim().replace(/\$/g, "").replace(/\s/g, "");
      if (s.includes(".") && s.includes(",")) {
        s = s.replace(/\./g, "").replace(",", ".");
      } else if (s.includes(",") && !s.includes(".")) {
        s = s.replace(",", ".");
      } else {
        s = s.replace(/,/g, "");
      }
      return parseFloat(s) || 0;
    };

    for (let i = 4; i < dataDS.length; i++) {
      let rowYear = parseInt(dataDS[i][0]);
      let rowWeek = parseInt(dataDS[i][2]);
      let rowDay  = parseInt(dataDS[i][3]);
      let cellDesc = String(dataDS[i][2] || "");

      if (rowYear === targetYear && rowWeek === targetWeek && rowDay <= cutoffDayNum && !cellDesc.toUpperCase().includes("TOTAL")) {
        // 6 columns per store: Ventas, Unidades, Tickets, Tráfico, Stock ICG, Stock RS
        for (let col = 5; col < dataDS[i].length; col += 6) {
          let storeName = storeNamesRow[col];
          if (storeName && String(storeName).trim() !== "") {
            const cleanStore = String(storeName).trim();
            if (!storeSummary[cleanStore]) {
              storeSummary[cleanStore] = { v: 0, u: 0, t: 0, tr: 0 };
            }
            storeSummary[cleanStore].v  += cleanNum(dataDS[i][col]);
            storeSummary[cleanStore].u  += cleanNum(dataDS[i][col + 1]);
            storeSummary[cleanStore].t  += cleanNum(dataDS[i][col + 2]);
            storeSummary[cleanStore].tr += cleanNum(dataDS[i][col + 3]);
          }
        }
      }
    }

    // Read LY sheet for comp calculations
    try {
      const sheetLY = ss.getSheetByName("LY");
      if (sheetLY) {
        const dataLY = sheetLY.getDataRange().getValues();
        const storeNamesRowLY = dataLY[1] || [];
        for (let j = 2; j < dataLY.length; j++) {
          const rowWeekLY = parseInt(String(dataLY[j][2]).replace(/\D/g, ''), 10);
          const rowDayLY  = parseInt(dataLY[j][3], 10);
          const rowDescLY = String(dataLY[j][2] || "").toUpperCase();
          if (rowWeekLY === targetWeek && rowDayLY <= cutoffDayNum && !rowDescLY.includes("TOTAL")) {
            for (let col = 5; col < dataLY[j].length; col += 6) {
              const storeName = storeNamesRowLY[col];
              if (storeName && String(storeName).trim() !== "") {
                const cleanStore = String(storeName).trim();
                if (!storeSummaryLY[cleanStore]) {
                  storeSummaryLY[cleanStore] = { v: 0, u: 0, t: 0, tr: 0 };
                }
                storeSummaryLY[cleanStore].v  += cleanNum(dataLY[j][col]);
                storeSummaryLY[cleanStore].u  += cleanNum(dataLY[j][col + 1]);
                storeSummaryLY[cleanStore].t  += cleanNum(dataLY[j][col + 2]);
                storeSummaryLY[cleanStore].tr += cleanNum(dataLY[j][col + 3]);
              }
            }
          }
        }
      }
    } catch (eLY) {
      console.warn("getRegionalData LY error: " + eLY.message);
    }

    const getComp = (ty, ly) => ly > 0 ? ((ty - ly) / ly) * 100 : null;

    let totalU_Global = 0;
    let totalT_Global = 0;

    // Cuando se pasa un país (rol RETAIL) solo se incluyen sus tiendas
    const countryFilter = normalizeCountryName_(country);

    let finalStores = Object.keys(storeSummary)
      .filter(name => !countryFilter || normalizeCountryName_(LCW_COUNTRY_MAP[String(name || '').trim().toUpperCase()]) === countryFilter)
      .map(name => {
        const s  = storeSummary[name];
        const ly = storeSummaryLY[name] || { v: 0, u: 0, t: 0, tr: 0 };
        globalVentas  += s.v;
        totalU_Global += s.u;
        totalT_Global += s.t;

        const apt = s.t > 0 ? (s.v / s.t) : 0;
        const aur = s.u > 0 ? (s.v / s.u) : 0;

        return {
          name:     name,
          country:  LCW_COUNTRY_MAP[String(name || '').trim().toUpperCase()] || '',
          ventas:   s.v,
          unidades: s.u,
          tickets:  s.t,
          trafico:  s.tr,
          upt:   s.t  > 0 ? (s.u / s.t).toFixed(2) : "0.00",
          apt:   apt.toFixed(2),
          aur:   aur.toFixed(2),
          conv:  s.tr > 0 ? ((s.t / s.tr) * 100).toFixed(1) : "0.0",
          compV:  getComp(s.v,  ly.v),
          compU:  getComp(s.u,  ly.u),
          compTr: getComp(s.tr, ly.tr)
        };
      }).filter(s => s.ventas > 0);

    return {
      totalVentas: globalVentas,
      avgUPT: totalT_Global > 0 ? (totalU_Global / totalT_Global).toFixed(2) : "0.00",
      meta: {
        mode: targetWeek === todayWeek ? "CLOSED_DAYS" : "FULL_WEEK",
        cutoffDay: cutoffDayNum
      },
      stores: finalStores.sort((a, b) => b.unidades - a.unidades || b.ventas - a.ventas)
    };

  } catch (e) {
    console.error("Error en getRegionalData: " + e.message);
    return { totalVentas: 0, avgUPT: "0.00", stores: [], error: e.message };
  }
}

const RETAIL_TIMEZONE = "America/Caracas";

function getRetailDate_(dateParam) {
  const rawDate = dateParam ? new Date(dateParam) : new Date();
  const parts = Utilities.formatDate(rawDate, RETAIL_TIMEZONE, "yyyy-MM-dd").split("-");
  return new Date(Date.UTC(Number(parts[0]), Number(parts[1]) - 1, Number(parts[2])));
}

function getRetailYear_(dateParam) {
  return Number(Utilities.formatDate(dateParam ? new Date(dateParam) : new Date(), RETAIL_TIMEZONE, "yyyy"));
}

function getRetailDayOfWeek_(dateParam) {
  const day = getRetailDate_(dateParam).getUTCDay();
  return day === 0 ? 7 : day;
}

function getFeedbackRowYear_(timestamp) {
  if (!timestamp) return null;
  const d = timestamp instanceof Date ? timestamp : new Date(timestamp);
  return isNaN(d.getTime()) ? null : getRetailYear_(d);
}

/**
 * Week number calculator — ISO-8601 style using Venezuela's local date.
 */
function getExactWeekNum(dateParam) {
  try {
    var d = getRetailDate_(dateParam);
    d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7));
    var yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
    var weekNo = Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
    return weekNo;
  } catch (e) {
    console.error("Error en getExactWeekNum: " + e.message);
    return 15;
  }
}

/**
 * WEEKLY ANALYSIS: TY vs LY with multi-store protection
 */
function getWeeklySummary(storeName, weekNumber) {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const targetWeek = parseInt(String(weekNumber).replace(/\D/g, ''), 10);

    const isRegionalView = ["ADMIN", "GLOBAL"].includes(String(storeName || "").toUpperCase().trim());

    const today = new Date();
    const todayWeek = getExactWeekNum(today);
    const currentDayNum = getRetailDayOfWeek_(today);
    const cutoffDayNum = (targetWeek === todayWeek) ? currentDayNum : 7;

    const targetYear = getRetailYear_();
    const sheetDS = ss.getSheetByName("Daily Sales");
    const dataDS = sheetDS.getDataRange().getValues();
    const storeRow = dataDS[1];

    const sheetLY = ss.getSheetByName("LY");
    const dataLY = sheetLY.getDataRange().getValues();
    const storeRowLY = dataLY[1] || [];

    let mapDS = null;
    let mapLY = null;
    if (!isRegionalView) {
      mapDS = getStoreDataMap(storeName, "Daily Sales");
      mapLY = getStoreDataMap(storeName, "LY");
      if (!mapDS || !mapLY) {
        console.warn("No se encontró mapa de columnas para: " + storeName);
        return null;
      }
    }

    let cur = { v: 0, u: 0, t: 0, tr: 0 };
    let ly  = { v: 0, u: 0, t: 0, tr: 0 };
    let found = false;

    for (let i = 4; i < dataDS.length; i++) {
      const rowYear = parseInt(dataDS[i][0], 10);
      const rowWeek = parseInt(String(dataDS[i][2]).replace(/\D/g, ''), 10);
      const rowDay  = parseInt(dataDS[i][3], 10);
      const rowDesc = String(dataDS[i][2] || "").toUpperCase();

      if (rowYear === targetYear && rowWeek === targetWeek && rowDay <= cutoffDayNum && !rowDesc.includes("TOTAL")) {
        if (isRegionalView) {
          for (let col = 5; col < dataDS[i].length; col += 6) {
            if (storeRow[col]) {
              cur.v  += Number(dataDS[i][col])     || 0;
              cur.u  += Number(dataDS[i][col + 1]) || 0;
              cur.t  += Number(dataDS[i][col + 2]) || 0;
              cur.tr += Number(dataDS[i][col + 3]) || 0;
            }
          }
        } else {
          cur.v  += Number(dataDS[i][mapDS.ventasCol   - 1]) || 0;
          cur.u  += Number(dataDS[i][mapDS.unidadesCol - 1]) || 0;
          cur.t  += Number(dataDS[i][mapDS.ticketsCol  - 1]) || 0;
          cur.tr += Number(dataDS[i][mapDS.traficoCol  - 1]) || 0;
        }
        found = true;
      }
    }

    for (let j = 2; j < dataLY.length; j++) {
      const rowWeekLY = parseInt(String(dataLY[j][2]).replace(/\D/g, ''), 10);
      const rowDayLY  = parseInt(dataLY[j][3], 10);
      const rowDescLY = String(dataLY[j][2] || "").toUpperCase();

      if (rowWeekLY === targetWeek && rowDayLY <= cutoffDayNum && !rowDescLY.includes("TOTAL")) {
        if (isRegionalView) {
          for (let col = 5; col < dataLY[j].length; col += 6) {
            if (storeRowLY[col]) {
              ly.v  += Number(dataLY[j][col])     || 0;
              ly.u  += Number(dataLY[j][col + 1]) || 0;
              ly.t  += Number(dataLY[j][col + 2]) || 0;
              ly.tr += Number(dataLY[j][col + 3]) || 0;
            }
          }
        } else {
          ly.v  += Number(dataLY[j][mapLY.ventasCol   - 1]) || 0;
          ly.u  += Number(dataLY[j][mapLY.unidadesCol - 1]) || 0;
          ly.t  += Number(dataLY[j][mapLY.ticketsCol  - 1]) || 0;
          ly.tr += Number(dataLY[j][mapLY.traficoCol  - 1]) || 0;
        }
      }
    }

    if (!found) return null;

    const getComp = (act, ant) => ant !== 0 ? ((act / ant) - 1) * 100 : 0;

    const curUPT  = cur.t > 0 ? cur.u / cur.t : 0;
    const curAPT  = cur.t > 0 ? cur.v / cur.t : 0;
    const curConv = cur.tr > 0 ? (cur.t / cur.tr) * 100 : 0;

    const lyUPT  = ly.t > 0 ? ly.u / ly.t : 0;
    const lyAPT  = ly.t > 0 ? ly.v / ly.t : 0;
    const lyConv = ly.tr > 0 ? (ly.t / ly.tr) * 100 : 0;

    return {
      ventas:   { actual: cur.v, ly: ly.v, comp: getComp(cur.v, ly.v) },
      unidades: { actual: cur.u, ly: ly.u, comp: getComp(cur.u, ly.u) },
      tickets:  { actual: cur.t, ly: ly.t, comp: getComp(cur.t, ly.t) },
      trafico:  { actual: cur.tr, ly: ly.tr, comp: getComp(cur.tr, ly.tr) },
      upt:      { actual: curUPT, comp: getComp(curUPT, lyUPT) },
      apt:      { actual: curAPT, comp: getComp(curAPT, lyAPT) },
      conv:     { actual: curConv, comp: getComp(curConv, lyConv) },
      meta: {
        mode: targetWeek === todayWeek ? "WTD" : "FULL_WEEK",
        cutoffDay: cutoffDayNum
      }
    };

  } catch (e) {
    console.error("Error crítico en WeeklySummary: " + e.message);
    return null;
  }
}

/**
 * DAILY SUBMISSION
 * Saves 6 KPI fields (incl. dual stock) + 5 dept fields (BG/BU/CK/CU/ST)
 */
function submitDailyMetrics(store, dateStr, metrics, deptMetrics) {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const mapDS   = getStoreDataMap(store, "Daily Sales");
    const mapDept = getStoreDataMap(store, "Dept Daily");

    if (!mapDS) throw new Error("No se encontró la columna para " + store + " en Daily Sales.");

    const sheetDS = ss.getSheetByName("Daily Sales");
    const dataDS = sheetDS.getDataRange().getValues();
    const targetDateStr = String(dateStr).trim();
    let rowIndex = -1;

    for (let i = 0; i < dataDS.length; i++) {
      let cell = dataDS[i][4];
      if (!cell) continue;
      let sheetDateStr = (cell instanceof Date)
        ? Utilities.formatDate(cell, ss.getSpreadsheetTimeZone(), "yyyy-MM-dd")
        : String(cell).trim().substring(0, 10);
      if (sheetDateStr === targetDateStr) { rowIndex = i + 1; break; }
    }

    if (rowIndex === -1) throw new Error("Fecha no encontrada en el calendario.");

    // 6 values: Ventas, Unidades, Tickets, Tráfico, Stock ICG, Stock RS
    sheetDS.getRange(rowIndex, mapDS.startCol, 1, 6).setValues([[
      Number(metrics.ventas)    || 0,
      Number(metrics.unidades)  || 0,
      Number(metrics.tickets)   || 0,
      Number(metrics.trafico)   || 0,
      Number(metrics.stockICG)  || 0,
      Number(metrics.stockRS)   || 0
    ]]);

    // 5 dept values: BG, BU, CK, CU, ST
    if (mapDept) {
      const sheetDept = ss.getSheetByName("Dept Daily");
      sheetDept.getRange(rowIndex, mapDept.startCol, 1, 5).setValues([[
        Number(deptMetrics.bg) || 0,
        Number(deptMetrics.bu) || 0,
        Number(deptMetrics.ck) || 0,
        Number(deptMetrics.cu) || 0,
        Number(deptMetrics.st) || 0
      ]]);
    }

    return { success: true };
  } catch (e) {
    return { success: false, message: e.message };
  }
}

/**
 * MEDIA & FEEDBACK
 */
function saveFileToDrive(base64Data, fileName) {
  try {
    const folder = DriveApp.getFoldersByName("LCW_Retail_Uploads").hasNext()
      ? DriveApp.getFoldersByName("LCW_Retail_Uploads").next()
      : DriveApp.createFolder("LCW_Retail_Uploads");
    const bytes = Utilities.base64Decode(base64Data.split(',')[1]);
    const file  = folder.createFile(Utilities.newBlob(bytes, base64Data.substring(5, base64Data.indexOf(';')), fileName));
    file.setSharing(DriveApp.Access.ANYONE_WITH_LINK, DriveApp.Permission.VIEW);
    return file.getUrl();
  } catch (e) { return "Error: " + e.toString(); }
}

function saveStoreFeedback(feedbackData) {
  const lock = LockService.getDocumentLock();
  try {
    lock.waitLock(10000);
    const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Feedback")
      || SpreadsheetApp.getActiveSpreadsheet().insertSheet("Feedback");
    if (sheet.getLastRow() === 0) sheet.appendRow(["Timestamp", "Tienda", "Semana", "Diagnóstico", "Plan de Acción", "Usuario"]);
    const now = new Date();
    const targetStore = String(feedbackData.store || "").trim();
    const targetWeek = String(feedbackData.week || "").trim();
    const targetYear = getRetailYear_(now);
    const lastRow = sheet.getLastRow();
    if (lastRow > 1) {
      const data = sheet.getRange(2, 1, lastRow - 1, 6).getValues();
      for (let i = data.length - 1; i >= 0; i--) {
        const rowStore = String(data[i][1] || "").trim();
        const rowWeek = String(data[i][2] || "").trim();
        if (rowStore === targetStore && rowWeek === targetWeek && getFeedbackRowYear_(data[i][0]) === targetYear) {
          sheet.getRange(i + 2, 1, 1, 6).setValues([[now, targetStore, targetWeek, feedbackData.diagnostico, feedbackData.accion, feedbackData.user || "Manager"]]);
          return { success: true, updated: true };
        }
      }
    }
    sheet.appendRow([now, targetStore, targetWeek, feedbackData.diagnostico, feedbackData.accion, feedbackData.user || "Manager"]);
    return { success: true, updated: false };
  } catch (e) { return { success: false, error: e.message }; }
  finally {
    try { lock.releaseLock(); } catch (err) {}
  }
}

function getSavedFeedback(store, week) {
  try {
    const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Feedback");
    if (!sheet) return null;
    const data = sheet.getDataRange().getValues();
    for (let i = data.length - 1; i >= 1; i--) {
      if (data[i][1] === store && String(data[i][2]) === String(week)) {
        return { diagnostico: data[i][3], accion: data[i][4] };
      }
    }
    return null;
  } catch (e) { return null; }
}

/**
 * AI INTEGRATION: OpenAI GPT-4o-mini
 */
function getGeminiTips(stats, contexto) {
  try {
    const apiKey = PropertiesService.getScriptProperties().getProperty('OPENAI_API_KEY');
    if (!apiKey) return "Error IA: Falta configurar OPENAI_API_KEY.";

    const url = "https://api.openai.com/v1/chat/completions";
    const uptComp   = Number(stats?.upt?.comp   || 0);
    const convComp  = Number(stats?.conv?.comp  || 0);
    const aptComp   = Number(stats?.apt?.comp   || 0);
    const ventasComp= Number(stats?.ventas?.comp|| 0);
    const trafComp  = Number(stats?.trafico?.comp|| 0);

    const uptActual  = Number(stats?.upt?.actual  || 0).toFixed(2);
    const convActual = Number(stats?.conv?.actual || 0).toFixed(1);
    const aptActual  = Number(stats?.apt?.actual  || 0).toFixed(2);

    const status = (v) => v >= 0 ? "SUBE" : "BAJA";
    const sign   = (v) => v >= 0 ? `+${v.toFixed(1)}%` : `${v.toFixed(1)}%`;

    const prompt = `
Eres un experto en Operaciones de Retail de Moda. Tu tarea es diagnosticar el desempeño de una tienda esta semana.

IMPORTANTE — cómo leer los datos:
Cada KPI tiene DOS datos separados:
  1. VALOR ACTUAL: el número real de esta semana.
  2. TENDENCIA vs año anterior: si creció o cayó comparado con la misma semana del año pasado.

Una tendencia positiva (SUBE) significa que el KPI MEJORÓ este año. No es un objetivo ni un problema — es una mejora real.
Una tendencia negativa (BAJA) significa que el KPI EMPEORÓ vs el año pasado. Ese es el problema a diagnosticar.

KPIs DE ESTA SEMANA:
| KPI          | Valor actual esta semana | Tendencia vs año anterior |
|--------------|--------------------------|--------------------------|
| Ventas       | —                        | ${status(ventasComp)} ${sign(ventasComp)} |
| UPT          | ${uptActual} unid/ticket  | ${status(uptComp)} ${sign(uptComp)} |
| Conversión   | ${convActual}%            | ${status(convComp)} ${sign(convComp)} |
| APT          | $${aptActual}/ticket      | ${status(aptComp)} ${sign(aptComp)} |
| Tráfico      | —                        | ${status(trafComp)} ${sign(trafComp)} |

Contexto operativo de la semana: ${contexto || "Sin contexto adicional."}

CONTEXTO DE MARCA:
LC Waikiki opera bajo un modelo de reposición por niveles de fullness. El piso de ventas debe mantenerse siempre lleno; los quiebres de stock visibles o anaqueles con baja densidad de producto son la principal causa de pérdida de ventas y UPT bajo. Toda acción debe considerar esto.

DIAGNÓSTICO: Identifica SOLO los KPIs que muestran BAJA como problemas. Los que muestran SUBE son fortalezas, no los menciones como fallas. Si todos suben, reconoce el buen desempeño y enfoca las acciones en sostener el momentum.

RIESGO [ALTO / MEDIO / BAJO]: Basado únicamente en los KPIs con BAJA. Si no hay bajas, asigna BAJO.

ACCIONES: 3 pasos concretos y ejecutables para el equipo en el próximo turno. UNA de las 3 acciones debe ser siempre: revisar los niveles de fullness en el piso para identificar áreas con baja densidad de producto y ejecutar reposición inmediata desde bodega.

Restricciones: No menciones precios, promociones ni decisiones de casa matriz. Máximo 140 palabras. Responde en español.
`;

    const payload = {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: prompt }],
      max_tokens: 300
    };

    const response = UrlFetchApp.fetch(url, {
      method: "post",
      contentType: "application/json",
      headers: { "Authorization": "Bearer " + apiKey },
      payload: JSON.stringify(payload),
      muteHttpExceptions: true
    });

    const statusCode = response.getResponseCode();
    const resJson = JSON.parse(response.getContentText());

    if (statusCode < 200 || statusCode >= 300) {
      return "Error IA: " + (resJson?.error?.message || "No se pudo generar la estrategia.");
    }

    const text = resJson?.choices?.[0]?.message?.content;
    return text ? text.trim() : "Error IA: La respuesta vino vacía.";

  } catch (e) {
    return "Error IA: " + e.message;
  }
}

function getActiveStoreNames() {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("Config");
    if (!sheet) throw new Error("Hoja Config no encontrada");
    const data = sheet.getDataRange().getValues();
    return data.slice(1)
      .filter(r => {
        const role = String(r[4] || 'STORE').trim().toUpperCase();
        return r[0] && r[3] && String(r[3]).toLowerCase().includes("active") &&
               role !== 'ADMIN' && role !== 'RETAIL';
      })
      .map(r => String(r[0]).trim());
  } catch (e) {
    console.error("Error en getActiveStoreNames: " + e.message);
    return [];
  }
}

/**
 * Returns store codes in Config that belong to a given country name.
 * Used by RETAIL role users to get their allowed stores.
 */
function getStoreNamesByCountry(country) {
  try {
    const normalizedCountry = normalizeCountryName_(country);
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("Config");
    if (!sheet) throw new Error("Hoja Config no encontrada");
    const data = sheet.getDataRange().getValues();
    return data.slice(1)
      .filter(r => {
        const role   = String(r[4] || 'STORE').trim().toUpperCase();
        const status = String(r[3] || '').toLowerCase();
        const name   = String(r[0] || '').trim();
        return name && status.includes('active') &&
               role !== 'ADMIN' && role !== 'RETAIL' &&
               normalizeCountryName_(LCW_COUNTRY_MAP[name.toUpperCase()]) === normalizedCountry;
      })
      .map(r => String(r[0]).trim());
  } catch (e) {
    console.error("Error en getStoreNamesByCountry: " + e.message);
    return [];
  }
}

function getCurrentSystemWeek() {
  return getExactWeekNum(new Date());
}

/**
 * HYBRID LOAD (TY + LY + BUDGET)
 */
function getStoreDataForDate(storeName, dateStr) {
  try {
    const lyData     = getLYDataForDate(storeName, dateStr);
    const budgetData = getDailyBudget(storeName, dateStr);
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const timezone = ss.getSpreadsheetTimeZone();
    const targetDateStr = String(dateStr).trim();

    const sheetDS = ss.getSheetByName("Daily Sales");
    const dataDS  = sheetDS.getDataRange().getValues();
    const mapTY   = getStoreDataMap(storeName, "Daily Sales");

    let tyData = { ventas: "", unidades: "", tickets: "", trafico: "", stockICG: "", stockRS: "" };

    if (mapTY) {
      for (let i = 4; i < dataDS.length; i++) {
        const row = dataDS[i];
        const fechaCelda = row[4];
        if (!fechaCelda || String(row[2] || "").toUpperCase().includes("TOTAL")) continue;

        let currentSheetDateStr = (fechaCelda instanceof Date)
          ? Utilities.formatDate(fechaCelda, timezone, "yyyy-MM-dd")
          : String(fechaCelda).trim().substring(0, 10);

        if (currentSheetDateStr === targetDateStr) {
          tyData = {
            ventas:   row[mapTY.ventasCol   - 1] ?? "",
            unidades: row[mapTY.unidadesCol - 1] ?? "",
            tickets:  row[mapTY.ticketsCol  - 1] ?? "",
            trafico:  row[mapTY.traficoCol  - 1] ?? "",
            stockICG: row[mapTY.stockICGCol - 1] ?? "",
            stockRS:  row[mapTY.stockRSCol  - 1] ?? ""
          };
          break;
        }
      }
    }

    const sheetDept = ss.getSheetByName("Dept Daily");
    let tyDept = { bg: "", bu: "", ck: "", cu: "", st: "" };
    const mapDept = getStoreDataMap(storeName, "Dept Daily");

    if (sheetDept && mapDept) {
      const dataDept = sheetDept.getDataRange().getValues();
      for (let i = 4; i < dataDept.length; i++) {
        const row = dataDept[i];
        const fechaCelda = row[4];
        if (!fechaCelda) continue;
        let currentSheetDateStr = (fechaCelda instanceof Date)
          ? Utilities.formatDate(fechaCelda, timezone, "yyyy-MM-dd")
          : String(fechaCelda).trim().substring(0, 10);
        if (currentSheetDateStr === targetDateStr) {
          tyDept = {
            bg: row[mapDept.bg - 1] || "",
            bu: row[mapDept.bu - 1] || "",
            ck: row[mapDept.ck - 1] || "",
            cu: row[mapDept.cu - 1] || "",
            st: row[mapDept.st - 1] || ""
          };
          break;
        }
      }
    }

    return { ly: lyData, ty: tyData, tyDept: tyDept, lyDept: lyData, budget: budgetData };
  } catch (e) {
    console.error("Error en getStoreDataForDate: " + e.message);
    return { ly: {}, ty: {}, tyDept: {}, budget: {} };
  }
}

/**
 * LY LOOKUP: returns KPIs + dual stock + 5 dept fields for a given date
 */
function getLYDataForDate(storeName, dateStr) {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheetLY = ss.getSheetByName("LY");
    const dataLY  = sheetLY.getDataRange().getValues();
    const mapLY   = getStoreDataMap(storeName, "LY");

    const sheetDeptLY = ss.getSheetByName("Dept LY");
    const dataDeptLY  = sheetDeptLY.getDataRange().getValues();

    const storeHeaderRow = dataDeptLY[1];
    let deptStartCol = -1;
    for (let i = 0; i < storeHeaderRow.length; i++) {
      if (String(storeHeaderRow[i]).trim().toUpperCase() === storeName.toUpperCase()) {
        deptStartCol = i;
        break;
      }
    }

    const parts   = dateStr.split('-');
    const dateObj = new Date(parts[0], parts[1] - 1, parts[2]);
    dateObj.setHours(0,0,0,0);

    const targetWeek   = getExactWeekNum(dateObj);
    const dayJS        = dateObj.getDay();
    const targetDayNum = (dayJS === 0) ? 7 : dayJS;

    let result = {
      ventas: 0, unidades: 0, tickets: 0, trafico: 0,
      stockICG: 0, stockRS: 0,
      bg: 0, bu: 0, ck: 0, cu: 0, st: 0
    };

    if (mapLY) {
      for (let j = 2; j < dataLY.length; j++) {
        if (parseInt(dataLY[j][2]) === targetWeek && parseInt(dataLY[j][3]) === targetDayNum) {
          result.ventas   = Number(dataLY[j][mapLY.ventasCol   - 1]) || 0;
          result.unidades = Number(dataLY[j][mapLY.unidadesCol - 1]) || 0;
          result.tickets  = Number(dataLY[j][mapLY.ticketsCol  - 1]) || 0;
          result.trafico  = Number(dataLY[j][mapLY.traficoCol  - 1]) || 0;
          result.stockICG = Number(dataLY[j][mapLY.stockICGCol - 1]) || 0;
          result.stockRS  = Number(dataLY[j][mapLY.stockRSCol  - 1]) || 0;
          break;
        }
      }
    }

    if (deptStartCol !== -1) {
      for (let k = 2; k < dataDeptLY.length; k++) {
        if (parseInt(dataDeptLY[k][2]) === targetWeek && parseInt(dataDeptLY[k][3]) === targetDayNum) {
          result.bg = Number(dataDeptLY[k][deptStartCol])     || 0;
          result.bu = Number(dataDeptLY[k][deptStartCol + 1]) || 0;
          result.ck = Number(dataDeptLY[k][deptStartCol + 2]) || 0;
          result.cu = Number(dataDeptLY[k][deptStartCol + 3]) || 0;
          result.st = Number(dataDeptLY[k][deptStartCol + 4]) || 0;
          break;
        }
      }
    }

    return result;
  } catch (e) {
    console.error("Error en getLYDataForDate: " + e.message);
    return { ventas: 0, unidades: 0, tickets: 0, trafico: 0, stockICG: 0, stockRS: 0, bg: 0, bu: 0, ck: 0, cu: 0, st: 0 };
  }
}

/**
 * BUDGET ENGINE: Fair Share from Settings weights
 */
function getDailyBudget(storeName, selectedDate) {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const fechaFinal = selectedDate
      ? selectedDate
      : Utilities.formatDate(new Date(), ss.getSpreadsheetTimeZone(), "yyyy-MM-dd");

    const settingsSheet = ss.getSheetByName("Settings");
    if (!settingsSheet) throw new Error("No se encontró la pestaña Settings");
    const weightsData = settingsSheet.getRange("B2:B8").getValues();

    const dateObj   = new Date(fechaFinal.replace(/-/g, '\/'));
    const monthIdx  = dateObj.getMonth();
    const dayOfWeek = dateObj.getDay();
    const dayToTableIndex = (dayOfWeek === 0) ? 6 : dayOfWeek - 1;
    const currentWeight = parseFloat(weightsData[dayToTableIndex][0]) || 0;

    const budgetSheet = ss.getSheetByName("Budget");
    const budgetData  = budgetSheet.getDataRange().getValues();
    let monthlyBudget = 0;
    const searchName  = storeName.trim().toUpperCase();

    for (let i = 1; i < budgetData.length; i++) {
      let nombreTiendaSheet = String(budgetData[i][1]).trim().toUpperCase();
      if (nombreTiendaSheet === searchName) {
        monthlyBudget = parseFloat(budgetData[i][2 + monthIdx]) || 0;
        break;
      }
    }

    const weeklyGoal  = monthlyBudget / 4.33;
    const dailyTarget = weeklyGoal * currentWeight;

    return {
      daily:      dailyTarget,
      monthly:    monthlyBudget,
      weightUsed: (currentWeight * 100).toFixed(2),
      dayName:    ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'][dayOfWeek]
    };
  } catch (e) {
    console.error("Error en getDailyBudget: " + e.message);
    return { daily: 0, monthly: 0, weightUsed: 0, dayName: "Error" };
  }
}

function getBudgetData(storeName, monthIndex) {
  try {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const salesSheet  = ss.getSheetByName("Daily Sales");
    const budgetSheet = ss.getSheetByName("Budget");
    if (!salesSheet || !budgetSheet) throw new Error("Faltan hojas base (Daily Sales o Budget)");

    const salesData  = salesSheet.getDataRange().getValues();
    const budgetData = budgetSheet.getDataRange().getValues();

    const now          = new Date();
    const currentMonth = (monthIndex !== undefined && monthIndex !== null) ? monthIndex : now.getMonth();
    const currentYear  = now.getFullYear();

    const map = getStoreDataMap(storeName, "Daily Sales");
    if (!map) return { mtd: {actual:0, target:0, pct:0}, ytd: {actual:0, target:0, pct:0}, success: false };

    const vtsCol = map.startCol - 1;
    let mtdSales = 0, ytdSales = 0;

    const cleanNum = (val) => {
      if (val === null || val === undefined || val === "") return 0;
      if (typeof val === 'number') return val;
      let s = String(val).trim().replace(/\$/g, "").replace(/\s/g, "");
      if (s.includes(".") && s.includes(",")) {
        s = s.replace(/\./g, "").replace(",", ".");
      } else if (s.includes(",") && !s.includes(".")) {
        s = s.replace(",", ".");
      } else {
        s = s.replace(/,/g, "");
      }
      return parseFloat(s) || 0;
    };

    for (let i = 1; i < salesData.length; i++) {
      const rowYear = salesData[i][0];
      const rowMonth = salesData[i][1];
      const rowDesc = String(salesData[i][2]);
      if (typeof rowYear === 'number' && rowYear > 0 && !rowDesc.toUpperCase().includes("TOTAL")) {
        const val = cleanNum(salesData[i][vtsCol]);
        if (rowYear === currentYear) {
          ytdSales += val;
          if (rowMonth - 1 === currentMonth) mtdSales += val;
        }
      }
    }

    let monthlyBudget = 0, annualBudget = 0;
    for (let j = 1; j < budgetData.length; j++) {
      let nombreTiendaSheet = String(budgetData[j][1]).trim().toUpperCase();
      if (nombreTiendaSheet === storeName.toUpperCase()) {
        monthlyBudget = parseFloat(budgetData[j][2 + currentMonth]) || 0;
        annualBudget  = parseFloat(budgetData[j][14]) || 0;
        break;
      }
    }

    return {
      mtd: { actual: mtdSales, target: monthlyBudget, pct: monthlyBudget > 0 ? (mtdSales / monthlyBudget) * 100 : 0 },
      ytd: { actual: ytdSales, target: annualBudget,  pct: annualBudget  > 0 ? (ytdSales / annualBudget)  * 100 : 0 },
      store: storeName,
      success: true
    };
  } catch (e) {
    console.error("Error en getBudgetData para " + storeName + ": " + e.message);
    return { mtd: {actual:0, target:0, pct:0}, ytd: {actual:0, target:0, pct:0}, success: false };
  }
}

function _calcBudgetForStore(storeName, salesData, salesStoreRow, budgetData, monthIndex) {
  try {
    const target = String(storeName).trim().toUpperCase();
    let vtsCol = -1;
    for (let i = 0; i < salesStoreRow.length; i++) {
      if (String(salesStoreRow[i] || "").trim().toUpperCase() === target) { vtsCol = i; break; }
    }
    if (vtsCol === -1) return { mtd: {actual:0, target:0, pct:0}, ytd: {actual:0, target:0, pct:0}, success: false };

    const now          = new Date();
    const currentMonth = (monthIndex !== undefined && monthIndex !== null) ? monthIndex : now.getMonth();
    const currentYear  = now.getFullYear();
    let mtdSales = 0, ytdSales = 0;

    const cleanNum2 = (val) => {
      if (val === null || val === undefined || val === "") return 0;
      if (typeof val === 'number') return val;
      let s = String(val).trim().replace(/\$/g, "").replace(/\s/g, "");
      if (s.includes(".") && s.includes(",")) {
        s = s.replace(/\./g, "").replace(",", ".");
      } else if (s.includes(",") && !s.includes(".")) {
        s = s.replace(",", ".");
      } else {
        s = s.replace(/,/g, "");
      }
      return parseFloat(s) || 0;
    };

    for (let i = 1; i < salesData.length; i++) {
      const rowYear = salesData[i][0];
      const rowMonth = salesData[i][1];
      const rowDesc = String(salesData[i][2]);
      if (typeof rowYear === 'number' && rowYear > 0 && !rowDesc.toUpperCase().includes("TOTAL")) {
        const val = cleanNum2(salesData[i][vtsCol]);
        if (rowYear === currentYear) {
          ytdSales += val;
          if (rowMonth - 1 === currentMonth) mtdSales += val;
        }
      }
    }

    let monthlyBudget = 0, annualBudget = 0;
    for (let j = 1; j < budgetData.length; j++) {
      if (String(budgetData[j][1]).trim().toUpperCase() === target) {
        monthlyBudget = parseFloat(budgetData[j][2 + currentMonth]) || 0;
        annualBudget  = parseFloat(budgetData[j][14]) || 0;
        break;
      }
    }

    return {
      mtd: { actual: mtdSales, target: monthlyBudget, pct: monthlyBudget > 0 ? (mtdSales / monthlyBudget) * 100 : 0 },
      ytd: { actual: ytdSales, target: annualBudget,  pct: annualBudget  > 0 ? (ytdSales / annualBudget)  * 100 : 0 },
      store: storeName,
      success: true
    };
  } catch (e) {
    console.error("Error en _calcBudgetForStore para " + storeName + ": " + e.message);
    return { mtd: {actual:0, target:0, pct:0}, ytd: {actual:0, target:0, pct:0}, success: false };
  }
}

/**
 * ADMIN BUDGET: Consolidated + per-store breakdown with country info
 */
function getAdminBudgetData(storeName, isGlobal, monthIndex, countryFilter) {
  try {
    if (!isGlobal && storeName && storeName !== "GLOBAL") {
      return getBudgetData(storeName, monthIndex);
    }

    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const salesSheet  = ss.getSheetByName("Daily Sales");
    const budgetSheet = ss.getSheetByName("Budget");
    if (!salesSheet || !budgetSheet) throw new Error("Faltan hojas base (Daily Sales o Budget)");

    const salesData     = salesSheet.getDataRange().getValues();
    const budgetData    = budgetSheet.getDataRange().getValues();
    const salesStoreRow = salesData[1];

    const normalizedCountry = normalizeCountryName_(countryFilter);
    const stores = getActiveStoreNames()
      .filter(store => !normalizedCountry || normalizeCountryName_(LCW_COUNTRY_MAP[String(store || '').trim().toUpperCase()]) === normalizedCountry);

    let globalActualMTD = 0, globalTargetMTD = 0;
    let globalActualYTD = 0, globalTargetYTD = 0;
    let storeBreakdown  = [];

    stores.forEach(store => {
      try {
        const data = _calcBudgetForStore(store, salesData, salesStoreRow, budgetData, monthIndex);
        if (data && data.success) {
          globalActualMTD += (data.mtd.actual || 0);
          globalTargetMTD += (data.mtd.target || 0);
          globalActualYTD += (data.ytd.actual || 0);
          globalTargetYTD += (data.ytd.target || 0);
          storeBreakdown.push({
            name:      store,
            country:   LCW_COUNTRY_MAP[String(store || '').trim().toUpperCase()] || '',
            mtdActual: data.mtd.actual || 0,
            mtdTarget: data.mtd.target || 0,
            mtdPct:    data.mtd.pct    || 0,
            ytdActual: data.ytd.actual || 0,
            ytdTarget: data.ytd.target || 0,
            ytdPct:    data.ytd.pct    || 0
          });
        }
      } catch (e) { console.warn("Error en tienda " + store + ": " + e.message); }
    });

    return {
      global: {
        mtd: { actual: globalActualMTD, target: globalTargetMTD, pct: globalTargetMTD > 0 ? (globalActualMTD / globalTargetMTD) * 100 : 0 },
        ytd: { actual: globalActualYTD, target: globalTargetYTD, pct: globalTargetYTD > 0 ? (globalActualYTD / globalTargetYTD) * 100 : 0 }
      },
      individualStores: storeBreakdown.sort((a, b) => b.mtdActual - a.mtdActual)
    };

  } catch (err) {
    console.error("Error crítico en Admin Budget: " + err.message);
    return { error: err.message };
  }
}

function getLYData(storeName) {
  try {
    const hoy     = new Date();
    const dateStr = Utilities.formatDate(hoy, SpreadsheetApp.getActiveSpreadsheet().getSpreadsheetTimeZone(), "yyyy-MM-dd");
    return getLYDataForDate(storeName, dateStr);
  } catch (e) {
    console.error("Error en puente getLYData: " + e.message);
    return { ventas: 0, unidades: 0, tickets: 0, trafico: 0 };
  }
}

function getLoginStoreNames() {
  try {
    const ss    = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("Config");
    if (!sheet) throw new Error("Hoja Config no encontrada");
    const data  = sheet.getDataRange().getValues();
    return data.slice(1)
      .filter(r => r[0] && r[3] && String(r[3]).toLowerCase().includes("active"))
      .map(r => String(r[0]).trim());
  } catch (e) {
    console.error("Error en getLoginStoreNames: " + e.message);
    return [];
  }
}

function getEmailRecipientsForStore(storeName) {
  const ss    = SpreadsheetApp.getActiveSpreadsheet();
  const sheet = ss.getSheetByName("Emails");
  if (!sheet) throw new Error("No se encontró la hoja 'Emails'.");

  const data    = sheet.getDataRange().getValues();
  if (data.length === 0) throw new Error("La hoja 'Emails' está vacía.");

  const headers     = data[0].map(h => String(h || "").trim().toUpperCase());
  const targetStore = String(storeName || "").trim().toUpperCase();
  const colIndex    = headers.indexOf(targetStore);

  if (colIndex === -1) throw new Error("No se encontró la columna '" + storeName + "' en la hoja Emails.");

  const recipients = [];
  for (let i = 1; i < data.length; i++) {
    const email = String(data[i][colIndex] || "").trim();
    if (email) recipients.push(email);
  }

  if (recipients.length === 0) throw new Error("No hay destinatarios para '" + storeName + "' en Emails.");
  return recipients;
}

/**
 * DAILY EMAIL REPORT with LCW branding, dual stock, 5 depts
 */
function sendEntryEmail(store, dateStr, metrics, deptMetrics, attachmentsPayload, deptLY, comments) {
  try {
    const recipients = getEmailRecipientsForStore(store);

    const configData = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Config").getDataRange().getValues();
    const configRow  = configData.find(r => String(r[0]).trim().toUpperCase() === String(store).trim().toUpperCase());
    const storeEmail = configRow ? String(configRow[2]).trim() : "";

    const attachments = (attachmentsPayload || []).map(file => {
      const bytes = Utilities.base64Decode(file.base64Data);
      return Utilities.newBlob(bytes, file.mimeType || 'application/octet-stream', file.fileName || 'Adjunto');
    });

    const safe   = (v) => Number(v || 0);
    const money  = (v) => "$" + Number(v || 0).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
    const intFmt = (v) => Math.round(Number(v || 0)).toLocaleString();
    const escapeHtml = (value) => String(value || "")
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;");

    const getCompLabelHtml = (actual, ly) => {
      const vActual = safe(actual);
      const vLy     = safe(ly);
      if (vLy <= 0) return '<span style="color:#999; font-size:11px; margin-left:8px;">(Sin LY)</span>';
      const diff  = ((vActual / vLy) - 1) * 100;
      const color = diff >= 0 ? "#059669" : "#dc2626";
      const icon  = diff >= 0 ? "▲" : "▼";
      return `<span style="color:${color}; font-weight:bold; font-size:11px; margin-left:8px;">${icon} ${Math.abs(diff).toFixed(1)}% LY</span>`;
    };

    const ventas   = safe(metrics.ventas);
    const unidades = safe(metrics.unidades);
    const tickets  = safe(metrics.tickets);
    const trafico  = safe(metrics.trafico);
    const stockICG = safe(metrics.stockICG);
    const stockRS  = safe(metrics.stockRS);

    const upt  = tickets > 0 ? unidades / tickets : 0;
    const apt  = tickets > 0 ? ventas   / tickets : 0;
    const aur  = unidades > 0 ? ventas  / unidades : 0;
    const conv = trafico  > 0 ? (tickets / trafico) * 100 : 0;

    const budgetData = getBudgetData(store);
    const mtdActual  = safe(budgetData?.mtd?.actual);
    const mtdTarget  = safe(budgetData?.mtd?.target);
    const mtdPct     = safe(budgetData?.mtd?.pct);

    const lyData      = getLYDataForDate(store, dateStr);
    const countryName = LCW_COUNTRY_MAP[store] || '';
    const countryFlag = COUNTRY_FLAGS[countryName] || '';
    const commentText = String(comments || "").trim();

    let pieChartBlob = null;
    const deptTotal = safe(deptMetrics.bg) + safe(deptMetrics.bu) + safe(deptMetrics.ck) + safe(deptMetrics.cu) + safe(deptMetrics.st);
    if (deptTotal > 0) pieChartBlob = buildDeptPieChartBlob_(deptMetrics);

    const pieChartHtml = pieChartBlob
      ? `<div style="margin-top:18px; max-width:560px;">
          <div style="font-size:13px; font-weight:700; margin-bottom:8px;">Contribución por Departamento</div>
          <img src="cid:deptPieChart" style="width:100%; max-width:560px; height:auto; border:1px solid #eee; border-radius:12px;">
        </div>`
      : "";
    const commentsHtml = commentText
      ? `<div style="margin-top:24px; max-width:560px;">
          <h3 style="margin-top:0; margin-bottom:10px;">Comentarios</h3>
          <div style="border:1px solid #ddd; border-radius:12px; padding:12px 14px; background:#f8fafc; color:#333; font-size:13px; line-height:1.6; white-space:pre-wrap;">${escapeHtml(commentText)}</div>
        </div>`
      : "";

    const htmlBody = `
<div style="font-family: Arial, sans-serif; color:#111; max-width:760px; margin:0 auto;">
  <div style="border-top:4px solid #1565C0; padding-top:14px; margin-bottom:18px;">
    <h2 style="margin:0 0 6px 0;">LC Waikiki Daily Report</h2>
    <p style="margin:0; color:#555;">
      <strong>Store:</strong> ${store} ${countryFlag ? countryFlag + ' ' + countryName : ''}<br>
      <strong>Date:</strong> ${dateStr}
    </p>
  </div>

  <h3 style="margin-top:20px; margin-bottom:10px;">Resumen general</h3>
  <table style="border-collapse: collapse; width:100%; max-width:560px;">
    <tr><td style="border:1px solid #ddd; padding:8px;">Ventas</td><td style="border:1px solid #ddd; padding:8px;">${money(ventas)} ${getCompLabelHtml(ventas, lyData?.ventas)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">Unidades</td><td style="border:1px solid #ddd; padding:8px;">${intFmt(unidades)} ${getCompLabelHtml(unidades, lyData?.unidades)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">Tickets</td><td style="border:1px solid #ddd; padding:8px;">${intFmt(tickets)} ${getCompLabelHtml(tickets, lyData?.tickets)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">Tráfico</td><td style="border:1px solid #ddd; padding:8px;">${intFmt(trafico)} ${getCompLabelHtml(trafico, lyData?.trafico)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">Stock ICG (Sistema)</td><td style="border:1px solid #ddd; padding:8px;">${intFmt(stockICG)} ${getCompLabelHtml(stockICG, lyData?.stockICG)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">Stock RS (Tienda)</td><td style="border:1px solid #ddd; padding:8px;">${intFmt(stockRS)} ${getCompLabelHtml(stockRS, lyData?.stockRS)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">UPT</td><td style="border:1px solid #ddd; padding:8px;">${upt.toFixed(2)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">Conversión %</td><td style="border:1px solid #ddd; padding:8px;">${conv.toFixed(2)}%</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">APT</td><td style="border:1px solid #ddd; padding:8px;">${money(apt)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">AUR</td><td style="border:1px solid #ddd; padding:8px;">${money(aur)}</td></tr>
  </table>

  <div style="margin-top:22px; background:#0D47A1; color:#fff; border-radius:14px; padding:16px 18px; max-width:560px;">
    <div style="font-size:11px; text-transform:uppercase; letter-spacing:0.12em; color:#90CAF9; margin-bottom:8px;">Budget MTD</div>
    <div style="font-size:28px; font-weight:700; margin-bottom:8px;">${money(mtdActual)}</div>
    <div style="font-size:13px; line-height:1.7;">
      <strong>Meta MTD:</strong> ${money(mtdTarget)}<br>
      <strong>Cumplimiento:</strong> ${mtdPct.toFixed(1)}%
    </div>
  </div>

  <h3 style="margin-top:24px; margin-bottom:10px;">Ventas por Departamento</h3>
  <table style="border-collapse: collapse; width:100%; max-width:560px;">
    <tr><td style="border:1px solid #ddd; padding:8px;">BG — Women</td><td style="border:1px solid #ddd; padding:8px;">${money(deptMetrics.bg)} ${getCompLabelHtml(deptMetrics.bg, lyData?.bg)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">BU — Men</td><td style="border:1px solid #ddd; padding:8px;">${money(deptMetrics.bu)} ${getCompLabelHtml(deptMetrics.bu, lyData?.bu)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">CK — Girls</td><td style="border:1px solid #ddd; padding:8px;">${money(deptMetrics.ck)} ${getCompLabelHtml(deptMetrics.ck, lyData?.ck)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">CU — Boys</td><td style="border:1px solid #ddd; padding:8px;">${money(deptMetrics.cu)} ${getCompLabelHtml(deptMetrics.cu, lyData?.cu)}</td></tr>
    <tr><td style="border:1px solid #ddd; padding:8px;">ST — Standard</td><td style="border:1px solid #ddd; padding:8px;">${money(deptMetrics.st)} ${getCompLabelHtml(deptMetrics.st, lyData?.st)}</td></tr>
  </table>

  ${pieChartHtml}

  ${commentsHtml}

  <p style="margin-top:20px; font-size:12px; color:#666;">Adjuntos incluidos: ${(attachmentsPayload || []).length}</p>

  <div style="display:none; visibility:hidden; font-size:1px;">
    AUTO_PARSE_BLOCK
    STORE=${store}|DATE=${dateStr}|VENTAS=${ventas}|STOCK_ICG=${stockICG}|MTD_PCT=${mtdPct.toFixed(2)}
    END_AUTO_PARSE_BLOCK
  </div>
</div>`;

    const mailOptions = {
      to:       recipients.join(","),
      subject:  `LC Waikiki | ${store} | Reporte ${dateStr}`,
      htmlBody: htmlBody,
      attachments: attachments,
      name:     `LC Waikiki ${store}`,
      inlineImages: pieChartBlob ? { deptPieChart: pieChartBlob } : {}
    };
    if (storeEmail) mailOptions.replyTo = storeEmail;

    MailApp.sendEmail(mailOptions);
    return { success: true };

  } catch (e) {
    console.error("Error en sendEntryEmail: " + e.message);
    return { success: false, message: e.message };
  }
}

/**
 * PIE CHART for 5 departments
 */
function buildDeptPieChartBlob_(deptMetrics) {
  const bg = Number(deptMetrics.bg || 0);
  const bu = Number(deptMetrics.bu || 0);
  const ck = Number(deptMetrics.ck || 0);
  const cu = Number(deptMetrics.cu || 0);
  const st = Number(deptMetrics.st || 0);

  const dataTable = Charts.newDataTable()
    .addColumn(Charts.ColumnType.STRING, 'Departamento')
    .addColumn(Charts.ColumnType.NUMBER, 'Ventas')
    .addRow(['BG — Women', bg])
    .addRow(['BU — Men',   bu])
    .addRow(['CK — Girls', ck])
    .addRow(['CU — Boys',  cu])
    .addRow(['ST — Standard', st])
    .build();

  const chart = Charts.newPieChart()
    .setDataTable(dataTable)
    .setDimensions(560, 320)
    .setTitle('Contribución por Departamento')
    .setLegendPosition(Charts.Position.RIGHT)
    .build();

  return chart.getAs('image/png').setName('departments_pie_chart.png');
}

function authorizeMailApp() {
  MailApp.getRemainingDailyQuota();
}

function testWeeklyReportToMe() {
  sendWeeklyAdminReport("luisvelasquez@grupodavid.com");
}

/**
 * WEEKLY ADMIN REPORT — grouped by country, 5 depts
 */
function sendWeeklyAdminReport(testEmailOverride) {
  try {
    const ss   = SpreadsheetApp.getActiveSpreadsheet();
    const week = getCurrentSystemWeek();
    const targetYear = getRetailYear_();

    let adminEmails;
    if (testEmailOverride) {
      adminEmails = [testEmailOverride];
    } else {
      const configData = ss.getSheetByName("Config").getDataRange().getValues();
      adminEmails = configData.slice(1)
        .filter(r =>
          String(r[4] || "").toUpperCase().trim() === "ADMIN" &&
          String(r[3] || "").toLowerCase().includes("active") &&
          String(r[2] || "").includes("@")
        )
        .map(r => String(r[2]).trim());
    }

    if (adminEmails.length === 0) {
      console.warn("sendWeeklyAdminReport: No se encontraron correos admin en Config.");
      return;
    }

    const stores   = getActiveStoreNames();
    const regional = getRegionalData(week);

    const compMap = {};
    stores.forEach(store => {
      const summary = getWeeklySummary(store, week);
      if (summary) compMap[store] = summary;
    });

    const budgetResult = getAdminBudgetData(null, true);
    const budgetMap = {};
    ((budgetResult && budgetResult.individualStores) || []).forEach(s => { budgetMap[s.name] = s; });

    // Global dept mix — 5 depts, col += 5
    let deptGlobal = { bg: 0, bu: 0, ck: 0, cu: 0, st: 0 };
    try {
      const sheetDept = ss.getSheetByName("Dept Daily");
      if (sheetDept) {
        const dataDept     = sheetDept.getDataRange().getValues();
        const deptStoreRow = dataDept[1];
        for (let i = 4; i < dataDept.length; i++) {
          const rowYear = parseInt(dataDept[i][0], 10);
          const rowWeek = parseInt(String(dataDept[i][2]).replace(/\D/g, ''), 10);
          const rowDesc = String(dataDept[i][2] || "").toUpperCase();
          if (rowYear === targetYear && rowWeek === week && !rowDesc.includes("TOTAL")) {
            for (let col = 5; col < dataDept[i].length; col += 5) {
              if (deptStoreRow[col] && String(deptStoreRow[col]).trim() !== "") {
                deptGlobal.bg += Number(dataDept[i][col])     || 0;
                deptGlobal.bu += Number(dataDept[i][col + 1]) || 0;
                deptGlobal.ck += Number(dataDept[i][col + 2]) || 0;
                deptGlobal.cu += Number(dataDept[i][col + 3]) || 0;
                deptGlobal.st += Number(dataDept[i][col + 4]) || 0;
              }
            }
          }
        }
      }
    } catch (eDept) { console.warn("Error leyendo Dept Daily: " + eDept.message); }

    const deptTotal = deptGlobal.bg + deptGlobal.bu + deptGlobal.ck + deptGlobal.cu + deptGlobal.st;
    const dPct = (v) => deptTotal > 0 ? ((v / deptTotal) * 100).toFixed(1) : "0.0";

    const feedbackMap = {};
    stores.forEach(store => {
      const fb = getSavedFeedback(store, week);
      if (fb) feedbackMap[store] = fb;
    });

    const money = (v) => "$" + Math.round(Number(v || 0)).toLocaleString("es-VE");
    const fmt   = (v) => Math.round(Number(v || 0)).toLocaleString("es-VE");
    const comp  = (val, hasLY) => {
      if (!hasLY) return '<span style="color:#999;font-size:12px">N/D</span>';
      const n     = Number(val || 0);
      const color = n >= 0 ? "#16a34a" : "#dc2626";
      const sign  = n >= 0 ? "+" : "";
      return `<span style="color:${color};font-weight:700;font-size:12px">${sign}${n.toFixed(1)}%</span>`;
    };

    const rankingRows = (regional.stores || []).map(s => {
      const c = compMap[s.name];
      return {
        name:     s.name,
        country:  LCW_COUNTRY_MAP[s.name] || '',
        flag:     COUNTRY_FLAGS[LCW_COUNTRY_MAP[s.name]] || '',
        ventas:   s.ventas,
        compV:    c ? c.ventas.comp  : 0, hasLY_V: c && c.ventas.ly  > 0,
        unidades: s.unidades,
        compU:    c ? c.unidades.comp : 0, hasLY_U: c && c.unidades.ly > 0,
        upt:      parseFloat(s.upt  || 0),
        conv:     parseFloat(s.conv || 0),
        trafico:  s.trafico,
        compT:    c ? c.trafico.comp  : 0, hasLY_T: c && c.trafico.ly  > 0
      };
    });

    const thStyle      = 'padding:12px 16px;font-size:10px;font-weight:800;text-transform:uppercase;letter-spacing:.1em;color:#fff;white-space:nowrap';
    const dividerStyle = 'border:none;border-top:2px solid #1565C0;margin:0 0 20px';

    const rankingRowsHtml = rankingRows.map(r => `
      <tr>
        <td style="padding:12px 16px;font-weight:700;font-size:13px;color:#111">${r.flag} ${r.name}</td>
        <td style="padding:12px 16px;text-align:center;font-size:11px;color:#1565C0;font-weight:700">${r.country}</td>
        <td style="padding:12px 16px;text-align:right;font-size:13px;font-weight:600">${money(r.ventas)}</td>
        <td style="padding:12px 16px;text-align:right">${comp(r.compV, r.hasLY_V)}</td>
        <td style="padding:12px 16px;text-align:right;font-size:13px">${fmt(r.unidades)}</td>
        <td style="padding:12px 16px;text-align:right">${comp(r.compU, r.hasLY_U)}</td>
        <td style="padding:12px 16px;text-align:right;font-size:13px">${r.upt.toFixed(2)}</td>
        <td style="padding:12px 16px;text-align:right;font-size:13px">${r.conv.toFixed(1)}%</td>
        <td style="padding:12px 16px;text-align:right;font-size:13px">${fmt(r.trafico)}</td>
        <td style="padding:12px 16px;text-align:right">${comp(r.compT, r.hasLY_T)}</td>
      </tr>`).join("");

    const budgetRowsHtml = stores.map(name => {
      const b = budgetMap[name];
      if (!b) return "";
      const pctVal   = b.mtdPct || 0;
      const pctColor = pctVal >= 100 ? "#16a34a" : pctVal >= 80 ? "#d97706" : "#dc2626";
      const flag     = COUNTRY_FLAGS[LCW_COUNTRY_MAP[name]] || '';
      return `
        <tr>
          <td style="padding:12px 16px;font-weight:700;font-size:13px;color:#111">${flag} ${name}</td>
          <td style="padding:12px 16px;text-align:right;font-size:13px;font-weight:600">${money(b.mtdActual)}</td>
          <td style="padding:12px 16px;text-align:right;font-weight:700;font-size:13px;color:${pctColor}">${pctVal.toFixed(1)}%</td>
        </tr>`;
    }).join("");

    const feedbackHtml = stores.map(name => {
      const fb = feedbackMap[name];
      if (!fb || (!fb.diagnostico && !fb.accion)) return "";
      return `
        <div style="background:#f0f4ff;border:1px solid #c7d2fe;border-radius:12px;padding:20px 24px;margin-bottom:16px">
          <p style="margin:0 0 8px;font-weight:800;font-size:13px;color:#111;text-transform:uppercase;letter-spacing:.05em">${name}</p>
          ${fb.diagnostico ? `<p style="margin:0 0 6px;font-size:13px;color:#374151"><strong>Diagnóstico:</strong> ${fb.diagnostico}</p>` : ""}
          ${fb.accion      ? `<p style="margin:0;font-size:13px;color:#374151"><strong>Compromiso:</strong> ${fb.accion}</p>` : ""}
        </div>`;
    }).join("");

    const htmlBody = `
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"></head>
<body style="margin:0;padding:0;background:#f4f4f5;font-family:Arial,Helvetica,sans-serif">
<table width="100%" cellpadding="0" cellspacing="0" style="background:#f4f4f5;padding:32px 16px">
<tr><td>
  <table width="100%" cellpadding="0" cellspacing="0" style="max-width:760px;margin:0 auto;background:#fff;border-radius:12px;overflow:hidden;box-shadow:0 2px 12px rgba(0,0,0,.08)">

    <tr>
      <td style="background:#0D47A1;padding:36px 40px;text-align:center">
        <p style="margin:0;font-size:22px;font-weight:900;color:#fff;letter-spacing:.15em;text-transform:uppercase">LC WAIKIKI — WEEKLY OPERATIONS REPORT</p>
        <p style="margin:8px 0 0;font-size:11px;font-weight:600;color:#90CAF9;letter-spacing:.2em;text-transform:uppercase">SEMANA ${week} | PERFORMANCE SUMMARY</p>
      </td>
    </tr>

    <tr><td style="padding:36px 40px">

      <p style="margin:0 0 8px;font-size:14px;font-weight:800;color:#111;text-transform:uppercase;letter-spacing:.05em">RANKING PERFORMANCE (VS LY)</p>
      <hr style="${dividerStyle}">
      <div style="overflow-x:auto;margin-bottom:36px">
        <table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;min-width:680px">
          <thead>
            <tr style="background:#0D47A1">
              <th style="${thStyle};text-align:left">Tienda</th>
              <th style="${thStyle};text-align:left">País</th>
              <th style="${thStyle};text-align:right">Venta TY</th>
              <th style="${thStyle};text-align:right">Comp V%</th>
              <th style="${thStyle};text-align:right">Unids</th>
              <th style="${thStyle};text-align:right">Comp U%</th>
              <th style="${thStyle};text-align:right">UPT</th>
              <th style="${thStyle};text-align:right">Conv%</th>
              <th style="${thStyle};text-align:right">Tráfico</th>
              <th style="${thStyle};text-align:right">Comp T%</th>
            </tr>
          </thead>
          <tbody style="border:1px solid #e5e7eb">
            ${rankingRowsHtml}
          </tbody>
        </table>
      </div>

      <p style="margin:0 0 8px;font-size:14px;font-weight:800;color:#111;text-transform:uppercase;letter-spacing:.05em">MIX DEPARTAMENTO (GLOBAL)</p>
      <hr style="${dividerStyle}">
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#0D47A1;border-radius:8px;margin-bottom:36px">
        <tr>
          <td style="padding:16px;text-align:center;border-right:1px solid #1565C0">
            <p style="margin:0;font-size:12px;font-weight:800;color:#fff;letter-spacing:.1em">BG</p>
            <p style="margin:2px 0 0;font-size:10px;color:#90CAF9">Women</p>
            <p style="margin:4px 0 0;font-size:16px;font-weight:700;color:#e3f2fd">${dPct(deptGlobal.bg)}%</p>
          </td>
          <td style="padding:16px;text-align:center;border-right:1px solid #1565C0">
            <p style="margin:0;font-size:12px;font-weight:800;color:#fff;letter-spacing:.1em">BU</p>
            <p style="margin:2px 0 0;font-size:10px;color:#90CAF9">Men</p>
            <p style="margin:4px 0 0;font-size:16px;font-weight:700;color:#e3f2fd">${dPct(deptGlobal.bu)}%</p>
          </td>
          <td style="padding:16px;text-align:center;border-right:1px solid #1565C0">
            <p style="margin:0;font-size:12px;font-weight:800;color:#fff;letter-spacing:.1em">CK</p>
            <p style="margin:2px 0 0;font-size:10px;color:#90CAF9">Girls</p>
            <p style="margin:4px 0 0;font-size:16px;font-weight:700;color:#e3f2fd">${dPct(deptGlobal.ck)}%</p>
          </td>
          <td style="padding:16px;text-align:center;border-right:1px solid #1565C0">
            <p style="margin:0;font-size:12px;font-weight:800;color:#fff;letter-spacing:.1em">CU</p>
            <p style="margin:2px 0 0;font-size:10px;color:#90CAF9">Boys</p>
            <p style="margin:4px 0 0;font-size:16px;font-weight:700;color:#e3f2fd">${dPct(deptGlobal.cu)}%</p>
          </td>
          <td style="padding:16px;text-align:center">
            <p style="margin:0;font-size:12px;font-weight:800;color:#fff;letter-spacing:.1em">ST</p>
            <p style="margin:2px 0 0;font-size:10px;color:#90CAF9">Standard</p>
            <p style="margin:4px 0 0;font-size:16px;font-weight:700;color:#e3f2fd">${dPct(deptGlobal.st)}%</p>
          </td>
        </tr>
      </table>

      <p style="margin:0 0 8px;font-size:14px;font-weight:800;color:#111;text-transform:uppercase;letter-spacing:.05em">ALCANCE BUDGET MTD</p>
      <hr style="${dividerStyle}">
      <div style="overflow-x:auto;margin-bottom:36px">
        <table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse">
          <thead>
            <tr style="background:#0D47A1">
              <th style="${thStyle};text-align:left">Tienda</th>
              <th style="${thStyle};text-align:right">Venta MTD</th>
              <th style="${thStyle};text-align:right">%</th>
            </tr>
          </thead>
          <tbody style="border:1px solid #e5e7eb">
            ${budgetRowsHtml}
          </tbody>
        </table>
      </div>

      ${feedbackHtml ? `
      <p style="margin:0 0 8px;font-size:14px;font-weight:800;color:#111;text-transform:uppercase;letter-spacing:.05em">DIAGNÓSTICOS Y COMPROMISOS</p>
      <hr style="${dividerStyle}">
      ${feedbackHtml}` : ""}

    </td></tr>

    <tr>
      <td style="padding:20px 40px;text-align:center;border-top:1px solid #e5e7eb">
        <p style="margin:0;font-size:11px;color:#9ca3af">Reporte automático generado por LC Waikiki Retail Pro.</p>
      </td>
    </tr>

  </table>
</td></tr>
</table>
</body>
</html>`;

    MailApp.sendEmail({
      to:      adminEmails.join(","),
      subject: `REPORTE OPERATIVO — LC WAIKIKI — SEMANA ${week}`,
      htmlBody: htmlBody
    });

    console.log("Reporte semanal LCW enviado a: " + adminEmails.join(", "));

  } catch (err) {
    console.error("Error en sendWeeklyAdminReport: " + err.message);
    throw err;
  }
}

/**
 * CUSTOM RANGE COMPARISON with 5 dept breakdown (BG/BU/CK/CU/ST)
 */
function getCustomRangeComparison(storeNames, tyRange, lyRange, countryFilter) {
  try {
    const ss          = SpreadsheetApp.getActiveSpreadsheet();
    const sheetDS     = ss.getSheetByName("Daily Sales");
    const sheetLY     = ss.getSheetByName("LY");
    const sheetDeptTY = ss.getSheetByName("Dept Daily");
    const sheetDeptLY = ss.getSheetByName("Dept LY");

    const normalizedCountry = normalizeCountryName_(countryFilter);
    const storesToProcess = (Array.isArray(storeNames) ? storeNames : [storeNames])
      .filter(name => !normalizedCountry || normalizeCountryName_(LCW_COUNTRY_MAP[String(name).trim().toUpperCase()]) === normalizedCountry);

    const parseDateNormal = (dateStr) => {
      if (!dateStr) return 0;
      const parts = dateStr.split('-');
      return new Date(parts[0], parts[1] - 1, parts[2], 0, 0, 0, 0).getTime();
    };

    const d1Start = parseDateNormal(tyRange.start);
    const d1End   = parseDateNormal(tyRange.end);
    const d2Start = parseDateNormal(lyRange.start);
    const d2End   = parseDateNormal(lyRange.end);

    const dataDS     = sheetDS.getDataRange().getValues();
    const dataLY     = sheetLY.getDataRange().getValues();
    const dataDeptTY = sheetDeptTY.getDataRange().getValues();
    const dataDeptLY = sheetDeptLY.getDataRange().getValues();

    const dateKey = (date) => Utilities.formatDate(date, Session.getScriptTimeZone(), 'yyyy-MM-dd');

    const addSalesRange = (data, map, start, end, total, seenDates) => {
      for (let i = 2; i < data.length; i++) {
        const cellDate = data[i][4];
        if (!(cellDate instanceof Date)) continue;
        const rowTime = cellDate.getTime();
        if (rowTime < start || rowTime > end) continue;

        if (seenDates) {
          const key = dateKey(cellDate);
          if (seenDates[key]) continue;
          seenDates[key] = true;
        }

        total.v  += Number(data[i][map.ventasCol - 1])   || 0;
        total.u  += Number(data[i][map.unidadesCol - 1]) || 0;
        total.t  += Number(data[i][map.ticketsCol - 1])  || 0;
        total.tr += Number(data[i][map.traficoCol - 1])  || 0;
      }
    };

    const addDeptRange = (data, colIndex, start, end, target, seenDates) => {
      for (let i = 2; i < data.length; i++) {
        const dDate = data[i][4];
        if (!(dDate instanceof Date)) continue;
        const rowTime = dDate.getTime();
        if (rowTime < start || rowTime > end) continue;

        if (seenDates) {
          const key = dateKey(dDate);
          if (seenDates[key]) continue;
          seenDates[key] = true;
        }

        target.bg += Number(data[i][colIndex])     || 0;
        target.bu += Number(data[i][colIndex + 1]) || 0;
        target.ck += Number(data[i][colIndex + 2]) || 0;
        target.cu += Number(data[i][colIndex + 3]) || 0;
        target.st += Number(data[i][colIndex + 4]) || 0;
      }
    };

    const finalResults = [];
    let deptTotals = {
      ty: { bg: 0, bu: 0, ck: 0, cu: 0, st: 0 },
      ly: { bg: 0, bu: 0, ck: 0, cu: 0, st: 0 }
    };

    storesToProcess.forEach(name => {
      try {
        const targetName = String(name).trim().toUpperCase();
        const mapDS = getStoreDataMap(name, "Daily Sales");
        const mapLY = getStoreDataMap(name, "LY");
        if (!mapDS || !mapLY) return;

        let tyTotal = { v: 0, u: 0, t: 0, tr: 0 };
        let lyTotal = { v: 0, u: 0, t: 0, tr: 0 };

        addSalesRange(dataDS, mapDS, d1Start, d1End, tyTotal, null);
        const seenSalesDates = {};
        addSalesRange(dataDS, mapDS, d2Start, d2End, lyTotal, seenSalesDates);
        addSalesRange(dataLY, mapLY, d2Start, d2End, lyTotal, seenSalesDates);

        // Dept accumulation — 5 cols per store
        const findDeptCol = (sheetData, sName) => {
          const header = sheetData[1];
          for (let c = 0; c < header.length; c++) {
            if (String(header[c]).trim().toUpperCase() === sName) return c;
          }
          return -1;
        };

        const colIndexTY = findDeptCol(dataDeptTY, targetName);
        const colIndexLY = findDeptCol(dataDeptLY, targetName);

        if (colIndexTY !== -1) addDeptRange(dataDeptTY, colIndexTY, d1Start, d1End, deptTotals.ty, null);
        const seenDeptDates = {};
        if (colIndexTY !== -1) addDeptRange(dataDeptTY, colIndexTY, d2Start, d2End, deptTotals.ly, seenDeptDates);
        if (colIndexLY !== -1) addDeptRange(dataDeptLY, colIndexLY, d2Start, d2End, deptTotals.ly, seenDeptDates);

        const calculated = calculateComparisonFinal_(tyTotal, lyTotal);
        calculated.storeName = name;
        calculated.country   = LCW_COUNTRY_MAP[String(name || '').trim().toUpperCase()] || '';
        finalResults.push(calculated);

      } catch (err) { console.error("Error en " + name + ": " + err.message); }
    });

    return { generalData: finalResults, deptData: deptTotals };
  } catch (e) {
    throw new Error("Fallo en Comparativa: " + e.message);
  }
}

/**
 * COMPARISON CALCULATION ENGINE
 */
function calculateComparisonFinal_(ty, ly) {
  const safeDiv  = (num, den) => (den && den !== 0) ? (num / den) : 0;
  const safeComp = (curr, prev) => (prev && prev !== 0) ? ((curr / prev) - 1) * 100 : 0;

  const tyUPT  = safeDiv(ty.u, ty.t);
  const lyUPT  = safeDiv(ly.u, ly.t);
  const tyConv = safeDiv(ty.t, ty.tr) * 100;
  const lyConv = safeDiv(ly.t, ly.tr) * 100;

  return {
    ventas:   { ty: ty.v,  ly: ly.v,  comp: safeComp(ty.v,  ly.v) },
    unidades: { ty: ty.u,  ly: ly.u,  comp: safeComp(ty.u,  ly.u) },
    trafico:  { ty: ty.tr, ly: ly.tr, comp: safeComp(ty.tr, ly.tr) },
    upt:      { ty: tyUPT, ly: lyUPT, comp: safeComp(tyUPT, lyUPT) },
    conv:     { ty: tyConv, ly: lyConv, comp: safeComp(tyConv, lyConv) },
    apt:      { ty: safeDiv(ty.v, ty.t), comp: safeComp(safeDiv(ty.v, ty.t), safeDiv(ly.v, ly.t)) },
    aur:      { ty: safeDiv(ty.v, ty.u), comp: safeComp(safeDiv(ty.v, ty.u), safeDiv(ly.v, ly.u)) },
    tickets:  { ty: ty.t,  ly: ly.t,  comp: safeComp(ty.t,  ly.t) }
  };
}

// ─────────────────────────────────────────────────────────────────────────────
// ENOCTA — Mark activity as completed from the dashboard
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Marks a single activity as Completed in the Rendimiento_Cursos sheet.
 * Identified by the combination of codUsuario + actividad (unique per person/course).
 * Also records who completed it and when.
 */
function markRendimientoCompleted(codUsuario, actividad) {
  try {
    const ss    = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName('Rendimiento_Cursos');
    if (!sheet) return { success: false, message: 'Hoja Rendimiento_Cursos no encontrada.' };

    const data = sheet.getDataRange().getValues();
    // Col indices (0-based): E=4 Actividad, F=5 Status, H=7 CódUsuario
    const COL_ACTIVIDAD  = 4;
    const COL_STATUS     = 5;
    const COL_USER       = 7;

    let found = false;
    for (let i = 1; i < data.length; i++) {
      if (String(data[i][COL_USER]).trim()      === String(codUsuario).trim() &&
          String(data[i][COL_ACTIVIDAD]).trim() === String(actividad).trim()) {
        sheet.getRange(i + 1, COL_STATUS + 1).setValue('Completed');
        found = true;
        break;
      }
    }

    if (!found) return { success: false, message: 'Actividad no encontrada.' };
    return { success: true };

  } catch (e) {
    console.error('markRendimientoCompleted error: ' + e.message);
    return { success: false, message: e.message };
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ENOCTA TRAINING REPORT — Automatic Monday processing
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Run manually to check trigger status and last execution metadata.
 */
function checkEnoctaStatus() {
  const triggers = ScriptApp.getProjectTriggers()
    .filter(t => t.getHandlerFunction() === 'processEnoctaReport');
  if (triggers.length === 0) {
    console.log('ALERTA: No hay trigger configurado para processEnoctaReport. Ejecuta setupEnoctaTrigger().');
  } else {
    triggers.forEach(t => {
      console.log('Trigger activo: ' + t.getHandlerFunction() +
        ' | Type: ' + t.getTriggerSource() +
        ' | UniqueId: ' + t.getUniqueId());
    });
  }
  const props = PropertiesService.getScriptProperties();
  console.log('ENOCTA_LAST_UPDATE: '   + (props.getProperty('ENOCTA_LAST_UPDATE')   || 'no registrado'));
  console.log('ENOCTA_REPORT_DATE: '   + (props.getProperty('ENOCTA_REPORT_DATE')   || 'no registrado'));
  console.log('ENOCTA_TOTAL_PENDING: ' + (props.getProperty('ENOCTA_TOTAL_PENDING') || 'no registrado'));
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheet = ss.getSheetByName('Rendimiento_Cursos');
  if (sheet) {
    console.log('Rendimiento_Cursos filas actuales: ' + (sheet.getLastRow() - 1));
  } else {
    console.log('ALERTA: Hoja Rendimiento_Cursos no existe.');
  }
}

/**
 * Creates a weekly Monday trigger. Run this function ONCE manually from the
 * Apps Script editor (Extensions > Apps Script > Run > setupEnoctaTrigger).
 * After that the trigger fires automatically every Monday at 9 AM.
 */
function setupEnoctaTrigger() {
  // Remove existing enocta triggers to avoid duplicates
  ScriptApp.getProjectTriggers()
    .filter(t => t.getHandlerFunction() === 'processEnoctaReport')
    .forEach(t => ScriptApp.deleteTrigger(t));

  ScriptApp.newTrigger('processEnoctaReport')
    .timeBased()
    .onWeekDay(ScriptApp.WeekDay.MONDAY)
    .atHour(15)
    .create();

  console.log('Trigger Enocta configurado: cada lunes a las 9 AM.');
}

/**
 * Main processing function. Called every Monday by the trigger, or manually.
 * 1. Searches Gmail for the latest email from report@myenocta.com with xlsx attachment.
 * 2. Converts the xlsx to Google Sheets using Drive API.
 * 3. Filters rows with COMPLETION STATUS = "In Progress" or "Not Started".
 * 4. Extracts Tienda code from USER CODE (e.g. FR-VE06-00032 → VE06).
 * 5. Writes results to the "Rendimiento_Cursos" tab.
 */
function processEnoctaReport() {
  try {
    const threads = GmailApp.search('from:report@myenocta.com has:attachment newer_than:8d', 0, 5);
    if (!threads || threads.length === 0) {
      console.log('processEnoctaReport: No se encontró correo de enocta en los últimos 8 días.');
      return;
    }

    let xlsxBlob = null;
    let reportDate = null;

    outer:
    for (const thread of threads) {
      for (const msg of thread.getMessages()) {
        for (const att of msg.getAttachments()) {
          const name = att.getName().toLowerCase();
          if (name.endsWith('.xlsx') || name.endsWith('.xls')) {
            xlsxBlob = att.copyBlob();
            xlsxBlob.setName('enocta_temp.xlsx');
            xlsxBlob.setContentType('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            reportDate = msg.getDate();
            break outer;
          }
        }
      }
    }

    if (!xlsxBlob) {
      console.log('processEnoctaReport: No se encontró adjunto xlsx.');
      return;
    }

    // Convert xlsx to Google Sheets via Drive Advanced Service
    const tempFileName = '_enocta_temp_' + new Date().getTime();
    const sheetsFile = Drive.Files.insert(
      { title: tempFileName, mimeType: 'application/vnd.google-apps.spreadsheet' },
      xlsxBlob
    );

    try {
      _writeEnoctaDataFromSheet_(sheetsFile.id, reportDate);
    } finally {
      try { Drive.Files.trash(sheetsFile.id); } catch (e) { console.warn('No se pudo eliminar archivo temp: ' + e.message); }
    }

  } catch (err) {
    console.error('processEnoctaReport error: ' + err.message);
    throw err;
  }
}

/**
 * Diagnostic — run manually from Apps Script editor to inspect the Enocta report
 * without writing anything. Logs headers, col mapping, status counts, and row 1 sample.
 */
function debugEnoctaReport() {
  try {
    const threads = GmailApp.search('from:report@myenocta.com has:attachment newer_than:8d', 0, 5);
    if (!threads || threads.length === 0) {
      console.log('debugEnoctaReport: No se encontró correo de enocta en los últimos 8 días.');
      return;
    }
    let xlsxBlob = null;
    let msgDate = null;
    outer:
    for (const thread of threads) {
      for (const msg of thread.getMessages()) {
        for (const att of msg.getAttachments()) {
          const name = att.getName().toLowerCase();
          if (name.endsWith('.xlsx') || name.endsWith('.xls')) {
            xlsxBlob = att.copyBlob();
            xlsxBlob.setName('enocta_debug.xlsx');
            xlsxBlob.setContentType('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            msgDate = msg.getDate();
            console.log('Adjunto encontrado: ' + att.getName() + ' | Fecha email: ' + msgDate);
            break outer;
          }
        }
      }
    }
    if (!xlsxBlob) { console.log('No xlsx encontrado.'); return; }

    const tempFile = Drive.Files.insert(
      { title: '_enocta_debug_' + new Date().getTime(), mimeType: 'application/vnd.google-apps.spreadsheet' },
      xlsxBlob
    );
    try {
      const tempSS = SpreadsheetApp.openById(tempFile.id);
      const sheet  = tempSS.getSheets()[0];
      const allData = sheet.getDataRange().getValues();
      console.log('Total filas en xlsx: ' + allData.length);
      console.log('Primeras 6 filas (col 0-5): ' + JSON.stringify(allData.slice(0, 6).map(r => r.slice(0, 5))));

      let headerRowIdx = -1;
      for (let i = 0; i < Math.min(15, allData.length); i++) {
        for (let j = 0; j < allData[i].length; j++) {
          if (String(allData[i][j] || '').toUpperCase().trim() === 'ACTIVITY NAME') {
            headerRowIdx = i;
            break;
          }
        }
        if (headerRowIdx >= 0) break;
      }
      console.log('Header row index: ' + headerRowIdx);
      if (headerRowIdx >= 0) {
        const headers = allData[headerRowIdx].map(h => String(h || '').trim());
        console.log('Headers: ' + JSON.stringify(headers));
        const statusIdx = headers.map(h => h.toUpperCase()).indexOf('COMPLETION STATUS');
        if (statusIdx >= 0) {
          const statuses = {};
          for (let i = headerRowIdx + 1; i < allData.length; i++) {
            const s = String(allData[i][statusIdx] || '').trim();
            if (s) statuses[s] = (statuses[s] || 0) + 1;
          }
          console.log('Status counts: ' + JSON.stringify(statuses));
        }
        if (allData.length > headerRowIdx + 1) {
          console.log('Primera fila de datos: ' + JSON.stringify(allData[headerRowIdx + 1]));
        }
      }
    } finally {
      try { Drive.Files.trash(tempFile.id); } catch(e) {}
    }
  } catch (err) {
    console.error('debugEnoctaReport error: ' + err.message);
  }
}

/**
 * Reads the converted temp spreadsheet, filters pending activities, and writes
 * to the "Rendimiento_Cursos" tab in the active spreadsheet.
 */
function _writeEnoctaDataFromSheet_(sheetId, reportDate) {
  const tempSS = SpreadsheetApp.openById(sheetId);
  const sheet  = tempSS.getSheets()[0];
  const allData = sheet.getDataRange().getValues();

  // Locate header row: search ANY cell in first 15 rows for "ACTIVITY NAME"
  let headerRowIdx = -1;
  for (let i = 0; i < Math.min(15, allData.length); i++) {
    for (let j = 0; j < allData[i].length; j++) {
      if (String(allData[i][j] || '').toUpperCase().trim() === 'ACTIVITY NAME') {
        headerRowIdx = i;
        break;
      }
    }
    if (headerRowIdx >= 0) break;
  }
  if (headerRowIdx < 0) {
    console.error('_writeEnoctaDataFromSheet_: No se encontró la fila de encabezado (ACTIVITY NAME) en las primeras 15 filas. Total filas: ' + allData.length);
    console.log('Primeras 6 filas (col 0-4): ' + JSON.stringify(allData.slice(0, 6).map(r => r.slice(0, 5))));
    throw new Error('Formato de reporte Enocta no reconocido: fila de encabezado no encontrada.');
  }

  // Map column names to indices dynamically
  const rawHeaders = allData[headerRowIdx].map(h => String(h || '').trim().toUpperCase());
  console.log('Enocta headers encontrados: ' + JSON.stringify(rawHeaders));
  const col = {
    activity:   rawHeaders.indexOf('ACTIVITY NAME'),
    userCode:   rawHeaders.indexOf('USER CODE'),
    status:     rawHeaders.indexOf('COMPLETION STATUS'),
    score:      rawHeaders.indexOf('SCORE'),
    regDate:    rawHeaders.indexOf('ACTIVITY ASSIGN DATE') >= 0
                  ? rawHeaders.indexOf('ACTIVITY ASSIGN DATE')
                  : rawHeaders.indexOf('USER ACTIVITY REGISTRATION DATE'),
    lastEnter:  rawHeaders.indexOf('COMPLETION DATE') >= 0
                  ? rawHeaders.indexOf('COMPLETION DATE')
                  : rawHeaders.indexOf('LAST ENTERANCE DATE'),
    storeDept:  rawHeaders.indexOf('STORE/DEPARTMENT'),
    jobTitle:   rawHeaders.indexOf('TITLE'),
    country:    rawHeaders.indexOf('COUNTRY')
  };
  console.log('Enocta col mapping: ' + JSON.stringify(col));
  if (col.status < 0 || col.activity < 0 || col.userCode < 0) {
    console.error('_writeEnoctaDataFromSheet_: Columnas críticas no encontradas. status=' + col.status + ' activity=' + col.activity + ' userCode=' + col.userCode);
    throw new Error('Formato de reporte Enocta no reconocido: columnas críticas no encontradas.');
  }

  const PENDING = ['IN PROGRESS', 'NOT STARTED', 'NOT COMPLETED'];
  const tz = SpreadsheetApp.getActiveSpreadsheet().getSpreadsheetTimeZone();
  const now = new Date();
  const reportDateStr = reportDate ? Utilities.formatDate(reportDate, tz, 'yyyy-MM-dd') : '';

  // Log unique status values for diagnostics
  const uniqueStatuses = {};
  const summaryByCountryStore = {};
  const normalizeCourseStatus = (value) => {
    const s = String(value || '').trim().toUpperCase();
    if (['COMPLETED', 'COMPLETE', 'COMPLETADO', 'COMPLETADA', 'FINALIZADO', 'FINALIZADA', 'APPROVED', 'APROBADO', 'APROBADA'].includes(s)) return 'completed';
    if (['IN PROGRESS', 'EN PROGRESO', 'IN-PROGRESS'].includes(s)) return 'inProgress';
    if (['NOT STARTED', 'NOT COMPLETED', 'INCOMPLETE', 'NO INICIADO', 'NO COMPLETADO', 'INCOMPLETO'].includes(s)) return 'notCompleted';
    return '';
  };

  for (let i = headerRowIdx + 1; i < allData.length; i++) {
    const row = allData[i];
    const s = String(allData[i][col.status] || '').trim();
    if (s) uniqueStatuses[s] = (uniqueStatuses[s] || 0) + 1;
    if (!row[col.activity] && !row[col.userCode]) continue;

    const userCode = String(row[col.userCode] || '').trim();
    const parts    = userCode.split('-');
    const tienda   = parts.length >= 2 ? parts[1] : userCode;
    const pais     = normalizeCountryName_(String(row[col.country] || '').trim() || (LCW_COUNTRY_MAP[String(tienda).toUpperCase()] || 'SIN PAÍS'));
    const statusKey = normalizeCourseStatus(s);
    if (!statusKey) continue;

    const mapKey = pais + '||' + tienda;
    if (!summaryByCountryStore[mapKey]) {
      summaryByCountryStore[mapKey] = { pais: pais, tienda: tienda, completed: 0, inProgress: 0, notCompleted: 0, total: 0 };
    }
    summaryByCountryStore[mapKey][statusKey]++;
    summaryByCountryStore[mapKey].total++;
  }
  console.log('Enocta status values en reporte: ' + JSON.stringify(uniqueStatuses));

  const outputRows = [];

  for (let i = headerRowIdx + 1; i < allData.length; i++) {
    const row = allData[i];
    const rawStatus = String(row[col.status] || '').trim();
    if (!PENDING.includes(rawStatus.toUpperCase())) continue;
    if (!row[col.activity] && !row[col.userCode]) continue;

    const userCode = String(row[col.userCode] || '').trim();
    const parts    = userCode.split('-');
    const tienda   = parts.length >= 2 ? parts[1] : userCode;

    const fmtDate = (val) => {
      if (val instanceof Date) return Utilities.formatDate(val, tz, 'yyyy-MM-dd');
      const s = String(val || '').trim();
      return s.length >= 10 ? s.substring(0, 10) : s;
    };

    outputRows.push([
      Utilities.formatDate(now, tz, 'yyyy-MM-dd HH:mm'),  // A: Fecha Proceso
      String(row[col.country]  || '').trim(),              // B: País
      tienda,                                              // C: Tienda
      String(row[col.storeDept]|| '').trim(),              // D: Store/Dept
      String(row[col.activity] || '').trim(),              // E: Actividad
      rawStatus,                                           // F: Status
      row[col.score] || 0,                                 // G: Score
      userCode,                                            // H: Cód. Usuario
      col.jobTitle >= 0 ? String(row[col.jobTitle] || '').trim() : '', // I: Cargo
      fmtDate(row[col.regDate]),                           // J: Fecha Registro
      fmtDate(row[col.lastEnter]),                         // K: Última Entrada
      reportDateStr                                        // L: Fecha Reporte
    ]);
  }

  const ss          = SpreadsheetApp.getActiveSpreadsheet();
  let   rendSheet   = ss.getSheetByName('Rendimiento_Cursos');
  if (!rendSheet)   rendSheet = ss.insertSheet('Rendimiento_Cursos');
  rendSheet.clearContents();

  const sheetHeader = [['Fecha Proceso','País','Tienda','Store/Dept','Actividad','Status','Score',
                         'Cód. Usuario','Cargo','Fecha Registro','Última Entrada','Fecha Reporte']];
  rendSheet.getRange(1, 1, 1, 12).setValues(sheetHeader);

  if (outputRows.length > 0) {
    rendSheet.getRange(2, 1, outputRows.length, 12).setValues(outputRows);
  }

  let summarySheet = ss.getSheetByName('Rendimiento_Cursos_Resumen');
  if (!summarySheet) summarySheet = ss.insertSheet('Rendimiento_Cursos_Resumen');
  summarySheet.clearContents();

  const summaryHeader = [['Fecha Proceso','País','Tienda','Completed','In Progress','Not Completed','Total','Completion Rate','Fecha Reporte']];
  const summaryRows = Object.keys(summaryByCountryStore).sort().map(key => {
    const d = summaryByCountryStore[key];
    const rate = d.total > 0 ? d.completed / d.total : 0;
    return [
      Utilities.formatDate(now, tz, 'yyyy-MM-dd HH:mm'),
      d.pais,
      d.tienda,
      d.completed,
      d.inProgress,
      d.notCompleted,
      d.total,
      rate,
      reportDateStr
    ];
  });
  summarySheet.getRange(1, 1, 1, 9).setValues(summaryHeader);
  if (summaryRows.length > 0) {
    summarySheet.getRange(2, 1, summaryRows.length, 9).setValues(summaryRows);
    summarySheet.getRange(2, 8, summaryRows.length, 1).setNumberFormat('0.0%');
  }

  const props = PropertiesService.getScriptProperties();
  props.setProperty('ENOCTA_LAST_UPDATE',    Utilities.formatDate(now, tz, 'yyyy-MM-dd HH:mm'));
  props.setProperty('ENOCTA_TOTAL_PENDING',  outputRows.length.toString());
  props.setProperty('ENOCTA_REPORT_DATE',    reportDateStr);

  console.log('Enocta: ' + outputRows.length + ' registros pendientes escritos en Rendimiento_Cursos.');
}

/**
 * Returns training performance data for the Rendimiento dashboard.
 * filtros: { pais, tienda, status } — pass null/empty string/'TODOS' to skip each filter.
 */
function getRendimientoData(filtros) {
  try {
    const ss    = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName('Rendimiento_Cursos');
    const props      = PropertiesService.getScriptProperties();
    const lastUpdate = props.getProperty('ENOCTA_LAST_UPDATE');
    const reportDate = props.getProperty('ENOCTA_REPORT_DATE');
    const savedTotalPending = Number(props.getProperty('ENOCTA_TOTAL_PENDING') || 0);

    if (!sheet || sheet.getLastRow() < 2) {
      return {
        rows:         [],
        stats:        {},
        lastUpdate:   lastUpdate,
        totalPending: savedTotalPending,
        reportDate:   reportDate
      };
    }

    const data = sheet.getDataRange().getValues();
    // data[0] = header row; data[1+] = records
    // Columns: 0=FechaProceso,1=País,2=Tienda,3=StoreDept,4=Actividad,5=Status,6=Score,
    //          7=CódUsuario,8=Cargo,9=FechaRegistro,10=ÚltimaEntrada,11=FechaReporte

    const allRows = data.slice(1)
      .filter(r => r[4] && String(r[4]).trim()) // must have Actividad
      .map(r => ({
        fechaProceso:  String(r[0] || ''),
        pais:          String(r[1] || '').trim(),
        tienda:        String(r[2] || '').trim(),
        storeDept:     String(r[3] || '').trim(),
        actividad:     String(r[4] || '').trim(),
        status:        String(r[5] || '').trim(),
        score:         r[6] || 0,
        codUsuario:    String(r[7] || '').trim(),
        cargo:         String(r[8] || '').trim(),
        fechaRegistro: String(r[9] || '').trim(),
        ultimaEntrada: String(r[10]|| '').trim(),
        fechaReporte:  String(r[11]|| '').trim()
      }));

    const f = filtros || {};
    const scopedCountry = normalizeCountryName_(f.scopePais || '');
    const statsRows = scopedCountry
      ? allRows.filter(r => normalizeCountryName_(r.pais).toUpperCase() === scopedCountry.toUpperCase())
      : allRows;

    // Stats — computed from the user's visible scope.
    const stats = {};
    statsRows.forEach(r => {
      const key = r.pais || 'SIN PAÍS';
      if (!stats[key]) stats[key] = { total: 0, inProgress: 0, notStarted: 0 };
      stats[key].total++;
      if (r.status.toUpperCase() === 'IN PROGRESS')  stats[key].inProgress++;
      if (r.status.toUpperCase() === 'NOT STARTED')  stats[key].notStarted++;
    });

    // Apply filters to rows returned for the table
    let rows = statsRows;
    if (f.pais   && f.pais   !== 'TODOS') rows = rows.filter(r => normalizeCountryName_(r.pais).toUpperCase() === normalizeCountryName_(f.pais).toUpperCase());
    if (f.tienda && f.tienda !== 'TODAS') rows = rows.filter(r => r.tienda.toUpperCase() === f.tienda.toUpperCase());
    if (f.status && f.status !== 'TODOS') rows = rows.filter(r => r.status.toUpperCase() === f.status.toUpperCase());

    return {
      rows:         rows,
      stats:        stats,
      lastUpdate:   lastUpdate,
      totalPending: statsRows.length,
      reportDate:   reportDate
    };

  } catch (e) {
    console.error('getRendimientoData error: ' + e.message);
    return { rows: [], stats: {}, lastUpdate: null, totalPending: 0, reportDate: null };
  }
}


// ─── DESPACHOS ────────────────────────────────────────────────────────────────
const MERCANCIA_SS_ID = "1s9C9lTCBBfIqqfCnPdyFwAJ2ovg3jYIooNZUJ40tRvY";
const MERCANCIA_TAB   = "MERCANCIA LCW";
const RESUMEN_TAB     = "Resumen LCW - Boxes";

function parseDespNumber_(value) {
  if (typeof value === "number") return value;
  const normalized = String(value || "").replace(/[$,\s]/g, "");
  const parsed = Number(normalized);
  return isNaN(parsed) ? 0 : parsed;
}

function getDespachos(storeName, countryFilter) {
  try {
    const ss     = SpreadsheetApp.openById(MERCANCIA_SS_ID);
    const target = String(storeName || "").trim().toUpperCase();
    const isAllStores = !target || target === "__ALL__" || target === "REGIONAL";
    const normalizedCountry = normalizeCountryName_(countryFilter);

    const shouldIncludeTarget_ = storeCode => {
      const code = String(storeCode || "").trim().toUpperCase();
      if (!code) return false;
      if (!isAllStores) return code === target;
      if (normalizedCountry) return normalizeCountryName_(LCW_COUNTRY_MAP[code]) === normalizedCountry;
      return true;
    };

    // ── 1. Resumen LCW - Boxes → totales por invoice (cajas, unidades, status) ─
    const wsR = ss.getSheetByName(RESUMEN_TAB);
    if (!wsR) return { error: "Hoja Resumen LCW - Boxes no encontrada." };

    const dataR = wsR.getDataRange().getValues();
    if (dataR.length < 2) return { despachos: [] };

    const hdrR      = dataR[0].map(h => String(h).trim());
    const iDespacho = hdrR.indexOf("Despacho");
    const iInvoice  = hdrR.indexOf("Invoice ID");
    const iTarget   = hdrR.indexOf("Target Store");
    const iQty      = hdrR.indexOf("Quantity");
    const iCajas    = hdrR.indexOf("Cajas");
    const iStatus   = hdrR.indexOf("Status Tienda");
    const iStatusRS = hdrR.indexOf("Status RS");
    const iFecha    = hdrR.indexOf("Fecha Llegada");
    const iAlbaran  = hdrR.indexOf("Albaranes ICG");
    const iFob      = hdrR.findIndex(h => ["FOB", "FOB TOTAL", "TOTAL FOB", "AMOUNT", "IMPORTE"].includes(String(h || "").trim().toUpperCase()));

    if (iDespacho < 0 || iInvoice < 0 || iTarget < 0) {
      return { error: "Columnas faltantes en Resumen LCW - Boxes: " + hdrR.join(", ") };
    }

    const despMap = {};
    for (let r = 1; r < dataR.length; r++) {
      const row = dataR[r];
      const targetStore = String(row[iTarget] || "").trim().toUpperCase();
      if (!shouldIncludeTarget_(targetStore)) continue;
      const despacho  = String(row[iDespacho] || "").trim();
      const invoiceId = String(row[iInvoice]  || "").trim();
      if (!despacho || !invoiceId) continue;
      if (!despMap[despacho]) despMap[despacho] = {};
      const invKey = targetStore + "|" + invoiceId;
      if (!despMap[despacho][invKey]) {
        despMap[despacho][invKey] = { store: targetStore, invoiceId, cajas: 0, unidades: 0, fob: 0, status: "", statusRS: "", fechaLlegada: "", albaranesICG: [], depts: [] };
      }
      const inv = despMap[despacho][invKey];
      inv.unidades += iQty   >= 0 ? parseDespNumber_(row[iQty])    : 0;
      inv.cajas    += iCajas >= 0 ? parseDespNumber_(row[iCajas])  : 0;
      inv.fob      += iFob   >= 0 ? parseDespNumber_(row[iFob])    : 0;
      if (iStatus   >= 0 && row[iStatus])   inv.status       = String(row[iStatus]).trim();
      if (iStatusRS >= 0 && row[iStatusRS]) inv.statusRS     = String(row[iStatusRS]).trim();
      if (iFecha    >= 0 && row[iFecha])    inv.fechaLlegada = String(row[iFecha]).trim();
      if (iAlbaran  >= 0 && row[iAlbaran]) {
        const albaran = String(row[iAlbaran]).trim();
        if (albaran && inv.albaranesICG.indexOf(albaran) === -1) inv.albaranesICG.push(albaran);
      }
    }

    // ── 2. MERCANCIA LCW → desglose por Season Code / Merch Group Code ─────────
    const wsM = ss.getSheetByName(MERCANCIA_TAB);
    if (wsM && wsM.getLastRow() > 1) {
      const dataM = wsM.getDataRange().getValues();
      const hdrM  = dataM[0].map(h => String(h).trim());
      const mDesp   = hdrM.indexOf("Despacho");
      const mInv    = hdrM.indexOf("Invoice ID");
      const mTarget = hdrM.indexOf("Target Store");
      const mSeason = hdrM.indexOf("Season Code");
      const mMerch  = hdrM.indexOf("Merch Group Code");
      const mQty    = hdrM.indexOf("Quantity");
      if (mDesp >= 0 && mInv >= 0 && mTarget >= 0) {
        for (let r = 1; r < dataM.length; r++) {
          const row = dataM[r];
          const targetStore = String(row[mTarget] || "").trim().toUpperCase();
          if (!shouldIncludeTarget_(targetStore)) continue;
          const despacho  = String(row[mDesp] || "").trim();
          const invoiceId = String(row[mInv]  || "").trim();
          if (!despacho || !invoiceId) continue;
          const invKey = targetStore + "|" + invoiceId;
          if (!despMap[despacho]?.[invKey]) continue;
          despMap[despacho][invKey].depts.push({
            season:   mSeason >= 0 ? String(row[mSeason] || "").trim() : "",
            merch:    mMerch  >= 0 ? String(row[mMerch]  || "").trim() : "",
            quantity: mQty    >= 0 ? parseDespNumber_(row[mQty])       : 0
          });
        }
      }
    }

    const despachos = Object.keys(despMap).sort().map(despacho => ({
      despacho,
      invoices: Object.keys(despMap[despacho]).map(invKey => {
        const inv = despMap[despacho][invKey];
        return { store: inv.store, invoiceId: inv.invoiceId, cajas: inv.cajas, unidades: inv.unidades, fob: inv.fob, status: inv.status, statusRS: inv.statusRS, fechaLlegada: inv.fechaLlegada, albaranesICG: inv.albaranesICG, depts: inv.depts };
      })
    }));

    return { despachos };
  } catch (e) {
    return { error: e.message };
  }
}

function _markRecibidoInSheet(ws, storeName, invoiceId, fechaLlegada) {
  const data = ws.getDataRange().getValues();
  if (data.length < 2) return 0;

  const hdr = data[0].map(h => String(h).trim());
  const iInvoice = hdr.indexOf("Invoice ID");
  const iTarget  = hdr.indexOf("Target Store");
  const iStatus  = hdr.indexOf("Status Tienda");
  const iFecha   = hdr.indexOf("Fecha Llegada");

  if (iInvoice < 0 || iTarget < 0 || iStatus < 0) return 0;

  const target = String(storeName || "").trim().toUpperCase();
  const invId  = String(invoiceId || "").trim();
  let updated  = 0;

  for (let r = 1; r < data.length; r++) {
    const row = data[r];
    if (String(row[iTarget]  || "").trim().toUpperCase() !== target) continue;
    if (String(row[iInvoice] || "").trim()               !== invId)  continue;
    ws.getRange(r + 1, iStatus + 1).setValue("RECIBIDO");
    if (iFecha >= 0) ws.getRange(r + 1, iFecha + 1).setValue(fechaLlegada);
    updated++;
  }
  return updated;
}

function markInvoiceRecibido(storeName, invoiceId, fechaLlegada) {
  try {
    const ss        = SpreadsheetApp.openById(MERCANCIA_SS_ID);
    const wsMerc    = ss.getSheetByName(MERCANCIA_TAB);
    const wsResumen = ss.getSheetByName(RESUMEN_TAB);

    if (!wsMerc)    return { error: "Hoja MERCANCIA LCW no encontrada." };
    if (!wsResumen) return { error: "Hoja Resumen LCW - Boxes no encontrada." };

    const updatedMerc    = _markRecibidoInSheet(wsMerc,    storeName, invoiceId, fechaLlegada);
    const updatedResumen = _markRecibidoInSheet(wsResumen, storeName, invoiceId, fechaLlegada);

    SpreadsheetApp.flush();
    return { updated: updatedMerc + updatedResumen };
  } catch (e) {
    return { error: e.message };
  }
}

// ─── RETAIL STORE ─────────────────────────────────────────────────────────────

var SUPABASE_URL_ = 'https://rumdqlurjxylxjigmgar.supabase.co';

function getSupabaseKey_() {
  return PropertiesService.getScriptProperties().getProperty('SUPABASE_KEY');
}

function supabaseGet_(table, params) {
  var key = getSupabaseKey_();
  if (!key) throw new Error('SUPABASE_KEY no está configurado en Script Properties.');

  var url = SUPABASE_URL_ + '/rest/v1/' + table + '?' + params;
  var res = UrlFetchApp.fetch(url, {
    method: 'GET',
    headers: {
      'apikey': key,
      'Authorization': 'Bearer ' + key,
      'Content-Type': 'application/json'
    },
    muteHttpExceptions: true
  });

  if (res.getResponseCode() !== 200) {
    throw new Error('Supabase ' + res.getResponseCode() + ': ' + res.getContentText().slice(0, 200));
  }

  return JSON.parse(res.getContentText());
}

function supabaseGetAll_(table, baseParams, pageSize, maxRows) {
  var all = [];
  var limit = pageSize || 10000;
  var cap = maxRows || 500000;
  var offset = 0;

  while (all.length < cap) {
    var batch = supabaseGet_(table, baseParams + '&limit=' + limit + '&offset=' + offset);
    if (!batch || !batch.length) break;
    all = all.concat(batch);
    if (batch.length < limit) break;
    offset += limit;
  }

  return all;
}

function isRetailStoreDepoToRayon_(row) {
  var fromWarehouse = String(row && row.from_warehouse || '').trim().toUpperCase();
  var toWarehouse = String(row && row.to_warehouse || '').trim().toUpperCase();
  return fromWarehouse.slice(-1) === 'D' && toWarehouse.slice(-1) === 'R';
}

function parseRetailStoreDateValue_(value) {
  var raw = String(value || '').trim();
  if (!raw) return null;
  var match;
  if ((match = raw.match(/^(\d{4})-(\d{2})-(\d{2})/))) {
    return new Date(Number(match[1]), Number(match[2]) - 1, Number(match[3]));
  }
  if ((match = raw.match(/^(\d{1,2})[\/.-](\d{1,2})[\/.-](\d{4})/))) {
    return new Date(Number(match[3]), Number(match[2]) - 1, Number(match[1]));
  }
  var parsed = new Date(raw);
  return isNaN(parsed.getTime()) ? null : parsed;
}

function getRetailStoreData(storeName, role) {
  try {
    var isAdmin = String(role || '').toUpperCase() === 'ADMIN';
    var storeFilter = String(storeName || '').trim();
    var rowCap = storeFilter ? 100000 : (isAdmin ? 500000 : 100000);

    var params41 = 'rayon_stock=eq.0&warehouse_stock=gt.0&select=country,store_id,report_date,specialcode1,season,name,color,size,top_group,merch_sub_group,line,rayon_stock,warehouse_stock,reserved_stock,total_stock,location_quantity&order=warehouse_stock.desc';
    if (storeFilter) params41 += '&store_id=eq.' + encodeURIComponent(storeFilter);
    var rs41 = supabaseGetAll_('rs_41_inventario', params41, 1000, rowCap);

    var params55 = 'select=store_id,report_date,from_warehouse,to_warehouse,specialcode1,season,name,color,size,top_group,merch_sub_group,quantity,scanning_date,scanning_type&order=scanning_date.desc';
    if (storeFilter) params55 += '&store_id=eq.' + encodeURIComponent(storeFilter);
    var rs55 = supabaseGetAll_('rs_55_movimientos', params55, 1000, rowCap);
    var rs55DepoRayon = rs55.filter(isRetailStoreDepoToRayon_);

    var rs25 = [];
    try {
      var params25 = 'select=country,store_id,report_date,top_group,merch_sub_group,net_sale_quantity,basket_quantity,sales_transaction_quantity&order=net_sale_quantity.desc';
      if (storeFilter) params25 += '&store_id=eq.' + encodeURIComponent(storeFilter);
      rs25 = supabaseGetAll_('rs_25_canasta', params25, 1000, rowCap);
    } catch (rs25Err) {
      Logger.log('getRetailStoreData rs_25_canasta warning: ' + rs25Err.message);
      rs25 = [];
    }

    var paramsStock = 'select=country,store_id,report_date,specialcode1,barcode,name,color,size,warehouse,rayon,total_stock,season,merch_group,merch_sub_group,product_family,merch_sub_group_name_eng,merch_brand_age_group_name_eng,last_acceptance_date,location_quantity';
    if (storeFilter) paramsStock += '&store_id=eq.' + encodeURIComponent(storeFilter);
    var stockRows = supabaseGetAll_('rs_01_master_family', paramsStock, 1000, rowCap);
    rsEnrichSalesSubGroupDescriptions_(rs25, stockRows);

    var enBodega = 0;

    stockRows.forEach(function(row) {
      enBodega += Number(row.warehouse || 0);
    });

    var porReponer = rs41.reduce(function(sum, row) {
      return sum + Number(row.warehouse_stock || 0);
    }, 0);

    var movimientos = rs55DepoRayon.reduce(function(sum, row) {
      return sum + Number(row.quantity || 0);
    }, 0);

    var negativosRayon = 0;
    var ultimaRecepcionDate = null;
    var uniqueSizeMap = {};
    stockRows.forEach(function(row) {
      var warehouseQty = Number(row.warehouse || 0);
      var rayon = Number(row.rayon || 0);
      if (rayon < 0) negativosRayon += Math.abs(rayon);
      if (warehouseQty > 0) {
        var uniqueKey = [
          String(row.specialcode1 || '').trim().toUpperCase(),
          String(row.color || '').trim().toUpperCase()
        ].join('||');
        if (uniqueKey !== '||') uniqueSizeMap[uniqueKey] = (uniqueSizeMap[uniqueKey] || 0) + warehouseQty;
      }
      var received = parseRetailStoreDateValue_(row.last_acceptance_date);
      if (received && (!ultimaRecepcionDate || received.getTime() > ultimaRecepcionDate.getTime())) {
        ultimaRecepcionDate = received;
      }
    });

    var tallasUnicas = 0;
    var tallasUnicasUnidades = 0;
    Object.keys(uniqueSizeMap).forEach(function(key) {
      var qty = uniqueSizeMap[key] || 0;
      if (qty <= 3) {
        tallasUnicas += 1;
        tallasUnicasUnidades += qty;
      }
    });

    var reportDate = '';
    if (stockRows.length > 0 && stockRows[0].report_date) reportDate = stockRows[0].report_date;
    else if (rs25.length > 0 && rs25[0].report_date) reportDate = rs25[0].report_date;
    else if (rs41.length > 0 && rs41[0].report_date) reportDate = rs41[0].report_date;
    else if (rs55.length > 0 && rs55[0].report_date) reportDate = rs55[0].report_date;

    return {
      error: null,
      reportDate: reportDate,
      rs01: stockRows,
      rs25: rs25,
      rs41: rs41,
      rs55: rs55DepoRayon,
      kpis: {
        enBodega: enBodega,
        porReponer: porReponer,
        movimientos: movimientos,
        negativosRayon: negativosRayon,
        tallasUnicas: tallasUnicas,
        tallasUnicasUnidades: tallasUnicasUnidades,
        tallasUnicasPctWarehouse: enBodega > 0 ? (tallasUnicasUnidades / enBodega) * 100 : 0,
        ultimaRecepcion: ultimaRecepcionDate
          ? Utilities.formatDate(ultimaRecepcionDate, Session.getScriptTimeZone(), 'yyyy-MM-dd')
          : ''
      }
    };
  } catch (e) {
    Logger.log('getRetailStoreData error: ' + e.message);
    return { error: e.message };
  }
}

function rsEnrichSalesSubGroupDescriptions_(salesRows, stockRows) {
  var descMap = {};
  (stockRows || []).forEach(function(row) {
    var code = String(row.merch_sub_group || '').trim().toUpperCase();
    var desc = String(row.merch_sub_group_name_eng || row.merch_sub_group_name || '').trim();
    if (code && desc && !descMap[code]) descMap[code] = desc;
  });

  try {
    var mappingRows = supabaseGetAll_('retail_product_family_mapping', 'select=merch_sub_group,merch_sub_group_name_eng,merch_sub_group_name', 1000, 10000);
    (mappingRows || []).forEach(function(row) {
      var code = String(row.merch_sub_group || '').trim().toUpperCase();
      var desc = String(row.merch_sub_group_name_eng || row.merch_sub_group_name || '').trim();
      if (code && desc && !descMap[code]) descMap[code] = desc;
    });
  } catch (mappingErr) {
    Logger.log('rsEnrichSalesSubGroupDescriptions_ mapping warning: ' + mappingErr.message);
  }

  (salesRows || []).forEach(function(row) {
    var code = String(row.merch_sub_group || '').trim().toUpperCase();
    row.merch_sub_group_description = descMap[code] || '';
  });
}

function getInventoryAuditRsSnapshot(storeName) {
  try {
    var storeFilter = String(storeName || '').trim();
    if (!storeFilter) throw new Error('Selecciona una tienda para consultar RS.');

    var baseFilter = '&store_id=eq.' + encodeURIComponent(storeFilter) + '&order=barcode.asc';
    var params = 'select=country,store_id,report_date,specialcode1,barcode,name,color,size,total_stock,warehouse,rayon,season,merch_group,merch_sub_group,product_family,last_acceptance_date' + baseFilter;
    var rows = supabaseGetAll_('rs_01_master_family', params, 1000, 150000);
    var totalUnits = rows.reduce(function(sum, row) {
      return sum + Number(row.total_stock || 0);
    }, 0);
    var reportDate = '';
    if (rows.length > 0 && rows[0].report_date) reportDate = rows[0].report_date;

    return {
      error: null,
      store: storeFilter,
      reportDate: reportDate,
      totalRows: rows.length,
      totalUnits: totalUnits,
      rows: rows
    };
  } catch (e) {
    Logger.log('getInventoryAuditRsSnapshot error: ' + e.message);
    return { error: e.message, rows: [] };
  }
}

function sendInventoryAuditEmail(payload) {
  var recipients = getInventoryAuditRecipients_((payload && payload.store) || '');
  var spreadsheetId = '';
  try {
    if (!payload || !Array.isArray(payload.headers) || !Array.isArray(payload.rows)) {
      throw new Error('No hay datos válidos para enviar.');
    }
    if (!payload.rows.length) throw new Error('No hay resultados para enviar.');

    var store = String(payload.store || 'Tienda').trim();
    var mode = String(payload.mode || 'CONTEO').trim();
    var title = String(payload.title || 'Auditoría de Inventario').trim();
    var fileBase = sanitizeFilename_(payload.fileBase || ('Auditoria_Inventario_' + store));
    var generatedAt = Utilities.formatDate(new Date(), Session.getScriptTimeZone(), 'yyyy-MM-dd HH:mm');

    var ss = SpreadsheetApp.create(fileBase);
    spreadsheetId = ss.getId();
    var sheet = ss.getSheets()[0];
    sheet.setName('Resultado');

    var headers = payload.headers.map(function(value) { return String(value == null ? '' : value); });
    var rows = payload.rows.map(function(row) {
      return headers.map(function(_, index) {
        var value = Array.isArray(row) ? row[index] : '';
        return value == null ? '' : value;
      });
    });

    sheet.getRange(1, 1, 1, headers.length).setValues([headers]);
    sheet.getRange(1, 1, 1, headers.length)
      .setBackground('#1565C0')
      .setFontColor('#ffffff')
      .setFontWeight('bold');
    if (rows.length) {
      sheet.getRange(2, 1, rows.length, headers.length).setValues(rows);
    }
    sheet.setFrozenRows(1);
    sheet.autoResizeColumns(1, headers.length);

    var summary = ss.insertSheet('Resumen');
    var kpis = payload.kpis || {};
    var summaryRows = [
      ['Reporte', title],
      ['Tienda', store],
      ['Modo', mode],
      ['Generado', generatedAt],
      ['Filtro', payload.filter || 'Estado: Todos'],
      ['Búsqueda', payload.search || ''],
      ['Meta', payload.meta || ''],
      ['RS Total', kpis.rs || '0'],
      ['Warehouse', kpis.warehouse || '0'],
      ['Rayón', kpis.rayon || '0'],
      ['ICG', kpis.icg || '0'],
      ['Conteo', kpis.count || '0'],
      ['Diferencias', kpis.diff || '0'],
      ['Barcodes en resultado', kpis.barcodes || String(rows.length)]
    ];
    summary.getRange(1, 1, summaryRows.length, 2).setValues(summaryRows);
    summary.getRange(1, 1, summaryRows.length, 1).setFontWeight('bold');
    summary.autoResizeColumns(1, 2);
    ss.setActiveSheet(sheet);
    SpreadsheetApp.flush();

    var exportUrl = 'https://docs.google.com/spreadsheets/d/' + spreadsheetId + '/export?format=xlsx';
    var xlsxBlob = UrlFetchApp.fetch(exportUrl, {
      headers: { Authorization: 'Bearer ' + ScriptApp.getOAuthToken() },
      muteHttpExceptions: true
    }).getBlob().setName(fileBase + '.xlsx');

    var htmlBody =
      '<div style="font-family:Arial,sans-serif;color:#111827">' +
      '<h2 style="margin:0 0 8px">LC Waikiki | ' + escapeHtml_(title) + '</h2>' +
      '<p style="margin:0 0 12px;color:#6b7280">Tienda: <strong>' + escapeHtml_(store) + '</strong> | Modo: <strong>' + escapeHtml_(mode) + '</strong></p>' +
      '<p style="margin:0 0 12px">Adjunto encontrarás el Excel con los resultados filtrados de la pantalla de Auditoría.</p>' +
      '<table style="border-collapse:collapse;font-size:13px">' +
      '<tr><td style="padding:4px 10px 4px 0;color:#6b7280">Registros</td><td style="padding:4px 0;font-weight:700">' + rows.length.toLocaleString() + '</td></tr>' +
      '<tr><td style="padding:4px 10px 4px 0;color:#6b7280">Filtro</td><td style="padding:4px 0;font-weight:700">' + escapeHtml_(payload.filter || 'Estado: Todos') + '</td></tr>' +
      '<tr><td style="padding:4px 10px 4px 0;color:#6b7280">Generado</td><td style="padding:4px 0;font-weight:700">' + escapeHtml_(generatedAt) + '</td></tr>' +
      '</table>' +
      '<p style="margin-top:18px;font-size:11px;color:#9ca3af">Prueba enviada desde LC Waikiki Retail Pro. Esta acción no modifica inventarios.</p>' +
      '</div>';

    MailApp.sendEmail({
      to: recipients.join(','),
      subject: 'LC Waikiki | ' + store + ' | ' + title,
      htmlBody: htmlBody,
      attachments: [xlsxBlob],
      name: 'LC Waikiki Retail Pro'
    });

    return { success: true, recipients: recipients };
  } catch (e) {
    Logger.log('sendInventoryAuditEmail error: ' + e.message);
    return { success: false, message: e.message, recipients: recipients };
  } finally {
    if (spreadsheetId) {
      try {
        DriveApp.getFileById(spreadsheetId).setTrashed(true);
      } catch (trashErr) {
        Logger.log('No se pudo eliminar temporal auditoría: ' + trashErr.message);
      }
    }
  }
}

function getInventoryAuditRecipients_(storeName) {
  return ['luisvelasquez@grupodavid.com', 'elisortega@grupodavid.com'];
}

function sanitizeFilename_(value) {
  return String(value || 'archivo').replace(/[\\/:*?"<>|#%{}~&]/g, '_').replace(/\s+/g, '_').slice(0, 120);
}

function escapeHtml_(value) {
  return String(value == null ? '' : value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function normalizeRetailReportType_(value) {
  var raw = String(value || '').trim().toUpperCase().replace(/[^A-Z0-9]/g, '');
  if (raw === 'AUTO' || raw === 'AUTODETECTAR' || raw === 'AUTODETECT') return 'AUTO';
  if (raw === '1' || raw === '01' || raw === 'RS1' || raw === 'RS01') return 'RS01';
  if (raw === '6' || raw === '06' || raw === 'RS6' || raw === 'RS06') return 'RS06';
  if (raw === '25' || raw === 'RS25') return 'RS25';
  if (raw === '41' || raw === 'RS41') return 'RS41';
  if (raw === '44' || raw === 'RS44') return 'RS44';
  if (raw === '55' || raw === 'RS55') return 'RS55';
  if (raw === '63' || raw === 'RS63') return 'RS63';
  return 'OTRO';
}

function getRetailReportTypeFromFileName_(fileName) {
  var raw = String(fileName || '').toUpperCase();
  var rsMatch = raw.match(/(?:^|[^A-Z0-9])RS[_\-\s]?0?([0-9]{1,2})(?:[^0-9]|$)/);
  if (rsMatch) return normalizeRetailReportType_(rsMatch[1]);
  var reportMatch = raw.match(/(?:^|[^A-Z0-9])(?:REPORTE|REPORT)(?:\s*(?:NRO|NO|NUMERO|NUMBER|#))?[\s._#-]*0?([0-9]{1,2})(?:[^0-9]|$)/);
  return reportMatch ? normalizeRetailReportType_(reportMatch[1]) : '';
}

function getRetailReportExpectedColumnCounts_() {
  return {
    RS01: 31,
    RS06: 16,
    RS25: 17,
    RS35: 24,
    RS41: 16,
    RS44: 20,
    RS55: 19,
    RS63: 13
  };
}

function retailReportExpectedCountIsUnique_(reportType, expectedCounts) {
  var target = expectedCounts && expectedCounts[reportType];
  if (!target) return false;
  return Object.keys(expectedCounts).filter(function(type) {
    return expectedCounts[type] === target;
  }).length === 1;
}

function normalizeRetailHeaderKey_(value) {
  return String(value || '')
    .replace(/[ıİ]/g, 'i')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]/g, '');
}

function getRetailReportHeaderSpecs_() {
  return {
    RS01: [
      ['storecode', 'store'],
      ['specialcode1', 'specialcode'],
      ['merchgroup'],
      ['merchsubgroup'],
      ['season'],
      ['color', 'colorcode'],
      ['warehouse', 'warehousestock'],
      ['rayon', 'rayonstock'],
      ['totalstock']
    ],
    RS06: [
      ['brand'],
      ['specialcode', 'specialcode1'],
      ['totalsale'],
      ['totalreturn'],
      ['netsale'],
      ['cumulativesales'],
      ['stokmiktar', 'stockquantity'],
      ['lastreceivingdate', 'lastacceptance']
    ],
    RS25: [
      ['warehouse'],
      ['description'],
      ['topgroup'],
      ['merchsubgroup'],
      ['netsaleamount'],
      ['netsalequantity'],
      ['basketquantity']
    ],
    RS41: [
      ['specialcode1', 'specialcode'],
      ['locationquantity', 'locationqty', 'location'],
      ['rayonstock'],
      ['warehousestock'],
      ['reservedstock'],
      ['totalstock'],
      ['isitoutliersize']
    ],
    RS44: [
      ['reyonstok', 'rayonstock'],
      ['depostok', 'warehousestock'],
      ['lastsales'],
      ['firstexpedition']
    ],
    RS55: [
      ['fromwarehouse', 'fromwarehousecode'],
      ['towarehouse', 'towarehousecode'],
      ['specialcode1', 'specialcode'],
      ['scanningtype'],
      ['scanningdate', 'date'],
      ['quantity', 'qty']
    ],
    RS63: [
      ['specialcode1', 'specialcode'],
      ['stockquantity'],
      ['reservedquantity'],
      ['warehousequantity'],
      ['rayonquantity'],
      ['assignmentdate'],
      ['labeltype']
    ]
  };
}

function getRetailUploadMimeType_(fileName, mimeType) {
  var lower = String(fileName || '').toLowerCase();
  var type = String(mimeType || '').trim();
  if (lower.endsWith('.csv')) return 'text/csv';
  if (lower.endsWith('.xls')) return 'application/vnd.ms-excel';
  if (lower.endsWith('.xlsx')) return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
  return type || 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
}

function extractRetailUploadHeaderRows_(bytes, mimeType, fileName) {
  var lower = String(fileName || '').toLowerCase();
  if (lower.endsWith('.csv') || String(mimeType || '').toLowerCase().indexOf('csv') > -1) {
    var csvText = Utilities.newBlob(bytes, mimeType || 'text/csv', fileName || 'reporte.csv').getDataAsString();
    var csvRows = Utilities.parseCsv(csvText);
    return (csvRows || []).slice(0, 25).map(function(row) {
      return row.map(function(v) { return String(v || '').trim(); }).filter(function(v) { return v !== ''; });
    });
  }

  var blob = Utilities.newBlob(bytes, getRetailUploadMimeType_(fileName, mimeType), fileName || 'reporte.xlsx');
  var tempFile = Drive.Files.insert(
    { title: '_retail_header_check_' + new Date().getTime(), mimeType: 'application/vnd.google-apps.spreadsheet' },
    blob
  );
  try {
    var ss = SpreadsheetApp.openById(tempFile.id);
    var sheet = ss.getSheets()[0];
    var lastCol = Math.min(sheet.getLastColumn(), 80);
    var lastRow = Math.min(sheet.getLastRow(), 25);
    if (!lastCol) return [];
    if (!lastRow) return [];
    return sheet.getRange(1, 1, lastRow, lastCol).getValues().map(function(row) {
      return row.map(function(v) {
        return String(v || '').trim();
      }).filter(function(v) {
        return v !== '';
      });
    });
  } finally {
    try { Drive.Files.trash(tempFile.id); } catch (err) {}
  }
}

function extractRetailUploadHeaders_(bytes, mimeType, fileName) {
  var rows = extractRetailUploadHeaderRows_(bytes, mimeType, fileName);
  return rows && rows.length ? rows[0] : [];
}

function retailHeaderHasAlias_(normalized, aliases) {
  return aliases.some(function(alias) {
    var key = normalizeRetailHeaderKey_(alias);
    if (normalized[key]) return true;
    return Object.keys(normalized).some(function(headerKey) {
      return headerKey === key || headerKey.indexOf(key) > -1 || key.indexOf(headerKey) > -1;
    });
  });
}

function detectRetailReportTypeFromHeaders_(headers) {
  var normalized = {};
  (headers || []).forEach(function(header) {
    var key = normalizeRetailHeaderKey_(header);
    if (key) normalized[key] = true;
  });

  var specs = getRetailReportHeaderSpecs_();
  var best = { type: '', matches: 0, missing: [] };
  Object.keys(specs).forEach(function(type) {
    var required = specs[type];
    var missing = required.filter(function(aliases) {
      return !retailHeaderHasAlias_(normalized, aliases);
    }).map(function(aliases) {
      return aliases[0];
    });
    var matches = required.length - missing.length;
    if (matches > best.matches) best = { type: type, matches: matches, missing: missing };
  });

  if (best.type && best.missing.length === 0) {
    return { type: best.type, confidence: 'HIGH', missing: [] };
  }
  return { type: best.type || '', confidence: 'LOW', missing: best.missing || [] };
}

function validateRetailUploadReportType_(bytes, mimeType, fileName, requestedReportType) {
  var requested = normalizeRetailReportType_(requestedReportType);
  var fileNameReportType = getRetailReportTypeFromFileName_(fileName);
  var expectedCounts = getRetailReportExpectedColumnCounts_();
  if (requested === 'OTRO') {
    return { reportType: 'OTRO', detectedReportType: '', headers: [] };
  }
  if (fileNameReportType && requested !== 'AUTO' && requested !== fileNameReportType) {
    throw new Error('El nombre del archivo parece ' + fileNameReportType + ', pero seleccionaste ' + requested + '. Corrige el tipo o usa Auto detectar.');
  }
  if (
    fileNameReportType &&
    (requested === 'AUTO' || requested === fileNameReportType) &&
    bytes &&
    bytes.length > 1500000
  ) {
    return {
      reportType: fileNameReportType,
      detectedReportType: fileNameReportType,
      headers: []
    };
  }

  var headerRows = extractRetailUploadHeaderRows_(bytes, mimeType, fileName);
  var bestLow = { type: '', missing: [], headers: [] };
  for (var i = 0; i < headerRows.length; i++) {
    var headers = headerRows[i] || [];
    if (!headers.length) continue;
    var detected = detectRetailReportTypeFromHeaders_(headers);
    if (detected.type && detected.confidence === 'HIGH') {
      if (requested !== 'AUTO' && requested !== detected.type) {
        throw new Error('El archivo parece ' + detected.type + ', pero seleccionaste ' + requested + '. Corrige el tipo o usa Auto detectar.');
      }
      return {
        reportType: detected.type,
        detectedReportType: detected.type,
        headers: headers
      };
    }
    if (detected.type && (!bestLow.type || detected.missing.length < bestLow.missing.length)) {
      bestLow = { type: detected.type, missing: detected.missing || [], headers: headers };
    }
  }

  if (
    fileNameReportType &&
    (requested === 'AUTO' || requested === fileNameReportType) &&
    expectedCounts[fileNameReportType] &&
    headerRows.some(function(headers) { return (headers || []).length === expectedCounts[fileNameReportType]; })
  ) {
    return {
      reportType: fileNameReportType,
      detectedReportType: fileNameReportType,
      headers: headerRows.filter(function(headers) { return (headers || []).length === expectedCounts[fileNameReportType]; })[0] || []
    };
  }

  if (
    requested !== 'AUTO' &&
    expectedCounts[requested] &&
    (fileNameReportType === requested || retailReportExpectedCountIsUnique_(requested, expectedCounts)) &&
    headerRows.some(function(headers) { return (headers || []).length === expectedCounts[requested]; })
  ) {
    return {
      reportType: requested,
      detectedReportType: requested,
      headers: headerRows.filter(function(headers) { return (headers || []).length === expectedCounts[requested]; })[0] || []
    };
  }

  if (
    fileNameReportType &&
    (requested === 'AUTO' || requested === fileNameReportType) &&
    bestLow.type === fileNameReportType &&
    (bestLow.missing || []).length <= 2
  ) {
    return {
      reportType: fileNameReportType,
      detectedReportType: fileNameReportType,
      headers: bestLow.headers || []
    };
  }

  if (bestLow.type) {
    throw new Error('No pude reconocer el tipo de reporte por los encabezados. Candidato: ' + bestLow.type + '. Faltan columnas: ' + bestLow.missing.join(', ') + '.');
  }
  throw new Error('No pude reconocer el tipo de reporte por los encabezados. Revisa que el archivo sea un RS válido.');
}

function sanitizeDriveName_(value) {
  var name = String(value || '').trim() || 'Sin nombre';
  return name.replace(/[\\\/:*?"<>|#%\u0000-\u001f]/g, '-').replace(/\s+/g, ' ').slice(0, 120);
}

function getOrCreateFolderByName_(name) {
  var safeName = sanitizeDriveName_(name);
  var existing = DriveApp.getFoldersByName(safeName);
  return existing.hasNext() ? existing.next() : DriveApp.createFolder(safeName);
}

function getOrCreateChildFolder_(parent, name) {
  var safeName = sanitizeDriveName_(name);
  var existing = parent.getFoldersByName(safeName);
  return existing.hasNext() ? existing.next() : parent.createFolder(safeName);
}

function getRetailUploadLogSheet_() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheetByName('RetailStoreUploads') || ss.insertSheet('RetailStoreUploads');
  if (sheet.getLastRow() === 0) {
    sheet.appendRow([
      'Timestamp', 'Store', 'Country', 'Report Type', 'Report Date', 'Standard Name',
      'Original Name', 'Drive URL', 'Drive File ID', 'Uploaded By', 'Status', 'Message'
    ]);
  }
  return sheet;
}

function buildRetailUploadFileName_(store, reportType, reportDate, originalName) {
  var extMatch = String(originalName || '').match(/\.([A-Za-z0-9]+)$/);
  var ext = extMatch ? extMatch[1].toLowerCase() : 'xlsx';
  var cleanDate = String(reportDate || Utilities.formatDate(new Date(), Session.getScriptTimeZone(), 'yyyy-MM-dd')).replace(/[^0-9]/g, '');
  var stamp = Utilities.formatDate(new Date(), Session.getScriptTimeZone(), 'yyyyMMdd_HHmmss');
  return sanitizeDriveName_(store) + '_' + reportType + '_' + cleanDate + '_' + stamp + '.' + ext;
}

function getRetailStoreDriveCountryFolderName_(country) {
  var normalized = normalizeCountryName_(country);
  var map = {
    'Costa Rica': 'COSTA RICA',
    'Curacao': 'CURACAO',
    'Dominican Republic': 'DOMINICAN REPUBLIC',
    'El Salvador': 'EL SALVADOR',
    'Guatemala': 'GUATEMALA',
    'Panamá': 'PANAMA',
    'Venezuela': 'VENEZUELA'
  };
  return map[normalized] || String(country || 'SIN PAIS').trim().toUpperCase();
}

function getRetailStoreUploadRootFolder_() {
  var rootId = String(PropertiesService.getScriptProperties().getProperty('RETAILSTORE_DRIVE_ROOT_FOLDER_ID') || '').trim();
  if (!rootId) rootId = '13q01TV9zDHcACUTlCjaenfpth_hpjeEM';
  try {
    return DriveApp.getFolderById(rootId);
  } catch (e) {
    return getOrCreateFolderByName_('LC Waikiki Retail Store Uploads');
  }
}

function getRetailStoreUploadTempRootFolder_() {
  return getOrCreateChildFolder_(getRetailStoreUploadRootFolder_(), '_TEMP_UPLOADS');
}

function getRetailStoreUploadTempFolder_(uploadId) {
  var id = String(uploadId || '').trim();
  if (!id) throw new Error('No se encontró la sesión de carga.');
  return DriveApp.getFolderById(id);
}

function buildRetailStoreChunkName_(index) {
  return ('000000' + Number(index || 0)).slice(-6) + '.part';
}

function trashRetailStoreFilesByName_(folder, fileName) {
  var files = folder.getFilesByName(fileName);
  while (files.hasNext()) {
    try { files.next().setTrashed(true); } catch (err) {}
  }
}

function cleanupRetailStoreChunkedUpload_(uploadId) {
  if (!uploadId) return;
  try {
    getRetailStoreUploadTempFolder_(uploadId).setTrashed(true);
  } catch (err) {}
}

function startRetailStoreChunkedUpload(payload) {
  try {
    payload = payload || {};
    var store = String(payload.store || '').trim().toUpperCase();
    var role = String(payload.role || '').trim().toUpperCase();
    if (!store && role !== 'ADMIN') throw new Error('No se pudo identificar la tienda.');
    if (!store) throw new Error('Selecciona una tienda para subir el reporte.');
    var originalName = String(payload.fileName || '').trim();
    if (!originalName) throw new Error('El archivo no tiene nombre.');

    var tempRoot = getRetailStoreUploadTempRootFolder_();
    var uploadFolder = tempRoot.createFolder('_retail_upload_' + Utilities.formatDate(new Date(), Session.getScriptTimeZone(), 'yyyyMMdd_HHmmss') + '_' + Utilities.getUuid());
    uploadFolder.createFile(
      'metadata.json',
      JSON.stringify({
        createdAt: new Date().toISOString(),
        store: store,
        fileName: originalName,
        reportType: String(payload.reportType || ''),
        reportDate: String(payload.reportDate || '')
      }),
      'application/json'
    );
    return { success: true, uploadId: uploadFolder.getId() };
  } catch (e) {
    return { success: false, message: e.message };
  }
}

function writeRetailStoreReportChunk(payload) {
  try {
    payload = payload || {};
    var index = Number(payload.index);
    var chunk = String(payload.chunk || '');
    if (!isFinite(index) || index < 0) throw new Error('Parte de archivo inválida.');
    if (!chunk) throw new Error('La parte del archivo llegó vacía.');

    var folder = getRetailStoreUploadTempFolder_(payload.uploadId);
    var fileName = buildRetailStoreChunkName_(index);
    trashRetailStoreFilesByName_(folder, fileName);
    folder.createFile(fileName, chunk, 'text/plain');
    return { success: true, index: index };
  } catch (e) {
    return { success: false, message: e.message };
  }
}

function readRetailStoreChunkedBase64_(uploadId, totalChunks) {
  var folder = getRetailStoreUploadTempFolder_(uploadId);
  var total = Number(totalChunks || 0);
  if (!isFinite(total) || total <= 0) throw new Error('No se recibieron partes para el archivo.');

  var base64 = '';
  for (var i = 0; i < total; i++) {
    var fileName = buildRetailStoreChunkName_(i);
    var files = folder.getFilesByName(fileName);
    if (!files.hasNext()) throw new Error('Falta una parte del archivo: ' + (i + 1) + ' de ' + total + '.');
    base64 += files.next().getBlob().getDataAsString();
  }
  return base64;
}

function cancelRetailStoreChunkedUpload(uploadId) {
  cleanupRetailStoreChunkedUpload_(uploadId);
  return { success: true };
}

function getRetailStoreGithubHeaders_(token) {
  return {
    'Authorization': 'Bearer ' + token,
    'Accept': 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28'
  };
}

function fetchRetailStoreGithubWorkflowRuns_(token, perPage) {
  var url = 'https://api.github.com/repos/luisvelasquez-alt/retailstore-master/actions/workflows/weekly_master.yml/runs?branch=main&event=workflow_dispatch&per_page=' + (perPage || 5);
  var response = UrlFetchApp.fetch(url, {
    method: 'GET',
    headers: getRetailStoreGithubHeaders_(token),
    muteHttpExceptions: true
  });
  if (response.getResponseCode() < 200 || response.getResponseCode() >= 300) return [];
  var payload = JSON.parse(response.getContentText() || '{}');
  return payload.workflow_runs || [];
}

function findRetailStoreGithubRunAfter_(token, previousRunId) {
  var previous = Number(previousRunId || 0);
  var runs = fetchRetailStoreGithubWorkflowRuns_(token, 10);
  for (var i = 0; i < runs.length; i++) {
    var runId = Number(runs[i].id || 0);
    if (!previous || runId > previous) return runs[i];
  }
  return null;
}

function waitForRetailStoreGithubRun_(token, previousRunId) {
  for (var i = 0; i < 6; i++) {
    var run = findRetailStoreGithubRunAfter_(token, previousRunId);
    if (run) return run;
    Utilities.sleep(2000);
  }
  return null;
}

function getRetailStoreSyncStatus(runId) {
  try {
    var githubToken = String(PropertiesService.getScriptProperties().getProperty('RETAILSTORE_GITHUB_TOKEN') || PropertiesService.getScriptProperties().getProperty('GITHUB_ACTIONS_TOKEN') || '').trim();
    if (!githubToken) return { success: false, status: 'unknown', message: 'No hay token de GitHub configurado.' };
    var id = String(runId || '').trim();
    if (!id) return { success: false, status: 'unknown', message: 'No hay workflow para consultar.' };
    var response = UrlFetchApp.fetch('https://api.github.com/repos/luisvelasquez-alt/retailstore-master/actions/runs/' + encodeURIComponent(id), {
      method: 'GET',
      headers: getRetailStoreGithubHeaders_(githubToken),
      muteHttpExceptions: true
    });
    var code = response.getResponseCode();
    if (code < 200 || code >= 300) {
      return { success: false, status: 'unknown', message: 'GitHub respondió ' + code + ' al consultar la carga.' };
    }
    var run = JSON.parse(response.getContentText() || '{}');
    var status = String(run.status || '').toLowerCase();
    var conclusion = String(run.conclusion || '').toLowerCase();
    var message = 'Cargando datos en Base de datos.';
    if (status === 'completed' && conclusion === 'success') message = 'Base de datos actualizada.';
    if (status === 'completed' && conclusion && conclusion !== 'success') message = 'La carga en Base de datos terminó con error: ' + conclusion + '.';
    return {
      success: true,
      status: status,
      conclusion: conclusion,
      runId: run.id,
      url: run.html_url,
      message: message
    };
  } catch (e) {
    return { success: false, status: 'unknown', message: 'No se pudo consultar GitHub Actions: ' + e.message };
  }
}

function triggerRetailStoreSupabaseUpdate_(record) {
  var props = PropertiesService.getScriptProperties();
  var functionName = String(props.getProperty('RETAILSTORE_ETL_FUNCTION') || '').trim();
  if (functionName && typeof globalThis !== 'undefined' && typeof globalThis[functionName] === 'function') {
    try {
      var result = globalThis[functionName](record);
      return {
        status: 'SYNC_REQUESTED',
        message: result && result.message ? result.message : 'Actualización enviada al proceso Supabase.'
      };
    } catch (err) {
      return { status: 'ERROR', message: 'Archivo guardado, pero falló la actualización Supabase: ' + err.message };
    }
  }

  var webhookUrl = String(props.getProperty('RETAILSTORE_ETL_WEBHOOK_URL') || '').trim();
  if (webhookUrl) {
    try {
      var token = String(props.getProperty('RETAILSTORE_ETL_WEBHOOK_TOKEN') || '').trim();
      var headers = { 'Content-Type': 'application/json' };
      if (token) headers.Authorization = 'Bearer ' + token;
      var response = UrlFetchApp.fetch(webhookUrl, {
        method: 'POST',
        contentType: 'application/json',
        headers: headers,
        payload: JSON.stringify(record),
        muteHttpExceptions: true
      });
      var code = response.getResponseCode();
      if (code >= 200 && code < 300) {
        return { status: 'SYNC_REQUESTED', message: 'Actualización enviada a Supabase.' };
      }
      return { status: 'ERROR', message: 'Archivo guardado, pero Supabase respondió ' + code + '.' };
    } catch (err2) {
      return { status: 'ERROR', message: 'Archivo guardado, pero falló la actualización Supabase: ' + err2.message };
    }
  }

  var githubToken = String(props.getProperty('RETAILSTORE_GITHUB_TOKEN') || props.getProperty('GITHUB_ACTIONS_TOKEN') || '').trim();
  if (githubToken) {
    try {
      var previousRun = findRetailStoreGithubRunAfter_(githubToken, 0);
      var previousRunId = previousRun && previousRun.id ? previousRun.id : '';
      var workflowUrl = 'https://api.github.com/repos/luisvelasquez-alt/retailstore-master/actions/workflows/weekly_master.yml/dispatches';
      var githubResponse = UrlFetchApp.fetch(workflowUrl, {
        method: 'POST',
        contentType: 'application/json',
        headers: getRetailStoreGithubHeaders_(githubToken),
        payload: JSON.stringify({
          ref: 'main',
          inputs: {
            store_id: record.store,
            report_type: normalizeRetailGithubReportInput_(record.reportType),
            week_date: String(record.reportDate || '')
          }
        }),
        muteHttpExceptions: true
      });
      var githubCode = githubResponse.getResponseCode();
      if (githubCode === 204) {
        return {
          status: 'SYNC_REQUESTED',
          message: 'Workflow de GitHub enviado para actualizar Supabase.',
          runId: '',
          runUrl: ''
        };
      }
      return { status: 'ERROR', message: 'Archivo guardado, pero GitHub respondió ' + githubCode + '.' };
    } catch (err3) {
      return { status: 'ERROR', message: 'Archivo guardado, pero falló GitHub Actions: ' + err3.message };
    }
  }

  return {
    status: 'PENDING',
    message: 'Archivo guardado en Drive. Falta configurar RETAILSTORE_GITHUB_TOKEN para disparar GitHub Actions.'
  };
}

function normalizeRetailGithubReportInput_(reportType) {
  var normalized = normalizeRetailReportType_(reportType);
  if (normalized === 'AUTO' || normalized === 'OTRO') return '';
  return normalized;
}

function syncRetailStoreReportsFromDrive(payload) {
  try {
    payload = payload || {};
    var role = String(payload.role || '').trim().toUpperCase();
    var store = String(payload.store || '').trim().toUpperCase();
    if (!store && role !== 'ADMIN') throw new Error('No se pudo identificar la tienda.');
    if (!store) throw new Error('Selecciona una tienda para sincronizar.');

    var requestedReportType = normalizeRetailReportType_(payload.reportType);
    if (requestedReportType === 'OTRO') throw new Error('Selecciona Auto detectar o un reporte RS válido.');

    var country = normalizeCountryName_(LCW_COUNTRY_MAP[store] || payload.country || 'Sin pais');
    var syncReportLabel = normalizeRetailGithubReportInput_(requestedReportType) || 'TODOS';
    var record = {
      timestamp: new Date().toISOString(),
      store: store,
      country: country,
      reportType: requestedReportType,
      reportDate: String(payload.reportDate || ''),
      fileName: 'DRIVE_SYNC_' + syncReportLabel,
      originalName: 'Archivos existentes en Google Drive',
      fileUrl: '',
      fileId: '',
      uploadedBy: role || 'STORE'
    };
    var sync = triggerRetailStoreSupabaseUpdate_(record);
    record.status = sync.status;
    record.message = sync.message;

    var sheet = getRetailUploadLogSheet_();
    sheet.appendRow([
      new Date(), store, country, syncReportLabel, record.reportDate, record.fileName,
      record.originalName, '', '', record.uploadedBy, record.status, record.message
    ]);

    return {
      success: sync.status !== 'ERROR',
      status: sync.status,
      message: sync.message,
      reportType: syncReportLabel,
      runId: sync.runId || '',
      runUrl: sync.runUrl || ''
    };
  } catch (e) {
    return { success: false, message: e.message };
  }
}

function processRetailStoreReportUpload_(payload) {
  payload = payload || {};
  var role = String(payload.role || '').trim().toUpperCase();
  var store = String(payload.store || '').trim().toUpperCase();
  if (!store && role !== 'ADMIN') throw new Error('No se pudo identificar la tienda.');
  if (!store) throw new Error('Selecciona una tienda para subir el reporte.');

  var requestedReportType = normalizeRetailReportType_(payload.reportType);
  var country = normalizeCountryName_(LCW_COUNTRY_MAP[store] || payload.country || 'Sin pais');
  var originalName = String(payload.fileName || '').trim();
  if (!originalName) throw new Error('El archivo no tiene nombre.');

  var base64 = String(payload.base64Data || '').trim();
  if (base64.indexOf(',') > -1) base64 = base64.split(',').pop();
  if (!base64) throw new Error('El archivo llegó vacío.');
  var mimeType = getRetailUploadMimeType_(originalName, payload.mimeType);
  var bytes = Utilities.base64Decode(base64);
  var validation = validateRetailUploadReportType_(bytes, mimeType, originalName, requestedReportType);
  var reportType = validation.reportType;

  var root = getRetailStoreUploadRootFolder_();
  var countryFolder = getOrCreateChildFolder_(root, getRetailStoreDriveCountryFolderName_(country));
  var storeFolder = getOrCreateChildFolder_(countryFolder, store);

  var standardName = buildRetailUploadFileName_(store, reportType, payload.reportDate, originalName);
  var file = storeFolder.createFile(Utilities.newBlob(bytes, mimeType, standardName));

  var record = {
    timestamp: new Date().toISOString(),
    store: store,
    country: country,
    reportType: reportType,
    reportDate: String(payload.reportDate || ''),
    fileName: standardName,
    originalName: originalName,
    fileUrl: file.getUrl(),
    fileId: file.getId(),
    uploadedBy: role || 'STORE'
  };
  var sync = triggerRetailStoreSupabaseUpdate_(record);
  record.status = sync.status;
  record.message = sync.message;

  var sheet = getRetailUploadLogSheet_();
  sheet.appendRow([
    new Date(), store, country, reportType, record.reportDate, standardName,
    originalName, file.getUrl(), file.getId(), record.uploadedBy, record.status, record.message
  ]);

  return {
    success: true,
    url: file.getUrl(),
    fileName: standardName,
    detectedReportType: validation.detectedReportType,
    status: record.status,
    message: record.message,
    runId: sync.runId || '',
    runUrl: sync.runUrl || ''
  };
}

function uploadRetailStoreReport(payload) {
  var lock = LockService.getDocumentLock();
  try {
    lock.waitLock(20000);
    return processRetailStoreReportUpload_(payload);
  } catch (e) {
    return { success: false, message: e.message };
  } finally {
    try { lock.releaseLock(); } catch (err) {}
  }
}

function finalizeRetailStoreReportUpload(payload) {
  payload = payload || {};
  var uploadId = String(payload.uploadId || '').trim();
  var lock = LockService.getDocumentLock();
  try {
    payload.base64Data = readRetailStoreChunkedBase64_(uploadId, payload.totalChunks);
    lock.waitLock(20000);
    return processRetailStoreReportUpload_(payload);
  } catch (e) {
    return { success: false, message: e.message };
  } finally {
    try { lock.releaseLock(); } catch (err) {}
    cleanupRetailStoreChunkedUpload_(uploadId);
  }
}

function getRetailStoreUploadHistory(storeName, role) {
  try {
    var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('RetailStoreUploads');
    if (!sheet || sheet.getLastRow() < 2) return [];
    var isAdmin = String(role || '').trim().toUpperCase() === 'ADMIN';
    var store = String(storeName || '').trim().toUpperCase();
    var values = sheet.getRange(2, 1, sheet.getLastRow() - 1, 12).getValues();
    var rows = [];
    for (var i = values.length - 1; i >= 0 && rows.length < 8; i--) {
      var rowStore = String(values[i][1] || '').trim().toUpperCase();
      if (store && rowStore !== store) continue;
      if (!isAdmin && !store) continue;
      rows.push({
        timestamp: values[i][0],
        store: rowStore,
        country: values[i][2],
        reportType: values[i][3],
        reportDate: values[i][4],
        fileName: values[i][5],
        originalName: values[i][6],
        url: values[i][7],
        fileId: values[i][8],
        uploadedBy: values[i][9],
        status: values[i][10],
        message: values[i][11]
      });
    }
    return rows;
  } catch (e) {
    Logger.log('getRetailStoreUploadHistory error: ' + e.message);
    return [];
  }
}
