using ReTestItems, WeatherReport

num_threads = Threads.nthreads()
num_workers = 1

if num_threads == 1
    @info "Using only 1 thread, try starting the Julia session with more threads!"
else
    # Each worker uses two threads, set via nworker_threads
    num_workers = floor(Int, num_threads/2)
end

all_tests = isempty(ARGS) || "all" in ARGS

# Run a subset of tests by passing tags
# julia> Pkg.test("WeatherReport", test_args = ["plots"])

# List of tags available
# :daily, :exceptions, :export, :helpers, :hourly
# :plots, :air, :box, :forecast, :history, :location, :preferences

function run_test_group(shouldrun; tags = nothing, nworkers = num_workers)
    try
        runtests(shouldrun,
                 WeatherReport;
                 tags,
                 nworkers,
                 nworker_threads = 2)
        return true
    catch exception
        # A tag can legitimately select no tests in one of the two groups.
        exception isa ReTestItems.NoTestException && return true

        showerror(stderr, exception, catch_backtrace())
        println(stderr)
        return false
    end
end

tags = all_tests ? nothing : Symbol.(ARGS)

# Preference tests write to a shared LocalPreferences.toml file, so keep those
# serial while allowing the rest of the suite to use all configured workers.
parallel_tests_passed = @time run_test_group(
    testitem -> :preferences ∉ testitem.tags;
    tags,
)
preference_tests_passed = @time run_test_group(
    testitem -> :preferences ∈ testitem.tags;
    tags,
    nworkers = 1,
)

parallel_tests_passed && preference_tests_passed ||
    error("Some tests have failed! Check the results summary above.")
