select * EXCLUDE(content)
from glob('s3://us-prd-motherduck-open-datasets/stocks/**/*') as files
left join read_blob('s3://us-prd-motherduck-open-datasets/stocks/**/*') as meta_data
  on meta_data."filename" = files."file"