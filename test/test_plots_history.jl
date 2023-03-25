# Run tests on plotting functions for historical data API

@testset verbose = true "Plotting with default selection" begin

    @testset "plot_hist_temp" begin
        plt = plot_hist_temp("Veldhoven",
                              start_date = "2022-01-01",
                              end_date = "2022-12-21")
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with multiple matches" begin

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

end

@testset verbose = true "Plotting with lat/long input" begin

    @testset "plot_hist_temp" begin
        # Denver
        plt = plot_hist_temp(lat = 39.7392,
                             long = -104.985,
                             start_date = "2022-01-01",
                             end_date = "2022-12-21")                             
        @test sizeof(plt) > 0
    end

end