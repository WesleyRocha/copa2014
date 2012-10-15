require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'sinatra/activerecord'
require 'uri'

require 'sass'
require 'compass'

require './config/environments'


class Investimento < ActiveRecord::Base  
end


get '/main.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss :"../assets/stylesheet/main"
end
get '/javascript/*' do
  content_type 'text/javascript', :charset => 'utf-8'
  params[:splat].each do |js|
    send_file File.open(File.dirname(__FILE__)+"/assets/javascript/"+js)
  end
end
get '/images/*' do
  content_type 'image/png', :charset => 'utf-8'
  params[:splat].each do |image|
    send_file File.open(File.dirname(__FILE__)+"/assets/images/"+image)
  end
end



get "/" do
  @invs = Investimento.where tema: :aeroporto
  puts "Investimentos: #{@invs.size}"
	erb :index, layout: :layout
end

get "/proporcao-de-valores" do
  erb :proporcao_valores, layout: :layout
end


