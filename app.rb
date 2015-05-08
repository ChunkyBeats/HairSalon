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
  @stylists = Stylist.all
  @stylist = Stylist.find(params.fetch('id').to_i)
  erb(:stylist)
end

get('/stylist/assign_client') do
  # @stylist = Stylist.find(params.fetch('id').to_i)
  erb(:assign_form)
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

get('/client/:id') do
  @client = Client.find(params.fetch('id').to_i)
  erb(:client)
end

patch('/client/:id') do
  @client = Client.find(params.fetch('id').to_i)
  name = params.fetch("name")
  @client.update(client_name: name)
  erb(:client)
end

patch('/stylist/:id') do
  @stylist = Stylist.find(params.fetch('id').to_i)
  name = params.fetch("name")
  @stylist.update(stylist_name: name)
  erb(:stylist)
end

delete('/clients') do
  client = Client.find(params.fetch("client_id").to_i)
  client.delete
  @clients = Client.all
  erb(:clients)
end

delete('/stylists') do
  stylist = Stylist.find(params.fetch("stylist_id").to_i)
  stylist.delete
  @stylists = Stylist.all
  erb(:stylists)
end

# post('/client/:id/delete') do
#   client_id = Client.find(params.fetch('id').to_i)
#   client.delete
#   erb(:clients)
# end
