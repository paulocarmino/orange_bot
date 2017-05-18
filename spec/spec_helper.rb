require_relative '../app.rb'
require 'rspec'
require 'rack/test'

set :envirnoment, :text

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

Rspec.configure do |c|
  c.include RSpecMixin
end
