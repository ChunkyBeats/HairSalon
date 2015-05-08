require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
also_reload('./lib/*.rb')
require('pry')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  erb(:index)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists') do
  stylist = Stylist.new(stylist_name: params.fetch("stylist_name"))
  stylist.save
  @stylists = Stylist.all
  erb(:stylists)
end

get('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i)
  erb(:stylist)
end

get('/clients') do
  @clients = Client.all
  erb(:clients)
end

get('/clients/new') do
  erb(:client_form)
end

post('/clients') do
  client = Client.new(client_name: params.fetch("client_name"))
  client.save
  @clients = Client.all
  erb(:clients)
end
