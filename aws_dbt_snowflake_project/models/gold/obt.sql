-- Very Very IMP and UNIQUE way --
-- This is metadata driven pipeline.
-- This is one big table (obt) which is created by joining all the silver tables.

{% set configs = [
    {
        "model_name" : "silver_bookings",
        "columns" : "SILVER_bookings.BOOKING_ID, SILVER_bookings.LISTING_ID, SILVER_bookings.BOOKING_DATE, SILVER_bookings.TOTAL_AMOUNT, SILVER_bookings.BOOKING_STATUS, SILVER_bookings.CREATED_AT AS BOOKING_CREATED_AT",
        "alias" : "SILVER_bookings"
    },
    { 
        "model_name" : "silver_listings",
        "columns" : "SILVER_listings.LISTING_ID, SILVER_listings.HOST_ID, SILVER_listings.PROPERTY_TYPE, SILVER_listings.ROOM_TYPE, SILVER_listings.CITY, SILVER_listings.COUNTRY, SILVER_listings.ACCOMMODATES, SILVER_listings.BEDROOMS, SILVER_listings.BATHROOMS, SILVER_listings.PRICE_PER_NIGHT, SILVER_listings.PRICE_CATEGORY, SILVER_listings.CREATED_AT AS LISTING_CREATED_AT",
        "alias" : "SILVER_listings",
        "join_condition" : "SILVER_bookings.listing_id = SILVER_listings.listing_id"
    },
    {
        "model_name" : "silver_hosts",
        "columns" : "SILVER_hosts.HOST_NAME, SILVER_hosts.HOST_SINCE, SILVER_hosts.IS_SUPERHOST, SILVER_hosts.RESPONSE_RATE, SILVER_hosts.RESPONSE_category, SILVER_hosts.CREATED_AT AS HOST_CREATED_AT",
        "alias" : "SILVER_hosts",
        "join_condition" : "SILVER_listings.host_id = SILVER_hosts.host_id"
    }
] %}

select
    {% for config in configs %}
        {{ config.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
from
    {% for config in configs %}
        {% if loop.first %}
            {{ ref(config.model_name) }} AS {{ config.alias }}
        {% else %}
            LEFT JOIN {{ ref(config.model_name) }} AS {{ config.alias }}
                ON {{ config.join_condition }}
        {% endif %}
    {% endfor %}