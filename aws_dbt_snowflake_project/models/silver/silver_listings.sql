{{ config(
    materialized='incremental', 
    unique_key='listing_id'
) }}

select 
    listing_id,
    host_id,
    {{ trimmer('property_type') }} as property_type,
    {{ trimmer('room_type') }} as room_type,
    city,
    country,
    accommodates,
    bedrooms,
    bathrooms,
    price_per_night,
    {{ tag('price_per_night') }} as price_category,
    created_at as CREATED_AT
from {{ ref('bronze_listings') }}