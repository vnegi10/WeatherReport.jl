# Weather.jl

[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](LICENSE.md)
[![Build status (Github Actions)](https://github.com/vnegi10/Weather.jl/workflows/CI/badge.svg)](https://github.com/vnegi10/Weather.jl/actions)

This package provides basic weather information right within the
terminal. Most major cities around the world are supported.

## How to install?

* Press ']' to enter Pkg prompt
* add Weather

## Data credits

Weather data is obtained from [Open-Meteo](https://open-meteo.com/en/docs) API,
which is free for non-commercial use under the Attribution 4.0 International (CC BY 4.0)
license.

## Example usage

```julia
julia> show_current_weather("Vienna")
┌───────────────┬───────────┬────────────┬─────────────┬───────────────┬─────────┬─────────┐
│      Timezone │ Elevation │ Wind speed │ Temperature │     Condition │      🌅 │      🌆 │
│         [CET] │       [m] │     [km/h] │        [°C] │            [] │ [hh:mm] │ [hh:mm] │
├───────────────┼───────────┼────────────┼─────────────┼───────────────┼─────────┼─────────┤
│ Europe/Vienna │     196.0 │       10.1 │        11.6 │ Partly cloudy │    6:52 │   17:23 │
└───────────────┴───────────┴────────────┴─────────────┴───────────────┴─────────┴─────────┘
```