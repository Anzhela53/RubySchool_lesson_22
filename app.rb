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

	#для каждой пары ключ-значение
	hh.each do |key, value|
		if params[key] == ''
			#переменной error присвоить value из хуша hh
			#(а value из хеша hh это сообщение об ошибке)
			#т.е. переменной error присвоить сообщение об ошибке
			@error = hh[key]

			#вернуть представление visit
			return erb:visit
		end
	end
	
	erb "OK, username is #{@username}. Phone: #{@phone}, Date and time: #{@datetime},Barber: #{@barber}, Color: #{@color}"
end