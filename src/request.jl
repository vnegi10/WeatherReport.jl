function get_api_response(params::String, url::String)

    OM_request = nothing
    try
        OM_request = HTTP.request("GET",
                                  url * params;
                                  verbose = 0,
                                  retries = 2)
    catch e
        if isa(e, HTTP.ExceptionRequest.StatusError)
            error("Check if the input is valid")
        else
            error("Could not fetch data, try again later!")
        end
    end
	
    response_text = String(OM_request.body)
    response_dict = JSON.parse(response_text)
	
    return response_dict
	
end