require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

class App < Sinatra::Base
  get '/sinatra' do
    'Hello world!'
  end

  post '/webhook' do
    result = JSON.parse(request.body.read)["result"]
    if result["contexts"].present?
      response = InterpretService.call(result["action"], result["contexts"][0]["parameters"])
    else
      response = InterpretService.call(result["action"], result["parameters"])
    end

    if result["action"] == "info"
      slackResponse = JSON.parse(response)
    else
      slackResponse = response
    end

    content_type :json
    {
      "speech": response,
      "displayText": response,
      "data": slackResponse,
      "source": "Slack"
    }.to_json
  end

  get '/debug' do
    response = InterpretService.call("info", "2")

    slackResponse = JSON.parse(response)

    content_type :json
    {
      "speech": response,
      "displayText": response,
      "data": slackResponse,
      "source": "Slack"
    }.to_json
  end
end
