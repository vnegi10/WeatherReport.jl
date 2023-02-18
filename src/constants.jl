const URL = "https://api.open-meteo.com/v1/forecast"

const DF_CITIES = joinpath(@__DIR__, "..", "data", 
                           "cities15000.txt") |> get_cities_lat_long

const ATTRIBUTION = "[Weather data by Open-Meteo.com]"