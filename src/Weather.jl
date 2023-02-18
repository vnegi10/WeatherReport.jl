module Weather

export plot_temp_forecast

using HTTP, JSON, DataFrames, Dates, UnicodePlots

include("types.jl")
include("request.jl")

include("helpers.jl")
include("constants.jl")

include("temperature.jl")
include("visualization.jl")

end # module Weather