{# select * 
from read_csv('s3://us-prd-motherduck-open-datasets/stocks/**/ticker_info_*.csv',
  filename = true) #}

{{
    config(
        materialized="incremental",
        unique_key="id",
    )
}}

select
    info.symbol || '-' || info.filename as id,
    info.*,
    now() at time zone 'UTC' as updated_at
from read_csv('s3://us-prd-motherduck-open-datasets/stocks/**/ticker_info_*.csv',
    filename = true) as info
{% if is_incremental() %}
    where not exists (select 1 from {{ this }} ck where ck.filename = info.filename)
{% endif %}