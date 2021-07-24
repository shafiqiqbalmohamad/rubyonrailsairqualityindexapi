class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=60610&distance=25&API_KEY=2ECB1EAB-6356-4FFD-A1D5-6CB0990784E4'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    #Check for empty return value from API
    if @output.empty?
      @final_output = "Error"
    elsif !@output
      @final_output = "Error"
    else
      @final_output = @output[0]['AQI']
    end

    if @final_output == "Error"
      @api_color = "error"
    elsif @final_output <= 50
      @api_color = "good"
      @api_description = "0-50. Good."
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "moderate"
      @api_description = "51-100. Moderate."
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "usg"
      @api_description = "101-150. Unhealthy for Sensitive Groups (USG)."
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "unhealthy"
      @api_description = "151-200. Unhealthy."
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "veryunhealthy"
      @api_description = "201-300. Very Unhealthy."
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "hazardous"
      @api_description = "301-500. Hazardous."
    end

  end

  def zipcode
    @zip_query = params[:zipcode]
    if params[:zipcode] == ""
      @zip_query = "Hello, you forgot to enter a "
    elsif params[:zipcode]
      #do API stuff

      require 'net/http'
      require 'json'
  
      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query + '&distance=0&API_KEY=2ECB1EAB-6356-4FFD-A1D5-6CB0990784E4'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
  
      #Check for empty return value from API
      if @output.empty?
        @final_output = "Error"
      elsif !@output
        @final_output = "Error"
      else
        @final_output = @output[0]['AQI']
      end
  
      if @final_output == "Error"
        @api_color = "error"
      elsif @final_output <= 50
        @api_color = "good"
        @api_description = "0-50. Good."
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = "moderate"
        @api_description = "51-100. Moderate."
      elsif @final_output >= 101 && @final_output <= 150
        @api_color = "usg"
        @api_description = "101-150. Unhealthy for Sensitive Groups (USG)."
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = "unhealthy"
        @api_description = "151-200. Unhealthy."
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = "veryunhealthy"
        @api_description = "201-300. Very Unhealthy."
      elsif @final_output >= 301 && @final_output <= 500
        @api_color = "hazardous"
        @api_description = "301-500. Hazardous."
      end
    
    end
  end

end
