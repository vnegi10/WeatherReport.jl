function get_current(city::String, i_row::Int64)

	location = fetch_lat_long(city, i_row)
	lat      = location.latitude
	long     = location.longitude
	timezone = location.timezone

	params_1 = "?latitude=$(lat)&longitude=$(long)&current_weather=true"
    params_2 = "&daily=sunrise,sunset&timezone=$(timezone)"
	current_dict = get_api_response(params_1 * params_2)

	return current_dict

end