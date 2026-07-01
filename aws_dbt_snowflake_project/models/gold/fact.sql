-- This is a metadata-driven pipeline.
-- This is one big table (OBT) built by joining the core OBT with dimension snapshots.

{{ config(
    materialized='table'
) }}

select
    -- Pulling explicit metrics from your core OBT model
    go.booking_id, 
    go.listing_id, 
    go.host_id, 
    go.total_amount, 
    go.accommodates, 
    go.bedrooms, 
    go.bathrooms, 
    go.price_per_night, 
    go.response_rate

from {{ ref('obt') }} as go

left join {{ ref('dim_listings_snapshot') }} as dl
    on go.listing_id = dl.listing_id

left join {{ ref('dim_hosts_snapshot') }} as dh
    on go.host_id = dh.host_id