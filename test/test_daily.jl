@testset "Check if current weather conditions are available" begin

    current_dict = WeatherReport.get_current("Tokyo", 1)

    @test current_dict["latitude"] ≈ 35.7
    @test isapprox(current_dict["longitude"], 139.688, atol = 1e-2)
    @test current_dict["timezone_abbreviation"] == "JST"
    @test current_dict["timezone"] == "Asia/Tokyo"
    @test current_dict["elevation"] ≈ 40.0

end

@testset "Check if daily weather conditions are available" begin

    daily_dict =  WeatherReport.get_daily("Madrid", 2)

    @test daily_dict["latitude"] ≈ 40.42
    @test isapprox(daily_dict["longitude"], -3.7, atol = 1e-2)
    @test daily_dict["timezone_abbreviation"] ∈ ["CET", "CEST"]
    @test daily_dict["timezone"] == "Europe/Madrid"
    @test daily_dict["elevation"] ≈ 651.0

end