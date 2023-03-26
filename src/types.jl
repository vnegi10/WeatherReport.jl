struct GeogCoord
    latitude::Float64
    longitude::Float64
    timezone::String
end

mutable struct CityInput
    city::String
    forecast_type::String
    i_row::Int64
end

mutable struct LocationInput
    forecast_type::String
    lat::Float64
    long::Float64
end