class HomeController < ApplicationController
  def index
  	require 'net/http'
  	require 'json'
  	@url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=33125&distance=0&API_KEY=0A8AF167-EA05-4781-8EBB-C96C222456EC'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@output = JSON.parse(@response)

  	if @output.empty?
  		@final_output = "Error"
  	elsif !@output
		@final_output = "Error"
  	else

  	@final_output =	@output[0]["AQI"]

  end

  	if @final_output == "Error"
  		@api_color = "gray"

 	elsif @final_output <= 50
  		@api_color = "green"
  		@api_description = " Air Quality Good"
  	elsif @final_output >= 51 && @final_output <= 100
  		@api_color = "yellow"
  		@api_description = " Air Quality Moderate"
  	elsif @final_output >= 101 && @final_output <= 150
  		@api_color = "orange"
  		@api_description = "Unhealthy for Sensitive Groups (USG)"
  	elsif @final_output >= 151 && @final_output <= 200
  		@api_color = "red"
  		@api_description = " Air Quality Unhealthy"
  	elsif @final_output >= 201 && @final_output <= 300
  		@api_color = "purple"
  		@api_description = "Air Quality Very Unhealthy"
	elsif @final_output >= 301 && @final_output <= 500
  		@api_color = "maroon"
  		@api_description = "Air Quality Hazardous"


  	end
  
end
  def zipcode
  	@zip_query = params[:zipcode]
  	
  	if params[:zipcode] == ""
      @zip_query = "Hey you forgot to enter a zipcode!"
    elsif params[:zipcode]
      # Do Api stuff

      require 'net/http'
      require 'json'

      @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query + '&distance=0&API_KEY=0A8AF167-EA05-4781-8EBB-C96C222456EC'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
    
    # Check for empty return result   
      if @output.empty?
        @final_output = "Error"
      elsif !@output
        @final_output = "Error"
      else
        @final_output = @output[0]['AQI']
      end

      if @final_output == "Error"
        @api_color = "gray"
      elsif @final_output <= 50
        @api_color = "green"
        @api_description = "Air Quality Good" 
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = "yellow"
        @api_description = "Air Quality Moderate"
      elsif @final_output >= 101 && @final_output <= 150
        @api_color = "orange"
        @api_description = "Unhealthy for Sensitive Groups (USG)"
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = "red"
        @api_description = "Air Quality Unhealthy"
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = "purple"
        @api_description = "Air Quality Very Unhealthy"
 
      elsif @final_output >= 301 && @final_output <= 500
        @api_color = "maroon"
        @api_description = "Air Quality Hazardous"
  
      
      end
end
end
end