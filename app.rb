#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end


get '/about' do
	erb :about
end


get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]


	f.File.open '/public/users.txt', 'a'
	f.write "User: #{@username}. Phone: #{@phone}. Date and time: #{@datetime}"
	f.close
end

get '/contacts' do
	erb :contacts
end