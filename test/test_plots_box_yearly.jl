# Run tests on yearly plotting functions (box plots) for historical data API

@testset verbose = true "Plotting with default selection" begin

    @testset "compare_box_temp" begin
        plt = compare_box_temp("Veldhoven",
                                num_years = 5,
                                month = "Jan")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_rain" begin
        plt = compare_box_rain("Veldhoven",
                                num_years = 5,
                                month = "March")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_snow" begin
        plt = compare_box_snow("Oslo",
                                num_years = 5,
                                month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_humidity" begin
        plt = compare_box_humidity("Chandigarh",
                                    num_years = 5,
                                    month = "May")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_windspeed" begin
        plt = compare_box_windspeed("Chandigarh",
                                     num_years = 5,
                                     month = "Sept")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_solar" begin
        plt = compare_box_solar("Chennai",
                                 num_years = 7,
                                 month = "May")
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with multiple matches" begin

    @testset "compare_box_temp" begin
        plt = compare_box_temp("Madrid",
                               2,
                               num_years = 5,
                               month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_temp("Madrid",
                               4,
                               num_years = 5,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_rain" begin
        plt = compare_box_rain("Madrid",
                               2,
                               num_years = 5,
                               month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_rain("Madrid",
                               4,
                               num_years = 2,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_snow" begin
        plt = compare_box_snow("Madrid",
                               2,
                               num_years = 4,
                               month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_snow("Madrid",
                               3,
                               num_years = 2,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_humidity" begin
        plt = compare_box_humidity("Madrid",
                                   2,
                                   num_years = 5,
                                   month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_humidity("Madrid",
                                   3,
                                   num_years = 7,
                                   month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_windspeed" begin
        plt = compare_box_windspeed("Madrid",
                                    2,
                                    num_years = 5,
                                    month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_windspeed("Madrid",
                                    3,
                                    num_years = 7,
                                    month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_solar" begin
        plt = compare_box_solar("Madrid",
                                 2,
                                 num_years = 5,
                                 month = "Jan")
        @test sizeof(plt) > 0

        plt = compare_box_solar("Madrid",
                                 5,
                                 num_years = 7,
                                 month = "Dec")
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with lat/long input" begin

    @testset "compare_box_temp" begin
        # Denver
        plt = compare_box_temp(lat = 39.7392,
                               long = -104.985,
                               num_years = 5,
                               month = "March")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_rain" begin
        # Chennai
        plt = compare_box_rain(lat = 13.0878,
                               long = 80.2785,
                               num_years = 5,
                               month = "March")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_snow" begin
        # Oslo
        plt = compare_box_snow(lat = 59.9127,
                               long = 10.746,
                               num_years = 5,
                               month = "Dec")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_humidity" begin
        # Sydney
        plt = compare_box_humidity(lat = -33.8678,
                                   long = 151.207,
                                   num_years = 5,
                                   month = "May")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_windspeed" begin
        # Copenhagen
        plt = compare_box_windspeed(lat = 55.6759,
                                    long = 12.5655,
                                    num_years = 2,
                                    month = "Sept")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_solar" begin
        # Chennai
        plt = compare_box_solar(lat = 13.0878,
                                long = 80.2785,
                                num_years = 3,
                                month = "July")
        @test sizeof(plt) > 0
    end

end