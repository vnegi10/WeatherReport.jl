module WeatherReport

# User preferences
export set_city

# Hourly weather forecast
export plot_hourly_temp, plot_hourly_rain, plot_hourly_snow
export plot_hourly_humidity, plot_hourly_windspeed, plot_hourly_solar
export show_current, show_daily

# Location
export where_am_i

# Air quality
export plot_hourly_pm, plot_hourly_dust, plot_hourly_haze

# Historical weather data
export plot_hist_temp, plot_hist_rain, plot_hist_snow
export plot_hist_humidity, plot_hist_windspeed, plot_hist_solar

# Compare historical monthly data
export plot_box_temp, plot_box_rain, plot_box_snow
export plot_box_humidity, plot_box_windspeed, plot_box_solar

# Compare historical yearly data
export compare_box_temp, compare_box_rain, compare_box_snow
export compare_box_humidity, compare_box_windspeed, compare_box_solar

# Export data
export export_to_sqlite

using CSV
using DataFrames
using Dates
using HTTP
using JSON
using PrettyTables
using UnicodePlots
using SQLite
using StringDistances
using Preferences

include("types.jl")
include("request.jl")

include("helpers.jl")
include("constants.jl")

include("hourly.jl")
include("daily.jl")
include("plots_forecast.jl")
include("plots_air_quality.jl")
include("plots_history.jl")
include("plots_box_monthly.jl")
include("plots_box_yearly.jl")

include("export_history.jl")

end # module WeatherReport