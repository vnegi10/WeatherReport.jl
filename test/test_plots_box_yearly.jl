# Run tests on yearly plotting functions (box plots) for historical data API

@testset verbose = true "Plotting with default selection" begin

    @testset "compare_box_temp" begin
        plt = compare_box_temp("Veldhoven",
                                num_years = 5,
                                month = "Jan")
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

end