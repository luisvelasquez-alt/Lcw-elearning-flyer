-- Retail Store product-family mapping for Report 1 (rs_01_master)
-- Safe version: each code is inserted independently, so the SQL Editor can run it without VALUES-list cutoff issues.
-- Source: Definitions_English.xlsx
-- Generated from official LCW definitions: 213 merch_sub_group codes
-- Distribution: APPAREL=156, ACCESSORIES=41, SHOES=16

begin;

create table if not exists public.retail_product_family_map (
  merch_sub_group text primary key,
  product_family text not null check (product_family in ('APPAREL', 'ACCESSORIES', 'SHOES', 'UNKNOWN')),
  source_rule text,
  updated_at timestamp with time zone default now()
);

alter table public.retail_product_family_map
  add column if not exists merch_brand_age_group_code text,
  add column if not exists merch_brand_age_group_name text,
  add column if not exists merch_brand_age_group_name_eng text,
  add column if not exists merch_sub_group_name text,
  add column if not exists merch_sub_group_name_eng text,
  add column if not exists source_file text;

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BE0E', 'APPAREL', 'CUW1', 'ERKEK BEBEK', 'BOY BABY', 'NEWBORN', 'NEWBORN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGA', 'SHOES', 'BGA8', 'KADIN  AYAKKABI', 'WOMEN  SHOES', 'KADIN AYAKKABI', 'WOMEN SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGAS', 'SHOES', 'BGA8', 'KADIN  AYAKKABI', 'WOMEN  SHOES', 'KADIN AKTIF AYAKKABI', 'WOMEN ACTIVE SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGAT', 'SHOES', 'BGA8', 'KADIN  AYAKKABI', 'WOMEN  SHOES', 'KADIN SANDALET / TERLIK', 'WOMEN SANDAL / SLIPPERS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGB', 'APPAREL', 'BGE8', 'KADIN KLASIK', 'WOMEN KLASIK', 'KADIN SOUTHBLUE', 'WOMEN SOUTHBLUE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGBA', 'ACCESSORIES', 'BGB8', 'KADIN SOUTHBLUE', 'WOMEN SOUTHBLUE', 'KADIN SOUTHBLUE AKSESUAR', 'WOMEN SOUTHBLUE ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGC', 'APPAREL', 'BGC8', 'KADIN MODEST/MUHAFAZAKAR', 'WOMEN MODEST/CONSERVATIVE', 'KADIN MODEST/MUHAFAZAKAR', 'WOMEN MODEST/CONSERVATIVE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGCS', 'APPAREL', 'BGC8', 'KADIN MODEST/MUHAFAZAKAR', 'WOMEN MODEST/CONSERVATIVE', 'KADIN MODEST/MUHAFAZAKAR SEYMA', 'WOMEN MODEST/CONSERVATIVE SEYMA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGCT', 'APPAREL', 'BGC8', 'KADIN MODEST/MUHAFAZAKAR', 'WOMEN MODEST/CONSERVATIVE', 'KADIN MODEST MASA', 'WOMEN MODEST MASA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGD', 'ACCESSORIES', 'BGK8', 'KADIN AKSESUAR', 'WOMEN ACCESSORY', 'KADIN KOZMETIK-TAKI-OYUNCAK-STANDART DIŞI', 'WOMEN COSMETIC-JEWELRY-TOY-NON-STANDARD', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGDR', 'APPAREL', 'BGD8', 'KADIN ELBISE', 'WOMEN ELBISE', 'KADIN LIMITED', 'WOMEN LIMITED', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGE', 'APPAREL', 'BGE8', 'KADIN KLASIK', 'WOMEN KLASIK', 'KADIN KLASIK', 'WOMEN KLASIK', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGEA', 'APPAREL', 'BGE8', 'KADIN KLASIK', 'WOMEN KLASIK', 'KLASIK KADIN ASKI', 'KLASIK WOMEN ASKI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGEM', 'APPAREL', 'BGE8', 'KADIN KLASIK', 'WOMEN KLASIK', 'KLASIK KADIN MASA', 'KLASIK WOMEN MASA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGF', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'KADIN FORMAL/İŞ GIYIMI', 'WOMEN FORMAL/İŞ WEARI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGG', 'APPAREL', 'BGS8', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'KADIN YÜZME GIYIM', 'WOMEN SWIM WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGGA', 'APPAREL', 'BGQ8', 'KADIN X-SIDE', 'WOMEN X-SIDE', 'KADIN AKTIF', 'WOMEN ACTIVE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGGO', 'APPAREL', 'BGQ8', 'KADIN X-SIDE', 'WOMEN X-SIDE', 'KADIN OUTDOOR', 'WOMEN OUTDOOR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGH', 'APPAREL', 'BGH8', 'KADIN HAMILE', 'WOMEN PREGNANT', 'KADIN HAMILE', 'WOMEN PREGNANT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGI', 'APPAREL', 'BGY8', 'KADIN E-TICARET ÖZEL ÜRETIM', 'WOMEN E-COMMERCE SPECIAL PRODUCT', 'KADIN E-TICARET ÖZEL ÜRETIM', 'WOMEN E-COMMERCE SPECIAL PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGJE', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'BAYAN DENIM', 'WOMAN DENIM', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGJW', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'BAYAN DENIM DUVAR', 'WOMEN DENIM WALL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGK', 'ACCESSORIES', 'BGK8', 'KADIN AKSESUAR', 'WOMEN ACCESSORY', 'KADIN AKSESUAR', 'WOMEN ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGL', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'KADIN VISION / SMART TRENDY', 'WOMEN VISION / SMART TRENDY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGMC', 'APPAREL', 'BGD8', 'KADIN ELBISE', 'WOMEN ELBISE', 'KADIN MODEST DIŞGIYIM', 'WOMEN MODEST DIŞWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGME', 'APPAREL', 'BGD8', 'KADIN ELBISE', 'WOMEN ELBISE', 'KADIN ESSENTIAL DIŞ GIYIM', 'WOMEN ESSENTIAL OUT WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGMO', 'APPAREL', 'BGD8', 'KADIN ELBISE', 'WOMEN ELBISE', 'KADIN OUTDOOR GIYIM', 'WOMEN OUTDOOR WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGMX', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'KADIN CASUAL DIŞ GIYIM', 'WOMEN CASUAL OUT WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGN', 'APPAREL', 'BGE8', 'KADIN KLASIK', 'WOMEN KLASIK', 'KADIN KLASIK BASIC', 'WOMEN KLASIK BASIC', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGO', 'ACCESSORIES', 'BGU8', 'OUTLET KADIN AKSESUAR', 'OUTLET WOMEN ACCESSORY', 'KADIN OUTLET AKSESUAR', 'WOMEN OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGP', 'APPAREL', 'BGP8', 'KADIN BÜYÜK BEDEN', 'WOMEN BIG SIZE', 'KADIN BÜYÜK BEDEN', 'WOMEN BIG SIZE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGQ', 'APPAREL', 'BGQ8', 'KADIN X-SIDE', 'WOMEN X-SIDE', 'KADIN X- SIDE', 'WOMEN X- SIDE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGQM', 'APPAREL', 'BGQ8', 'KADIN X-SIDE', 'WOMEN X-SIDE', 'KADIN X- SIDE MASA', 'WOMEN X- SIDE MASA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGR', 'APPAREL', 'BGR8', 'KADIN ÇORAP', 'WOMEN SOCKS', 'KADIN ÇORAP', 'WOMEN SOCKS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGRD', 'APPAREL', 'BGR8', 'KADIN ÇORAP', 'WOMEN SOCKS', 'KADIN DENYELI ÇORAP', 'WOMEN DENYELI SOCKS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGS', 'APPAREL', 'BGS8', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGSA', 'ACCESSORIES', 'BGM8', 'KADIN SOULIFE', 'WOMEN SOULIFE', 'KADIN SOULIFE AKSESUAR', 'WOMEN SOULIFE ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGSH', 'APPAREL', 'BGS8', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'KADIN HAMILE İÇ GIYIM', 'WOMEN PREGNANT UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGSL', 'APPAREL', 'BGS8', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'KADIN LUXURY İÇ GIYIM', 'WOMEN LUXURY UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGSO', 'APPAREL', 'BGM8', 'KADIN SOULIFE', 'WOMEN SOULIFE', 'KADIN SOULIFE', 'WOMEN SOULIFE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGSP', 'APPAREL', 'BGS8', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'KADIN PIJAMA', 'WOMEN PIJAMA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGSY', 'APPAREL', 'BGS8', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'KADIN GENÇ İÇ GIYIM', 'WOMEN YOUNG UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGSİ', 'APPAREL', 'BGS8', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'KADIN İÇ GIYIM', 'WOMEN UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGU', 'APPAREL', 'BGO8', 'KADIN OUTLET ÜRÜN', 'WOMEN OUTLET PRODUCT', 'KADIN OUTLET ÜRÜN', 'WOMEN OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGVR', 'APPAREL', 'BGV8', 'KADIN NATUVERA', 'WOMEN NATUVERA', 'KADIN NATUVERA', 'WOMEN NATUVERA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGW', 'APPAREL', 'BGE8', 'KADIN KLASIK', 'WOMEN KLASIK', 'KADIN KLASIK DUVAR', 'WOMEN KLASIK DUVAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGWE', 'APPAREL', 'BGE8', 'KADIN KLASIK', 'WOMEN KLASIK', 'KADIN ESSENTIAL', 'WOMEN ESSENTIAL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGWL', 'APPAREL', 'BGW8', 'KADIN KOOR', 'WOMEN KOOR', 'KADIN KOOR', 'WOMEN KOOR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGXA', 'APPAREL', 'BGQ8', 'KADIN X-SIDE', 'WOMEN X-SIDE', 'KADIN CASUAL AKTIF SPOR', 'WOMEN CASUAL ACTIVE SPOR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGXB', 'APPAREL', 'BGX8', 'KADIN CASUAL', 'WOMEN CASUAL', 'BGXE CEP JEAN PANTOLON', 'BGXE POCKET JEAN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGXE', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'KADIN VISION ASKI', 'WOMEN VISION ASKI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGXJ', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'KADIN CASUAL DENIM DUVARI', 'WOMEN CASUAL DENIM DUVARI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGXL', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'KADIN VISION LINE', 'WOMEN VISION LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGXN', 'APPAREL', 'BGL8', 'KADIN VISION', 'WOMEN VISION', 'KADIN VISION MASA', 'WOMEN VISION MASA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGXT', 'APPAREL', 'BGQ8', 'KADIN X-SIDE', 'WOMEN X-SIDE', 'KADIN TEEN', 'WOMEN TEEN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGY', 'APPAREL', 'BGY8', 'KADIN E-TICARET ÖZEL ÜRETIM', 'WOMEN E-COMMERCE SPECIAL PRODUCT', 'KADIN GENÇ', 'WOMEN YOUNG', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGZ', 'APPAREL', 'BGZ8', 'KADIN GELENEKSEL', 'WOMEN GELENEKSEL', 'KADIN GELENEKSEL', 'WOMEN GELENEKSEL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BGZA', 'APPAREL', 'BGZ8', 'KADIN GELENEKSEL', 'WOMEN GELENEKSEL', 'KADIN GELENEKSEL ASKILI', 'WOMEN GELENEKSEL ASKILI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUA', 'SHOES', 'BUA8', 'ERKEK AYAKKABI', 'MEN SHOES', 'ERKEK AYAKKABI', 'MEN SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUAS', 'SHOES', 'BUA8', 'ERKEK AYAKKABI', 'MEN SHOES', 'ERKEK AKTIF AYAKKABI', 'MEN ACTIVE SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUAT', 'SHOES', 'BUA8', 'ERKEK AYAKKABI', 'MEN SHOES', 'ERKEK SANDALET / TERLIK', 'MEN SANDAL / SLIPPERS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUB', 'APPAREL', 'BUL8', 'ERKEK VISION / SMART TRENDY', 'MEN VISION / SMART TRENDY', 'ERKEK SOUTHBLUE', 'MEN SOUTHBLUE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUC', 'APPAREL', 'BUE8', 'ERKEK KLASIK', 'MEN KLASIK', 'ERKEK KLASIK', 'MEN KLASIK', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUCF', 'APPAREL', 'BUE8', 'ERKEK KLASIK', 'MEN KLASIK', 'ERKEK FORMAL CLASSIC', 'MEN FORMAL CLASSIC', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUCL', 'APPAREL', 'BUL8', 'ERKEK VISION / SMART TRENDY', 'MEN VISION / SMART TRENDY', 'ERKEK KLASIK LINE', 'MEN KLASIK LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUD', 'ACCESSORIES', 'BUK8', 'ERKEK AKSESUAR', 'MEN ACCESSORY', 'ERKEK KOZMETIK-TAKI-OYUNCAK-STANDART DIŞI', 'MEN COSMETIC-JEWELRY-TOY-NON-STANDARD', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUE', 'APPAREL', 'BUE8', 'ERKEK KLASIK', 'MEN KLASIK', 'ERKEK KLASIK', 'MEN KLASIK', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUGA', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK AKTIF', 'MEN ACTIVE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUGO', 'APPAREL', 'BUG8', 'ERKEK AKTIF GIYIM', 'MEN ACTIVE WEAR', 'ERKEK OUTDOOR', 'MEN OUTDOOR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUI', 'APPAREL', 'BUY8', 'ERKEK E-TICARET ÖZEL ÜRETIM', 'MEN E-COMMERCE SPECIAL PRODUCT', 'ERKEK E-TICARET ÖZEL ÜRETIM', 'MEN E-COMMERCE SPECIAL PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUJD', 'APPAREL', 'BUJ8', 'ERKEK DENIM', 'MEN DENIM', 'ERKEK DENIM KLASIK', 'MEN DENIM KLASIK', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUJE', 'APPAREL', 'BUJ8', 'ERKEK DENIM', 'MEN DENIM', 'ERKEK DENIM', 'MEN DENIM', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUJW', 'APPAREL', 'BUJ8', 'ERKEK DENIM', 'MEN DENIM', 'ERKEK DENIM DUVAR', 'MEN DENIM DUVAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUK', 'ACCESSORIES', 'BUK8', 'ERKEK AKSESUAR', 'MEN ACCESSORY', 'ERKEK AKSESUAR', 'MEN ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUL', 'APPAREL', 'BUL8', 'ERKEK VISION / SMART TRENDY', 'MEN VISION / SMART TRENDY', 'ERKEK VISION / SMART TRENDY', 'MEN VISION / SMART TRENDY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUM', 'APPAREL', 'BUM8', 'ERKEK DIŞ GIYIM', 'MEN OUT WEAR', 'ERKEK OUTDOOR', 'MEN OUTDOOR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUMC', 'APPAREL', 'BUE8', 'ERKEK KLASIK', 'MEN KLASIK', 'ERKEK KLASIK DIŞ GIYIM', 'MEN KLASIK OUT WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUMH', 'APPAREL', 'BUE8', 'ERKEK KLASIK', 'MEN KLASIK', 'ERKEK YÜZME GIYIM', 'MEN SWIM WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUMX', 'APPAREL', 'BUM8', 'ERKEK DIŞ GIYIM', 'MEN OUT WEAR', 'ERKEK CASUAL DIŞ GIYIM', 'MEN CASUAL OUT WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUMY', 'APPAREL', 'BUM8', 'ERKEK DIŞ GIYIM', 'MEN OUT WEAR', 'ERKEK YÜZME GIYIM', 'MEN SWIM WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUN', 'APPAREL', 'BUE8', 'ERKEK KLASIK', 'MEN KLASIK', 'ERKEK KLASIK BASIC', 'MEN KLASIK BASIC', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUNC', 'APPAREL', 'BUE8', 'ERKEK KLASIK', 'MEN KLASIK', 'ERKEK KLASIK CHINO', 'MEN KLASIK CHINO', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUO', 'ACCESSORIES', 'BUU8', 'OUTLET ERKEK AKSESUAR', 'OUTLET MEN ACCESSORY', 'ERKEK OUTLET AKSESUAR', 'MEN OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUQ', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK X- SIDE', 'MEN X- SIDE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUR', 'APPAREL', 'BUR8', 'ERKEK ÇORAP', 'MEN SOCKS', 'ERKEK ÇORAP', 'MEN SOCKS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUS', 'APPAREL', 'BUS8', 'ERKEK İÇ GIYIM', 'MEN UNDERWEAR', 'ERKEK İÇ GIYIM', 'MEN UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUSP', 'APPAREL', 'BUS8', 'ERKEK İÇ GIYIM', 'MEN UNDERWEAR', 'ERKEK PIJAMA', 'MEN PIJAMA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUT', 'APPAREL', 'BUT8', 'ERKEK İNTERNET GIYIM', 'MEN İNTERNET WEAR', 'ERKEK İNTERNET ÜRÜN', 'MEN İNTERNET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUU', 'APPAREL', 'BUO8', 'ERKEK OUTLET ÜRÜN', 'MEN OUTLET PRODUCT', 'ERKEK OUTLET ÜRÜN', 'MEN OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUVR', 'APPAREL', 'BUV8', 'ERKEK NATUVERA', 'MEN NATUVERA', 'ERKEK NATUVERA', 'MEN NATUVERA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUWI', 'APPAREL', 'BUW8', 'ERKEK KLASIK DUVAR', 'MEN KLASIK DUVAR', 'BUI BAY IC GIYIM', 'BUI BAY IC WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXA', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK CASUAL AKTIF SPOR', 'MEN CASUAL ACTIVE SPOR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXB', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK BABAM VE BEN', 'MEN BABAM VE BEN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXD', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK CASUAL KLASIK DENIM', 'MEN CASUAL KLASIK DENIM', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXE', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXG', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'BUXE CEP EKOSE GÖMLEK', 'BUXE CEP EKOSE GÖMLEK', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXJ', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK CASUAL DENIM DUVARI', 'MEN CASUAL DENIM DUVARI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXL', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK CASUAL TRENDY LINE', 'MEN CASUAL TRENDY LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUXN', 'APPAREL', 'BUX8', 'ERKEK CASUAL TRENDY', 'MEN CASUAL TRENDY', 'ERKEK CASUAL BASIC', 'MEN CASUAL BASIC', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('BUY', 'APPAREL', 'BUY8', 'ERKEK E-TICARET ÖZEL ÜRETIM', 'MEN E-COMMERCE SPECIAL PRODUCT', 'ERKEK GENÇ', 'MEN YOUNG', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1A', 'SHOES', 'CKA1', 'KIZ BEBEK AYAKKABI', 'GIRL BABY SHOES', 'KIZ BEBEK AYAKKABI', 'GIRL BABY SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1E', 'APPAREL', 'CKW1', 'KIZ BEBEK', 'GIRL BABY', 'KIZ BEBEK ESSENTIAL', 'GIRL BABY ESSENTIAL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1G', 'SHOES', 'CKA1', 'KIZ BEBEK AYAKKABI', 'GIRL BABY SHOES', 'KIZ ÇOCUK AYAKKABI', 'GIRL SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1I', 'APPAREL', 'CKY1', 'KIZ BEBEK E-TICARET ÖZEL ÜRETIM', 'GIRL BABY E-COMMERCE SPECIAL PRODUCT', 'KIZ BEBEK E-TICARET ÖZEL ÜRETIM', 'GIRL BABY E-COMMERCE SPECIAL PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1L', 'APPAREL', 'CKW1', 'KIZ BEBEK', 'GIRL BABY', 'KIZ BEBEK LINE', 'GIRL BABY LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1N', 'APPAREL', 'CKW1', 'KIZ BEBEK', 'GIRL BABY', 'KIZ BEBEK NOS', 'GIRL BABY NOS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1O', 'ACCESSORIES', 'CKU1', 'OUTLET KIZ BEBEK AKSESUAR', 'OUTLET GIRL BABY ACCESSORY', 'KIZ BEBEK OUTLET AKSESUAR', 'GIRL BABY OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1P', 'APPAREL', 'CKW1', 'KIZ BEBEK', 'GIRL BABY', 'KIZ BEBEK CK4', 'GIRL BABY CK4', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1S', 'APPAREL', 'CKS1', 'KIZ BEBEK İÇ GIYIM', 'GIRL BABY UNDERWEAR', 'KIZ BEBEK İÇ GIYIM', 'GIRL BABY UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1T', 'APPAREL', 'CKT1', 'KIZ BEBEK İNTERNET GIYIM', 'GIRL BABY İNTERNET WEAR', 'KIZ BEBEK İNTERNET ÜRÜN', 'GIRL BABY İNTERNET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1U', 'APPAREL', 'CKO1', 'KIZ BEBEK OUTLET ÜRÜN', 'GIRL BABY OUTLET PRODUCT', 'KIZ BEBEK OUTLET ÜRÜN', 'GIRL BABY OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1Y', 'SHOES', 'CKA1', 'KIZ BEBEK AYAKKABI', 'GIRL BABY SHOES', 'PRE-WALKER AND FIRST STEP', 'PRE-WALKER AND FIRST STEP', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4A', 'SHOES', 'CKA4', 'KIZ ÇOCUK AYAKKABI', 'GIRL SHOES', 'KIZ ÇOCUK AYAKKABI', 'GIRL SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4B', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'KIZ ÇOCUK SOUTHBLUE', 'GIRL SOUTHBLUE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4C', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'KIZ ÇOCUK COOL', 'GIRL COOL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4D', 'ACCESSORIES', 'CKK4', 'KIZ ÇOCUK AKSESUAR', 'GIRL ACCESSORY', 'KIZ ÇOCUK KOZMETIK-TAKI-OYUNCAK-STANDART DIŞI', 'GIRL COSMETIC-JEWELRY-TOY-NON-STANDARD', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4E', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'KIZ ÇOCUK ESSENTIAL', 'GIRL ESSENTIAL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4F', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'KIZ ÇOCUK FAST FASHION', 'GIRL FAST FASHION', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4G', 'SHOES', 'CKA4', 'KIZ ÇOCUK AYAKKABI', 'GIRL SHOES', 'GENÇ KIZ AYAKKABI', 'YOUNG GIRL SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4I', 'APPAREL', 'CKY4', 'KIZ ÇOCUK E-TICARET ÖZEL ÜRETIM', 'GIRL E-COMMERCE SPECIAL PRODUCT', 'KIZ ÇOCUK E-TICARET ÖZEL ÜRETIM', 'GIRL E-COMMERCE SPECIAL PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4J', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'KIZ ÇOCUK JEAN', 'GIRL JEAN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4K', 'ACCESSORIES', 'CKK4', 'KIZ ÇOCUK AKSESUAR', 'GIRL ACCESSORY', 'KIZ ÇOCUK AKSESUAR', 'GIRL ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4L', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'KIZ ÇOCUK LINE', 'GIRL LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4N', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'KIZ ÇOCUK NOS', 'GIRL NOS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4O', 'ACCESSORIES', 'CKU4', 'OUTLET KIZ ÇOCUK AKSESUAR', 'OUTLET GIRL ACCESSORY', 'KIZ ÇOCUK OUTLET AKSESUAR', 'GIRL OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4R', 'APPAREL', 'CKR4', 'KIZ ÇOCUK ÇORAP', 'GIRL SOCKS', 'KIZ ÇOCUK ÇORAP', 'GIRL SOCKS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4S', 'APPAREL', 'CKS4', 'KIZ ÇOCUK İÇ GIYIM', 'GIRL UNDERWEAR', 'KIZ ÇOCUK İÇ GIYIM', 'GIRL UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4T', 'APPAREL', 'CKT4', 'KIZ ÇOCUK İNTERNET GIYIM', 'GIRL INTERNET WEAR', 'KIZ ÇOÇUK İNTERNET ÜRÜN', 'GIRL ÇOÇUK INTERNET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4U', 'APPAREL', 'CKO4', 'KIZ ÇOCUK OUTLET ÜRÜN', 'GIRL OUTLET PRODUCT', 'KIZ ÇOCUK OUTLET ÜRÜN', 'GIRL OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4X', 'APPAREL', 'CKW4', 'KIZ ÇOCUK', 'GIRL', 'ANNE VE KIZ', 'MOM AND GIRL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK4Y', 'ACCESSORIES', 'CKK4', 'KIZ ÇOCUK AKSESUAR', 'GIRL ACCESSORY', 'KIZ COCUK OYUNCAK', 'GIRL TOY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK6A', 'ACCESSORIES', 'CKA6', 'KIZ GENÇ AKSESUAR', 'GIRL YOUNG ACCESSORY', 'KIZ GENÇ AKSESUAR', 'GIRL YOUNG ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK6C', 'APPAREL', 'CKW6', 'KIZ GENÇ', 'GIRL YOUNG', 'COLLECTION', 'COLLECTION', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK6E', 'APPAREL', 'CKW6', 'KIZ GENÇ', 'GIRL YOUNG', 'LCW TEEN', 'LCW TEEN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK6L', 'APPAREL', 'CKW6', 'KIZ GENÇ', 'GIRL YOUNG', 'KIZ GENÇ LC WAIKIKI', 'GIRL YOUNG LC WAIKIKI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK6S', 'APPAREL', 'CKS6', 'KIZ GENÇ İÇ GIYIM', 'GIRL YOUNG UNDERWEAR', 'GENÇ KIZ  SUBBRANDS', 'YOUNG GIRL  SUBBRANDS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKB', 'APPAREL', 'CKB1', 'KIZ BEBEK YENIDOĞAN', 'GIRL BABY NEW BORN', 'KIZ BEBEK YENI DOĞAN-İÇ GIYIM', 'GIRL BABY NEW BORN-UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKBA', 'ACCESSORIES', 'CKB1', 'KIZ BEBEK YENIDOĞAN', 'GIRL BABY NEW BORN', 'KIZ BEBEK AKSESUAR', 'GIRL BABY ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKBD', 'ACCESSORIES', 'CK1', 'KIZ BEBEK AKSESUAR', 'GIRL BABY ACCESSORY', 'KIZ BEBEK OYUNCAK-STANDART DIŞI', 'GIRL BABY TOY-NON-STANDARD', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKBK', 'ACCESSORIES', 'CKK1', 'KIZ BEBEK YENIDOĞAN AKSESUAR', 'GIRL BABY NEW BORN ACCESSORY', 'KIZ BEBEK AKSESUAR', 'GIRL BABY ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKBO', 'ACCESSORIES', 'CKU1', 'OUTLET KIZ BEBEK AKSESUAR', 'OUTLET GIRL BABY ACCESSORY', 'KIZ YENIDOĞAN OUTLET AKSESUAR', 'GIRL NEW BORN OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKBR', 'APPAREL', 'CKR1', 'KIZ BEBEK ÇORAP', 'GIRL BABY SOCKS', 'KIZ BEBEK ÇORAP', 'GIRL BABY SOCKS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKBS', 'APPAREL', 'CKB1', 'KIZ BEBEK YENIDOĞAN', 'GIRL BABY NEW BORN', 'KIZ BEBE İÇGIYIM PIJAMA', 'GIRL BEBE UNDERWEAR PIJAMA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CKBU', 'APPAREL', 'CKO1', 'KIZ BEBEK OUTLET ÜRÜN', 'GIRL BABY OUTLET PRODUCT', 'KIZ BEBEK OUTLET ÜRÜN', 'GIRL BABY OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1A', 'SHOES', 'CUA1', 'ERKEK BEBEK AYAKKABI', 'BOY BABY SHOES', 'ERKEK BEBEK AYAKKABI', 'BOY BABY SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1E', 'APPAREL', 'CUW1', 'ERKEK BEBEK', 'BOY BABY', 'ERKEK BEBEK ESSENTIAL', 'BOY BABY ESSENTIAL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1G', 'SHOES', 'CUA1', 'ERKEK BEBEK AYAKKABI', 'BOY BABY SHOES', 'ERKEK ÇOCUK AYAKKABI', 'BOY SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1L', 'APPAREL', 'CUW1', 'ERKEK BEBEK', 'BOY BABY', 'ERKEK BEBEK LINE', 'BOY BABY LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1O', 'ACCESSORIES', 'CUU1', 'OUTLET ERKEK BEBEK AKSESUAR', 'OUTLET BOY BABY ACCESSORY', 'ERKEK BEBEK OUTLET AKSESUAR', 'BOY BABY OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1P', 'APPAREL', 'CUW1', 'ERKEK BEBEK', 'BOY BABY', 'ERKEK BEBEK CU4', 'BOY BABY CU4', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1S', 'APPAREL', 'CUS1', 'ERKEK BEBEK İÇ GIYIM', 'BOY BABY UNDERWEAR', 'ERKEK BEBEK İÇ GIYIM', 'BOY BABY UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1T', 'APPAREL', 'CUT1', 'ERKEK BEBEK İNTERNET GIYIM', 'BOY BABY İNTERNET WEAR', 'ERKEK BEBEK İNTERNET ÜRÜN', 'BOY BABY İNTERNET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1U', 'APPAREL', 'CUO1', 'ERKEK BEBEK OUTLET ÜRÜN', 'BOY BABY OUTLET PRODUCT', 'ERKEK BEBEK OUTLET ÜRÜN', 'BOY BABY OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1Y', 'SHOES', 'CUA1', 'ERKEK BEBEK AYAKKABI', 'BOY BABY SHOES', 'PRE-WALKER AND FIRST STEP', 'PRE-WALKER AND FIRST STEP', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4+1', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK ORIGIN (CU4C - CU4E)', 'BOY ORIGIN (CU4C - CU4E)', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4A', 'SHOES', 'CUA4', 'ERKEK ÇOCUK AYAKKABI', 'BOY SHOES', 'ERKEK ÇOCUK AYAKKABI', 'BOY SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4B', 'APPAREL', 'CUV4', 'ERKEK ÇOCUK VISION', 'BOY VISION', 'ERKEK ÇOCUK SOUTHBLUE', 'BOY SOUTHBLUE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4C', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK ORIGIN', 'BOY ORIGIN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4D', 'ACCESSORIES', 'CUK4', 'ERKEK ÇOCUK AKSESUAR', 'BOY ACCESSORY', 'ERKEK ÇOCUK KOZMETIK-TAKI-OYUNCAK-STANDART DIŞI', 'BOY COSMETIC-JEWELRY-TOY-NON-STANDARD', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4E', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK ESSENTIAL', 'BOY ESSENTIAL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4G', 'SHOES', 'CUA4', 'ERKEK ÇOCUK AYAKKABI', 'BOY SHOES', 'GENÇ ERKEK AYAKKABI', 'YOUNG MEN SHOES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4J', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK DENIM', 'BOY DENIM', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4K', 'ACCESSORIES', 'CUK4', 'ERKEK ÇOCUK AKSESUAR', 'BOY ACCESSORY', 'ERKEK ÇOCUK AKSESUAR', 'BOY ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4L', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK LINE', 'BOY LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4N', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK NOS', 'BOY NOS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4O', 'ACCESSORIES', 'CUU4', 'OUTLET ERKEK ÇOCUK AKSESUAR', 'OUTLET BOY ACCESSORY', 'ERKEK ÇOCUK OUTLET AKSESUAR', 'BOY OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4R', 'APPAREL', 'CUR4', 'ERKEK ÇOCUK ÇORAP', 'BOY SOCKS', 'ERKEK ÇOCUK ÇORAP', 'BOY SOCKS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4S', 'APPAREL', 'CUS4', 'ERKEK ÇOCUK İÇ GIYIM', 'BOY UNDERWEAR', 'ERKEK ÇOCUK İÇ GIYIM', 'BOY UNDERWEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4T', 'APPAREL', 'CUT4', 'ERKEK ÇOCUK İNTERNET GIYIM', 'BOY İNTERNET WEAR', 'ERKEK ÇOCUK İNTERNET ÜRÜN', 'BOY İNTERNET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4U', 'APPAREL', 'CUO4', 'ERKEK ÇOCUK OUTLET ÜRÜN', 'BOY OUTLET PRODUCT', 'ERKEK ÇOCUK OUTLET ÜRÜN', 'BOY OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4V', 'APPAREL', 'CUV4', 'ERKEK ÇOCUK VISION', 'BOY VISION', 'ERKEK ÇOCUK VISION', 'BOY VISION', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4X', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK LISANS', 'BOY LISANS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4Y', 'ACCESSORIES', 'CUK4', 'ERKEK ÇOCUK AKSESUAR', 'BOY ACCESSORY', 'ERKEK COCUK OYUNCAK', 'BOY TOY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU4Z', 'APPAREL', 'CUW4', 'ERKEK ÇOCUK', 'BOY', 'ERKEK ÇOCUK TRENDY', 'BOY TRENDY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU6A', 'ACCESSORIES', 'CUA6', 'ERKEK GENÇ AKSESUAR', 'MEN YOUNG ACCESSORY', 'ERKEK GENÇ AKSESUAR', 'MEN YOUNG ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU6C', 'APPAREL', 'CUW6', 'ERKEK GENÇ', 'MEN YOUNG', 'COLLECTION', 'COLLECTION', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU6E', 'APPAREL', 'CUW6', 'ERKEK GENÇ', 'MEN YOUNG', 'LCW TEEN', 'LCW TEEN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU6L', 'APPAREL', 'CUW6', 'ERKEK GENÇ', 'MEN YOUNG', 'ERKEK GENÇ LC WAIKIKI', 'MEN YOUNG LC WAIKIKI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU6S', 'APPAREL', 'CUS6', 'ERKEK GENÇ İÇ GIYIM', 'MEN YOUNG UNDERWEAR', 'GENÇ ERKEK SUBBRANDS', 'YOUNG MEN SUBBRANDS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUB', 'APPAREL', 'CUB1', 'ERKEK BEBEK YENIDOĞAN', 'BOY BABY NEW BORN', 'ERKEK BEBEK YENI DOĞAN-IÇ GIYIM', 'BOY BABY NEW BORN-IÇ WEAR', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUBA', 'ACCESSORIES', 'CUB1', 'ERKEK BEBEK YENIDOĞAN', 'BOY BABY NEW BORN', 'ERKEK BEBEK AKSESUAR', 'BOY BABY ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUBD', 'ACCESSORIES', 'CU1', 'ERKEK BEBEK AKSESUAR', 'BOY BABY ACCESSORY', 'ERKEK BEBEK OYUNCAK-STANDART DIŞI', 'BOY BABY TOY-NON-STANDARD', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUBK', 'ACCESSORIES', 'CUK1', 'ERKEK BEBEK YENIDOĞAN AKSESUAR', 'BOY BABY NEW BORN ACCESSORY', 'ERKEK BEBEK AKSESUAR', 'BOY BABY ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUBO', 'ACCESSORIES', 'CUU1', 'OUTLET ERKEK BEBEK AKSESUAR', 'OUTLET BOY BABY ACCESSORY', 'ERKEK YENIDOĞAN OUTLET AKSESUAR', 'MEN NEW BORN OUTLET ACCESSORY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUBR', 'APPAREL', 'CUR1', 'ERKEK BEBEK ÇORAP', 'BOY BABY SOCKS', 'ERKEK BEBEK ÇORAP', 'BOY BABY SOCKS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUBS', 'APPAREL', 'CUB1', 'ERKEK BEBEK YENIDOĞAN', 'BOY BABY NEW BORN', 'ERKEK BEBE İÇGIYIM PIJAMA', 'MEN BABY UNDER WEAR PIJAMA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CUBU', 'APPAREL', 'CUO1', 'ERKEK BEBEK OUTLET ÜRÜN', 'BOY BABY OUTLET PRODUCT', 'ERKEK BEBEK OUTLET ÜRÜN', 'BOY BABY OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVBA', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV BANYO', 'HOME BANYO', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVDE', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV DEKORASYON', 'HOME DEKORASYON', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVHA', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV HALI', 'HOME HALI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVKO', 'ACCESSORIES', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV KOZMETIK', 'HOME COSMETIC', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVLI', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV LINE', 'HOME LINE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVMS', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV MUTFAK SOFRA', 'HOME MUTFAK SOFRA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVMU', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV MUTFAK TEKSTIL', 'HOME MUTFAK TEKSTIL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVSA', 'APPAREL', 'EVS9', 'EV TEKSTILI SABUN', 'HOME TEKSTIL SABUN', 'EV SABUN', 'HOME SABUN', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVT', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV TEKSTILI', 'HOME TEKSTIL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVTD', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV TEKSTIL DIŞI', 'HOME TEKSTIL DIŞI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVU', 'APPAREL', 'EVO9', 'EV OUTLET ÜRÜN', 'HOME OUTLET PRODUCT', 'EVU EV OUTLET ÜRÜN', 'HOMEU HOME OUTLET PRODUCT', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVW', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV WAIKIKI', 'HOME WAIKIKI', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVYA', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV YARIŞMA', 'HOME YARIŞMA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('EVYT', 'APPAREL', 'EVT9', 'EV TEKSTILLI', 'HOME TEKSTIL', 'EV YATAK', 'HOME YATAK', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STBC', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI ÇOÇUK BIJUTERI', 'NON-STANDARD GIRLS BIJOUTERIE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STBK', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI KADIN BIJUTERI', 'NON-STANDARD WOMEN BIJOUTERIE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STD', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI', 'NON-STANDARD', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STDE', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI DENIZ', 'NON-STANDARD SEA PRODUCTS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STG', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI GÖZLÜK', 'NON-STANDARD SUNGLASSES', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STKO', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI KOZMETIK', 'NON-STANDARD COSMETIC', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STKR', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI KIRTASIYE', 'NON-STANDARD STATIONARY', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STM', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI MATARA', 'NON-STANDARD WATER BOTTLE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STO', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI OYUNCAK', 'NON-STANDARD TOYS', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STS', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI SEYEHAT', 'NON-STANDARD TRAVEL', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STSM', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI ŞEMSIYE', 'NON-STANDARD UMBRELLA', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('STV', 'ACCESSORIES', 'ST9', 'STANDAR DIŞI AKSESUAR', 'STANDAR DIŞI ACCESSORY', 'STANDART DIŞI VALIZ', 'NON-STANDARD SUITCASE', 'Definitions_English.xlsx', 'Official mapping from Definitions_English.xlsx')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();


-- Manual business confirmations for Report 1 codes not present in Definitions_English.xlsx.
insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1K', 'ACCESSORIES', null, null, null, 'WOVEN ACCESSORIES', 'WOVEN ACCESSORIES', 'Manual confirmation', 'Confirmed by business user: CU1K is woven accessories')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CK1B', 'APPAREL', null, null, null, 'BABY SETS', 'BABY SETS', 'Manual confirmation', 'Confirmed by business user: CK1B is Baby Sets')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();

insert into public.retail_product_family_map (
  merch_sub_group,
  product_family,
  merch_brand_age_group_code,
  merch_brand_age_group_name,
  merch_brand_age_group_name_eng,
  merch_sub_group_name,
  merch_sub_group_name_eng,
  source_file,
  source_rule
)
values ('CU1B', 'APPAREL', null, null, null, 'BABY SETS', 'BABY SETS', 'Manual confirmation', 'Confirmed by business user: CU1B is Baby Sets')
on conflict (merch_sub_group) do update
set product_family = excluded.product_family,
    merch_brand_age_group_code = excluded.merch_brand_age_group_code,
    merch_brand_age_group_name = excluded.merch_brand_age_group_name,
    merch_brand_age_group_name_eng = excluded.merch_brand_age_group_name_eng,
    merch_sub_group_name = excluded.merch_sub_group_name,
    merch_sub_group_name_eng = excluded.merch_sub_group_name_eng,
    source_file = excluded.source_file,
    source_rule = excluded.source_rule,
    updated_at = now();


create or replace view public.rs_01_master_family as
select
  r.*,
  coalesce(m.product_family, 'UNKNOWN') as product_family,
  m.merch_sub_group_name_eng,
  m.merch_brand_age_group_name_eng
from public.rs_01_master r
left join public.retail_product_family_map m
  on replace(upper(trim(r.merch_sub_group)), 'İ', 'I') =
     replace(upper(trim(m.merch_sub_group)), 'İ', 'I');

commit;

-- Validation: family distribution in Report 1
select
  product_family,
  count(*) as rows,
  sum(coalesce(warehouse, 0)) as warehouse_units,
  sum(coalesce(rayon, 0)) as rayon_units,
  sum(coalesce(total_stock, 0)) as total_units
from public.rs_01_master_family
group by product_family
order by total_units desc;

-- Validation: unmapped Report 1 subgroups, should be reviewed if any have material stock
select
  r.merch_group,
  r.merch_sub_group,
  count(*) as rows,
  sum(coalesce(r.warehouse, 0)) as warehouse_units,
  sum(coalesce(r.rayon, 0)) as rayon_units,
  sum(coalesce(r.total_stock, 0)) as total_units
from public.rs_01_master r
left join public.retail_product_family_map m
  on replace(upper(trim(r.merch_sub_group)), 'İ', 'I') =
     replace(upper(trim(m.merch_sub_group)), 'İ', 'I')
where m.merch_sub_group is null
group by r.merch_group, r.merch_sub_group
order by total_units desc;
