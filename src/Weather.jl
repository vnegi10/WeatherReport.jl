module Weather

export plot_temp_hourly,
       plot_rain_hourly,
       plot_snow_hourly,
       show_current_weather

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
include("temperature.jl")
include("current.jl")
include("rain.jl")
include("snow.jl")
include("visualization.jl")

end # module Weather