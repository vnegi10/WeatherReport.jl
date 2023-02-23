function get_api_response(params::String, url::String = URL)
	
    OM_request = HTTP.request("GET",
                               url * params;
                               verbose = 0,
                               retries = 2)
	
    response_text = String(OM_request.body)
    response_dict = JSON.parse(response_text)
	
    return response_dict
	
end