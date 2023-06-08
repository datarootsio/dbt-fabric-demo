# Demo notes

## Example - models & lineage / docs

models / example / my_first_model
models / example / my_second_model

dbt run

show target folder

dbt docs generate

second terminal: dbt docs serve

## New York Taxi - macros & tests

lakehouse:
https://app.fabric.microsoft.com/groups/816a8ba7-80ab-4d5d-b820-a5fb74ec3bfa/lakehouses/b1913059-0c0e-4109-8597-f897787305fd?experience=data-engineering

show new_york_taxi

models / new_york_taxi / __sources.yml + staging

dbt run

dbt docs generate

models / new_york_taxi / bad models

dbt run -s new_york_taxi

show macro & replace bad with everything

warehouse:
https://app.fabric.microsoft.com/groups/816a8ba7-80ab-4d5d-b820-a5fb74ec3bfa/datawarehouses/7eff1cab-b676-4a81-9598-03a30126288d?experience=data-engineering

## Jaffle shop

Entire jaffle shop

Show packages

stg_supplies - show package surrogate key
