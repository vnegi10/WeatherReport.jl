@testset "Check if temperature forecast is available" begin

    for city in ["Eindhoven", "Veldhoven", "Groningen"]

        input = WeatherReport.CityInput(city, "temperature_2m", 1)
        results = WeatherReport.get_hourly_forecast(input)

        df_temp = results[1]
        rows, cols = size(df_temp)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Europe/Amsterdam"

    end

    for city in ["Haldwani", "Delhi", "Mumbai"]

        input = WeatherReport.CityInput(city, "temperature_2m", 1)
        results = WeatherReport.get_hourly_forecast(input)

        df_temp = results[1]
        rows, cols = size(df_temp)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Asia/Kolkata"

    end

end

@testset "Check if rain forecast is available" begin

    for city in ["Eindhoven", "Veldhoven", "Groningen"]

        input = WeatherReport.CityInput(city, "rain", 1)
        results = WeatherReport.get_hourly_forecast(input)

        df_rain = results[1]
        rows, cols = size(df_rain)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Europe/Amsterdam"

    end

    for city in ["Haldwani", "Delhi", "Mumbai"]

        input = WeatherReport.CityInput(city, "rain", 1)
        results = WeatherReport.get_hourly_forecast(input)

        df_rain = results[1]
        rows, cols = size(df_rain)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Asia/Kolkata"

    end

end

@testset "Check if snow forecast is available" begin

    for city in ["Oslo", "Tromso", "Trondheim"]

        input = WeatherReport.CityInput(city, "snowfall", 1)
        results = WeatherReport.get_hourly_forecast(input)

        df_snow = results[1]
        rows, cols = size(df_snow)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Europe/Oslo"

    end

    for city in ["Tokyo", "Osaka", "Nagasaki"]

        input = WeatherReport.CityInput(city, "snowfall", 1)
        results = WeatherReport.get_hourly_forecast(input)

        df_snow = results[1]
        rows, cols = size(df_snow)

        @test rows == 24*7
        @test cols == 2

        @test results[2].timezone == "Asia/Tokyo"

    end

end