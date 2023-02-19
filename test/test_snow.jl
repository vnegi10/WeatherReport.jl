@testset "Check if snow forecast is available" begin

    for city in ["Oslo", "Tromso", "Trondheim"]

        results = Weather.get_snow_forecast(city)
        df_snow = results[1]

        rows, cols = size(df_snow)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Europe/Oslo"

    end

    for city in ["Tokyo", "Osaka", "Nagasaki"]

        results = Weather.get_snow_forecast(city)
        df_snow = results[1]

        rows, cols = size(df_snow)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Asia/Tokyo"

    end

end