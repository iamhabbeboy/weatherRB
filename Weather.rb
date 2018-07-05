require 'net/http'
require 'uri'
require 'json'
require 'colorize'

class Weather
    def initialize(location)
        @location = location
        @url    = 'https://query.yahooapis.com'
        @url    += '/v1/public/yql?q='
        @query  = @url + "select item.condition"
        @query  += " from weather.forecast where woeid"
        @query  += " in (select woeid from geo.places(1)"
        @query  += " where text='" + location + "') and u='c'"
        @query  += "&format=json"
        @loading = '🔥 processing...'
    end

    def request
        processing 'started'
        begin
            uri = URI.parse(@query)
            response = Net::HTTP.get_response(uri)

            if response.code.to_s == "200"
                resp = JSON.parse(response.body)
                condition = resp['query']['results']['channel']
                temp = condition['item']['condition']
                p "Temperature in #{@location} is #{temp["text"].to_s} #{temp['temp']}C"
            else
                p "☠️ Try typing in a city / state 👹"
            end
        rescue
            p "☠️ Try typing in a city / state 👹"
        end
        processing ''
        #system('clear')
    end

    def processing text
        if text == ''
            text = "completed 💪"
        else
            text = "🔥 processing...\n"
        end
        print text
    end

end

# response.code
# response.body
