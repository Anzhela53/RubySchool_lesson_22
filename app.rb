#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end


get '/about' do
	@error = 'Something wrong!!!'
	erb :about
end


get '/visit' do
	erb :visit
end


post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	if @username ==''
		@error = 'Fill in the name field'
	end

	if @phone ==''
		@error = 'Fill in the phone field'
	end

	if @datetime ==''
		@error = 'Fill in the date and timef ield'
	end

	if @error =! ''
		return erb :visit
	end

	
	erb "OK, username is #{@username}. Phone: #{@phone}, Date and time: #{@datetime},Barber: #{@barber}, Color: #{@color}"
end