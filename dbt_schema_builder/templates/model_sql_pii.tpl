-- This file is automatically generated. Do not update by hand.

{{ '{{' }} config(schema='{{app}}_PII', alias='{{relation.alias}}') {{ '}}' }}
{% set soft_del_ns = {'found':false} %}
SELECT
{% for col in relation.columns %}
    {{ col.name|upper|indent }}
    {{- ", " if not loop.last }}
    {%- if col.name|upper == raw_schema.soft_delete_column_name|upper -%}
        {%- if soft_del_ns.update({'found':true}) -%}{% endif %}
    {%- endif -%}
{%- endfor %}
FROM {{ '{{' }} source('{{raw_schema.schema_name}}', '{{relation.name}}') {{ '}}' }}
{%- if soft_del_ns.found %}
WHERE {{raw_schema.soft_delete_sql_clause()}}
{%- endif -%}
