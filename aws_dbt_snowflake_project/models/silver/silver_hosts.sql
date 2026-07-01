{{
    config(
        materialized='incremental',
        unique_key='host_id'
    )
}}

select
    host_id,
    replace(host_name, ' ', '_')as host_name,
    host_since,
    is_superhost,
    response_rate,
    case 
        when response_rate > 95 then 'excellent'
        when response_rate between 80 and 95 then 'good'
        else 'poor'
    end as response_category,
    created_at as CREATED_AT
from {{ref('bronze_hosts')}}