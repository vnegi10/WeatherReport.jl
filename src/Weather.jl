module Weather

export plot_temp_forecast,
       plot_rain_forecast,
       show_current_weather

using HTTP,
      JSON,
      DataFrames,
      Dates,
      UnicodePlots,
      PrettyTables

include("types.jl")
include("request.jl")

include("helpers.jl")
include("constants.jl")

include("temperature.jl")
include("current.jl")
include("rain.jl")
include("visualization.jl")

end # module Weather