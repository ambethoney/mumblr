require 'redis'
require 'json'
require 'pry'
require 'httparty'
require 'sinatra/base'
require 'sinatra/reloader'
require 'date'

require_relative 'server'

run Mumblr::Server
