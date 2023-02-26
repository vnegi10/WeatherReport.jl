module WeatherReport

export plot_hourly_temp,
       plot_hourly_rain,
       plot_hourly_snow,
       plot_hourly_humidity,
       plot_hourly_windspeed,
       plot_hourly_solar,
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