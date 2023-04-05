# Run tests on plotting functions (box plots) for historical data API

@testset verbose = true "Plotting with default selection" begin

    @testset "plot_box_temp" begin
        plt = plot_box_temp("Veldhoven",
                             year = "2023")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_temp" begin
        plt = compare_box_temp("Veldhoven",
                                num_years = 5,
                                month = "Jan")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_rain" begin
        plt = plot_box_rain("Veldhoven",
                             year = "2023")
        @test sizeof(plt) > 0
    end

end

@testset verbose = true "Plotting with multiple matches" begin

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

end

@testset verbose = true "Plotting with lat/long input" begin

    @testset "plot_box_temp" begin
        # Denver
        plt = plot_box_temp(lat = 39.7392,
                            long = -104.985,
                            year = "2022")
        @test sizeof(plt) > 0
    end

    @testset "compare_box_temp" begin
        # Denver
        plt = compare_box_temp(lat = 39.7392,
                               long = -104.985,
                               num_years = 5,
                               month = "March")
        @test sizeof(plt) > 0
    end

    @testset "plot_box_rain" begin
        # Denver
        plt = plot_box_rain(lat = 39.7392,
                            long = -104.985,
                            year = "2022")
        @test sizeof(plt) > 0
    end

end