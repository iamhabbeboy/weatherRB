### Get weather temperate on terminal
### Using Yahoo Api
require './Weather.rb'
require 'colorize'

puts "Enter your current location:[]".yellow

begin
    location = gets.to_s
    init = Weather.new(location)
    puts init.request
rescue
    p "☠️ 😭 Only character is required here homies 👹"
end