module WeatherReport

export plot_hourly_temp, plot_hourly_rain, plot_hourly_snow
export plot_hourly_humidity, plot_hourly_windspeed, plot_hourly_solar
export show_current, show_daily
export where_am_i

using CSV
using DataFrames
using Dates
using HTTP
using JSON
using PrettyTables
using UnicodePlots

include("types.jl")
include("request.jl")

include("helpers.jl")
include("constants.jl")

include("hourly.jl")
include("daily.jl")
include("visualization.jl")

end # module WeatherReport