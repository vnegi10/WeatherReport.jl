using ReTestItems, WeatherReport

num_threads = Threads.nthreads()
num_workers = 1

if num_threads == 1
    @info "Using only 1 thread, try starting the Julia session with more threads!"
else
    # Each worker uses two threads by default
    num_workers = floor(Int, num_threads/2)
end

all_tests = false
errors = false

# Run all tests when no arguments or "all" is specified
if isempty(ARGS) || "all" in ARGS
    all_tests = true
end

if all_tests
    @time WeatherReport.execute_test(runtests(WeatherReport, nworkers = num_workers))
else
    @time for find_match in ARGS
        WeatherReport.execute_test(runtests(WeatherReport;
                                            name = Regex("$(find_match)"),
                                            nworkers = 1))
    end
end

if errors
    throw("Some tests have failed! Check the results summary above.")
end