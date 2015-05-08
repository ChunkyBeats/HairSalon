class Client
  attr_reader :client_name
  attr_accessor :id

  def initialize(attributes)
    @client_name = attributes[:client_name]
    @id = attributes[:id]
  end

  def self.all
    returned_clients = []
    clients = DB.exec("SELECT * FROM clients;")
    clients.each do |client|
      client_name = client["client_name"]
      id = client.fetch("id").to_i
      returned_clients.push(Client.new(client_name: client_name, id: id))
    end
    returned_clients
  end

  def save
    client = DB.exec("INSERT INTO clients (client_name) VALUES ('#{@client_name}') RETURNING id;")
    @id = client.first.fetch("id").to_i
  end

  def ==(another_client)
    self.client_name.==(another_client.client_name).&(self.id.==(another_client.id))
  end

  def delete
    DB.exec("DELETE FROM clients WHERE id = #{self.id};")
  end

  def update(attributes)
    @client_name = attributes[:client_name]
    @id = self.id
    DB.exec("UPDATE clients set client_name = '#{@client_name}' WHERE id = #{@id};")
  end

end
