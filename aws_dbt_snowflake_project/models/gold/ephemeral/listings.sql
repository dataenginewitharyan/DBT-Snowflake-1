{{ config(materialized='ephemeral') }}

select
        LISTING_ID,
        PROPERTY_TYPE,
        ROOM_TYPE,
        CITY,
        COUNTRY,
        PRICE_CATEGORY,
        LISTING_CREATED_AT
from {{ ref('obt') }}