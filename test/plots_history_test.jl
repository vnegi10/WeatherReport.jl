# Run tests on plotting functions for historical data API

@testitem "Plotting historical data with default selection" begin

    @testset "plot_hist_temp" begin
        plt = plot_hist_temp("Veldhoven",
                              start_date = "2022-01-01",
                              end_date = "2022-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_rain" begin
        plt = plot_hist_rain("Haldwani",
                              start_date = "2022-01-01",
                              end_date = "2022-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_snow" begin
        plt = plot_hist_snow("Tromso",
                              start_date = "2016-01-01",
                              end_date = "2016-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_humidity" begin
        plt = plot_hist_humidity("Chennai",
                                  start_date = "2016-01-01",
                                  end_date = "2016-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_windspeed" begin
        plt = plot_hist_windspeed("Amsterdam",
                                   start_date = "2020-01-01",
                                   end_date = "2020-05-30")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_solar" begin
        plt = plot_hist_solar("Canberra",
                               start_date = "2020-01-01",
                               end_date = "2020-05-30")
        @test sizeof(plt) > 0
    end

end

@testitem "Plotting historical data with multiple matches" begin

    @testset "plot_hist_temp" begin
        plt = plot_hist_temp("Madrid",
                              2,
                              start_date = "2022-01-01",
                              end_date = "2022-12-21")
        @test sizeof(plt) > 0

        plt = plot_hist_temp("Madrid",
                              4,
                              start_date = "2022-01-01",
                              end_date = "2022-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_rain" begin
        plt = plot_hist_rain("Madrid",
                              2,
                              start_date = "2020-01-01",
                              end_date = "2020-12-21")
        @test sizeof(plt) > 0

        plt = plot_hist_rain("Madrid",
                              4,
                              start_date = "2018-01-01",
                              end_date = "2018-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_snow" begin
        plt = plot_hist_snow("Madrid",
                              2,
                              start_date = "2020-01-01",
                              end_date = "2020-12-21")
        @test sizeof(plt) > 0

        plt = plot_hist_snow("Madrid",
                              3,
                              start_date = "2018-01-01",
                              end_date = "2018-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_humidity" begin
        plt = plot_hist_humidity("Madrid",
                              2,
                              start_date = "2020-01-01",
                              end_date = "2020-12-21")
        @test sizeof(plt) > 0

        plt = plot_hist_humidity("Madrid",
                              3,
                              start_date = "2018-01-01",
                              end_date = "2018-12-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_windspeed" begin
        plt = plot_hist_windspeed("Madrid",
                                  2,
                                  start_date = "2020-01-01",
                                  end_date = "2020-05-21")
        @test sizeof(plt) > 0

        plt = plot_hist_windspeed("Madrid",
                                  3,
                                  start_date = "2018-01-01",
                                  end_date = "2018-05-21")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_solar" begin
        plt = plot_hist_solar("Madrid",
                                  1,
                                  start_date = "2010-01-01",
                                  end_date = "2010-05-21")
        @test sizeof(plt) > 0

        plt = plot_hist_solar("Madrid",
                                  3,
                                  start_date = "2018-01-01",
                                  end_date = "2018-05-21")
        @test sizeof(plt) > 0
    end

end

@testitem "Plotting historical data with lat/long input" begin

    @testset "plot_hist_temp" begin
        # Denver
        plt = plot_hist_temp(lat = 39.7392,
                             long = -104.985,
                             start_date = "2022-01-01",
                             end_date = "2022-12-31")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_rain" begin
        # Delhi
        plt = plot_hist_rain(lat = 28.6519,
                             long = 77.2315,
                             start_date = "2019-01-01",
                             end_date = "2019-12-31")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_snow" begin
        # Oslo
        plt = plot_hist_snow(lat = 59.9127,
                             long = 10.7461,
                             start_date = "2019-01-01",
                             end_date = "2019-12-31")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_humidity" begin
        # Sydney
        plt = plot_hist_humidity(lat = -33.8678,
                                 long = 151.207,
                                 start_date = "2019-01-01",
                                 end_date = "2019-12-31")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_windspeed" begin
        # Copenhagen
        plt = plot_hist_windspeed(lat = 55.6759,
                                  long = 12.5655,
                                  start_date = "2010-01-01",
                                  end_date = "2010-12-31")
        @test sizeof(plt) > 0
    end

    @testset "plot_hist_solar" begin
        # Chennai
        plt = plot_hist_solar(lat = 13.0878,
                              long = 80.2785,
                              start_date = "2009-01-01",
                              end_date = "2009-12-31")
        @test sizeof(plt) > 0
    end

end

@testitem "Plotting historical data with user preference" begin

    @testset "plot_hist_temp" begin
        set_city("Haldwani")
        plt = plot_hist_temp(start_date = "2022-01-01",
                             end_date = "2022-12-31")
        @test sizeof(plt) > 0
    end

end