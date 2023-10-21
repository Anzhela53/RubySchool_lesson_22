#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'


def is_barber_exists? db, name
	db.execute('select * from Barbers where name=?', [name]).length > 0
end	

def seed_db db, barbers
	barbers.each do |barber|
		if !is_barber_exists? db, barber
			db.execute 'INSERT INTO Barbers (name) VALUES(?)', [barber]
		end
	end
end



def get_db
	return SQLite3::Database.new 'BarberShop.db'
	db.results_as_hash = true
	return db
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS
		"Users"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"username" TEXT,
			"phone" TEXT,
			"datestamp" TEXT,
			"barber" TEXT,
			"color" TEXT
		)'

	db.execute 'CREATE TABLE IF NOT EXISTS
		"Barbers"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"name" TEXT
		)'

	seed_db db, ['Jesse', 'Gas', 'Lesse', 'Mikolay']
	db.close
end

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

	db = get_db
	db.execute 'INSERT INTO
		Users
		(
			username,
			phone,
			datestamp,
			barber,
			color
		)
		VALUES (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]
	
	erb "OK, username is #{@username}. Phone: #{@phone}, Date and time: #{@datetime},Barber: #{@barber}, Color: #{@color}"
end


get '/showusers' do
	db = get_db

	@results=db.execute 'select * from Users order by id desc'
	db.close

	erb :showusers
end

