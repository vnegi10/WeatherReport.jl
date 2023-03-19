# User Guide
---

## Overview
WeatherReport.jl is designed to work within the Julia REPL. Reports are shown either
as plots (via UnicodePlots.jl) or as tables (via PrettyTables.jl). Your location is
not tracked, therefore, you need to specify a city/town/village or latitude/longitude
yourself. Most major locations (population > 500) around the world are supported.

## Available functions
```@index
Modules = [WeatherReport]
Private = false
Order   = [:function]
```

## Supported APIs

- [Weather Forecast](https://open-meteo.com/en/docs)
- [Air Quality](https://open-meteo.com/en/docs/air-quality-api)

## Exported names
```@autodocs
Modules = [WeatherReport]
Private = false
Order   = [:function]
```