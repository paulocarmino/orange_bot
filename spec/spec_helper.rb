require_relative '../app.rb'
require 'rspec'
require 'rack/test'
require 'ffaker'
# require 'pg_search'
Dir["./spec/support/**/*.rb"].each {|f| require f }
Dir["./app/services/**/*.rb"].each {|file| require file }

set :envirnoment, :text

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

Rspec.configure do |c|
  c.include RSpecMixin
  ActiveRecord::Base.logger = nil unless ENV['LOG'] == true
end
