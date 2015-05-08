class Client
  attr_reader :client_name
  attr_accessor :id, :stylist_id

  def initialize(attributes)
    @client_name = attributes[:client_name]
    @id = attributes[:id]
    @stylist_id = attributes[:stylist_id]
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

  def assign_stylist(stylist)
    styler_name = stylist.stylist_name
    returned_results = DB.exec("SELECT id FROM stylists WHERE stylist_name = ('#{styler_name}');")
    stylist_ids = []
    returned_results.each() do |thing|
      style_id = thing.fetch("id")
      stylist_ids.push(style_id)
    end
    id_of_stylist = stylist_ids.first.to_i
    @stylist_id = id_of_stylist
    DB.exec("UPDATE clients SET stylist_id = (#{id_of_stylist}) WHERE client_name = ('#{self.client_name}');")
  end


end
