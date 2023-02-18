const URL = "https://api.open-meteo.com/v1/forecast"

const DF_CITIES = joinpath(@__DIR__, "..", "data", 
                           "cities15000.txt") |> get_cities_lat_long

const ATTRIBUTION = "[Weather data by Open-Meteo.com]"

const WEATHER_CODES = Dict(0 => "Clear sky",
                           1 => "Mainly clear",
                           2 => "Partly cloudy",
                           3 => "Overcast",
                           45 => "Fog",
                           48 => "Depositing rime fog",
                           51 => "Light drizzle",
                           53 => "Moderate drizzle",
                           55 => "Dense drizzle",
                           56 => "Light freezing drizzle",
                           57 => "Dense freezing drizzle",
                           61 => "Slight rain",
                           63 => "Moderate rain",
                           65 => "Heavy rain",
                           66 => "Light freezing rain",
                           67 => "Heavy freezing rain",
                           71 => "Slight snowfall",
                           73 => "Moderate snowfall",
                           75 => "Heavy snowfall",
                           77 => "snow grains",
                           80 => "Slight rain showers",
                           81 => "Moderate rain showers",
                           82 => "Violent rain showers",
                           85 => "Slight snow showers",
                           86 => "Heavy snow showers",
                           95 => "Moderate thunderstorm",
                           96 => "Thunderstorm with slight hail",
                           99 => "Thunderstorm with heavy hail")