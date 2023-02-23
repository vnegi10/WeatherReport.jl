@testset "Check if current weather conditions are available" begin

    current_dict = WeatherReport.get_current("Tokyo", 1)

    @test current_dict["latitude"] ≈ 35.7
    @test isapprox(current_dict["longitude"], 139.688, atol = 1e-2)
    @test current_dict["timezone_abbreviation"] == "JST"
    @test current_dict["timezone"] == "Asia/Tokyo"
    @test current_dict["elevation"] ≈ 40.0

end