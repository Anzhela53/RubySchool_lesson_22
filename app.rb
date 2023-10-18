#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'


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

post '/contacts' do 
	Pony.mail(
		@name => params[:name],
	  @mail => params[:mail],
	  @body => params[:body],
	  @to => 'a.y.golikova@gmail.com',
	  @subject => params[:name] + " has contacted you",
	  @body => params[:message],
	  @port => '587',
	  @via => :smtp,
	  @via_options => { 
		@address              => 'smtp.gmail.com', 
		@port                 => '587', 
		@enable_starttls_auto => true, 
		@user_name            => 'anzhela', 
		@password             => 'password-, 
		@authentication       => :plain, 
		@domain               => 'localhost.localdomain'
	  })
	retutn '/success' 
	end


	db = SQLite3::Database.new 'BarberShop'