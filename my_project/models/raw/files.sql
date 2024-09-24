{{
    config(
        pre_hook="""
            SET VARIABLE my_files = (
                select ARRAY_AGG(file)
                from glob('s3://us-prd-motherduck-open-datasets/stocks/**/*') )
        """
    )
}}


select * EXCLUDE(content),
    case
        when "file" like '%/option_%' then 'stock'
        when "file" like '%/ticker_history_%' then 'price'
        when "file" like '%/ticker_info_%' then 'info'
        else 'unknown'
    end as entity,
from glob('s3://us-prd-motherduck-open-datasets/stocks/**/*') as files
left join read_blob('s3://us-prd-motherduck-open-datasets/stocks/**/*') as meta_data
  on meta_data."filename" = files."file"