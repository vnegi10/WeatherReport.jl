@testitem "Check if current weather conditions are available" tags = [:daily] begin

    input = WeatherReport.CityInput("Tokyo", "current", 1)
    current_dict = WeatherReport.get_forecast(input)

    @test current_dict["latitude"] ≈ 35.7
    @test isapprox(current_dict["longitude"], 139.688, atol = 1e-2)
    @test current_dict["timezone_abbreviation"] == "GMT+9"
    @test current_dict["timezone"] == "Asia/Tokyo"
    @test current_dict["elevation"] ≈ 40.0

end

@testitem "Check if daily weather conditions are available" tags = [:daily] begin

    input = WeatherReport.CityInput("Madrid", "daily", 2)
    daily_dict = WeatherReport.get_forecast(input)

    @test isapprox(daily_dict["latitude"], 40.4375, atol = 1e-2)
    @test isapprox(daily_dict["longitude"], -3.6875, atol = 1e-2)
    @test daily_dict["timezone_abbreviation"] ∈ ["CET", "CEST", "GMT+1"]
    @test daily_dict["timezone"] == "Europe/Madrid"
    @test daily_dict["elevation"] ≈ 651.0

end