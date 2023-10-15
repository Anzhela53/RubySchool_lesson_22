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

	hh = {:username => 'Fill in the name field',
		:phone => 'Fill in the phone field',
		:datetime => 'Fill in the date and time field' }

	@error = hh.select {|key,_| params[key] == ""}.values.join(",")

	if @error != ''
		return erb :visit
	end
	
	erb "OK, username is #{@username}. Phone: #{@phone}, Date and time: #{@datetime},Barber: #{@barber}, Color: #{@color}"
end