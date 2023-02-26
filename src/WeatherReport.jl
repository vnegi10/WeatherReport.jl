module WeatherReport

export plot_temp_hourly,
       plot_rain_hourly,
       plot_snow_hourly,
       plot_humidity_hourly,
       plot_windspeed_hourly,
       plot_solar_hourly,
       show_current,
       show_daily

using HTTP,
      JSON,
      CSV,
      DataFrames,
      Dates,
      UnicodePlots,
      PrettyTables

include("types.jl")
include("request.jl")

include("helpers.jl")
include("constants.jl")

include("hourly.jl")
include("daily.jl")
include("visualization.jl")

end # module WeatherReport