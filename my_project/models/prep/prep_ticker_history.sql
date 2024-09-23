-- using refs 2.2

select UNNEST(ARG_MAX(ph,"filename")) 
from {{ ref( 'ticker_history')}} as ph
group by symbol, "date"


{# select UNNEST(ARG_MAX(ticker_history,"filename")) 
  from (select * 
  from read_csv('s3://us-prd-motherduck-open-datasets/stocks/**/ticker_history_*.csv', 
  filename = true)) as ticker_history
  group by symbol, date #}