{{ config(materialized='ephemeral') }}

select
    booking_id,
    booking_date,
    booking_status,
    booking_created_at as booking_created_at
from {{ ref('obt') }}