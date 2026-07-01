{{config(
    materialized='incremental'
)}}


select * from {{source('staging','listings')}}

{% if is_incremental() %}

        where CREATED_AT > (select COALESCE(max(CREATED_AT), '1970-01-01') from {{ this }})
{% endif %}