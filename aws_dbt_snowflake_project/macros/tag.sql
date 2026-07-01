{% macro tag(col_name) %}
    case 
        when {{ col_name }} < 100 then 'budget'
        when {{ col_name }} between 100 and 200 then 'mid-range'
        else 'luxury'
    end
{% endmacro %}