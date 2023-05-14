# Run tests on monthly plotting functions (box plots) for historical data API

@testitem "Box plots of monthly data with default selection" begin

    @testset "plot_box_temp" begin
        plt = plot_box_temp("Veldhoven",
                             year = "2023")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_rain" begin
        plt = plot_box_rain("Veldhoven",
                             year = "2023")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_snow" begin
        plt = plot_box_snow("Tromso",
                             year = "2023")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_humidity" begin
        plt = plot_box_humidity("Dubrovnik",
                                 year = "2023")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_windspeed" begin
        plt = plot_box_windspeed("Rotterdam",
                                 year = "2023")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_solar" begin
        plt = plot_box_solar("Canberra",
                              year = "2020")
        @test sizeof(plt) > 0
    end

end

@testitem "Box plots of monthly data with multiple matches" begin

    @testset "plot_box_temp" begin
        plt = plot_box_temp("Madrid",
                            2,
                            year = "2020")
        @test sizeof(plt) > 0

        plt = plot_box_temp("Madrid",
                             4,
                             year = "2022")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_rain" begin
        plt = plot_box_rain("Madrid",
                            2,
                            year = "2020")
        @test sizeof(plt) > 0

        plt = plot_box_rain("Madrid",
                             3,
                             year = "2022")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_snow" begin
        plt = plot_box_snow("Madrid",
                            2,
                            year = "2020")
        @test sizeof(plt) > 0

        plt = plot_box_snow("Madrid",
                             5,
                             year = "2022")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_humidity" begin
        plt = plot_box_humidity("Madrid",
                                2,
                                year = "2010")
        @test sizeof(plt) > 0

        plt = plot_box_humidity("Madrid",
                                 5,
                                 year = "2012")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_windspeed" begin
        plt = plot_box_windspeed("Madrid",
                                 2,
                                 year = "2010")
        @test sizeof(plt) > 0

        plt = plot_box_windspeed("Madrid",
                                 4,
                                 year = "2012")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_solar" begin
        plt = plot_box_solar("Madrid",
                              2,
                              year = "2010")
        @test sizeof(plt) > 0

        plt = plot_box_solar("Madrid",
                              4,
                              year = "2014")
        @test sizeof(plt) > 0
    end

end

@testitem "Box plots of monthly data with lat/long input" begin

    @testset "plot_box_temp" begin
        # Denver
        plt = plot_box_temp(lat = 39.7392,
                            long = -104.985,
                            year = "2022")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_rain" begin
        # Denver
        plt = plot_box_rain(lat = 39.7392,
                            long = -104.985,
                            year = "2022")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_snow" begin
        # Oslo
        plt = plot_box_snow(lat = 59.9127,
                            long = 10.746,
                            year = "2022")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_humidity" begin
        # Sydney
        plt = plot_box_humidity(lat = -33.8678,
                                long = 151.207,
                                year = "2020")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_windspeed" begin
        # Copenhagen
        plt = plot_box_windspeed(lat = 55.6759,
                                 long = 12.5655,
                                 year = "2020")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_solar" begin
        # Chennai
        plt = plot_box_solar(lat = 13.0878,
                             long = 80.2785,
                             year = "2020")
        @test sizeof(plt) > 0
    end

end