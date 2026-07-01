 {{ config(materialized='ephemeral') }}

select
    host_id,
    host_name,
    host_since,
    is_superhost,
    response_category,
    HOST_CREATED_AT
from {{ ref('obt') }}