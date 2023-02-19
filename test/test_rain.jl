@testset "Check if rain forecast is available" begin

    for city in ["Eindhoven", "Veldhoven", "Groningen"]

        results = Weather.get_rain_forecast(city)
        df_rain = results[1]

        rows, cols = size(df_rain)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Europe/Amsterdam"

    end

    for city in ["Haldwani", "Delhi", "Mumbai"]

        results = Weather.get_rain_forecast(city)
        df_rain = results[1]

        rows, cols = size(df_rain)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Asia/Kolkata"

    end

end