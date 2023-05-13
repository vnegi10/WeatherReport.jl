using ReTestItems, WeatherReport

@time runtests(WeatherReport)

#=errors = false
all_tests = false

# Run all tests when no arguments or "all" is specified
if isempty(ARGS) || "all" in ARGS
    all_tests = true
end

# Execute test in a try-catch block for each file
function execute_test(file::String, ARGS; all_tests::Bool)

    if all_tests || file in ARGS
        try
            include(file)
            println("\t\033[1m\033[32mPASSED\033[0m: $(file)")
        catch e
            println("\t\033[1m\033[31mFAILED\033[0m: $(file)")
            global errors = true
            showerror(stdout, e, backtrace())
            println()
        end
    end

end

################# All test groups #################

test_files = ["test_hourly.jl",
              "test_plots_forecast.jl",
              "test_plots_air_quality.jl",
              "test_plots_history.jl",
              "test_plots_box_monthly.jl",
              "test_plots_box_yearly.jl",
              "test_daily.jl",
              "test_helpers.jl",
              "test_exceptions.jl"]

###################################################

################# Execute tests ###################

@time for file in test_files
    execute_test(file, ARGS, all_tests = all_tests)
end

if errors
    throw("Some tests have failed! Check the results summary above.")
end=#

###################################################