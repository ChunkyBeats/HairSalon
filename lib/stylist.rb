class Stylist
  attr_reader :stylist_name
  attr_accessor :id

  def initialize(attributes)
    @stylist_name = attributes[:stylist_name]
    @id = attributes[:id]
  end

  def self.all
    returned_stylists = []
    stylists = DB.exec("SELECT * FROM stylists;")
    stylists.each do |stylist|
      stylist_name = stylist["stylist_name"]
      id = stylist.fetch("id").to_i
      returned_stylists.push(Stylist.new(stylist_name: stylist_name, id: id))
    end
    returned_stylists
  end

  def self.find(id)
    found_stylist = nil
    Stylist.all.each do |stylist|
      if stylist.id.==(id)
        found_stylist = stylist
      end
    end
    found_stylist
  end

  def save
    stylist = DB.exec("INSERT INTO stylists (stylist_name) VALUES ('#{@stylist_name}') RETURNING id;")
    @id = stylist.first.fetch("id").to_i
  end

  def ==(another_stylist)
    self.stylist_name == another_stylist.stylist_name
    # self.stylist_name.==(another_stylist.stylist_name).&(self.id.==(another_stylist.id))
  end

  def delete
    DB.exec("DELETE FROM stylists WHERE id = #{self.id};")
  end

  def update(attributes)
    @stylist_name = attributes[:stylist_name]
    @id = self.id
    DB.exec("UPDATE stylists set stylist_name = '#{@stylist_name}' WHERE id = #{@id};")
  end

  # def clients                     ORIGINAL CLIENT METHOD
  #   client_array = []
  #   results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id};")
  #   results.each do |client|
  #     client_name = client.fetch("client_name")
  #     stylist_id = client.fetch("stylist_id").to_i
  #     client_array.push(Client.new(client_name: client_name, stylist_id: stylist_id))
  #   end
  #   client_array
  # end

  def clients
    client_array = []
    results = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id};")
    results.each do |client|
      client_name = client.fetch("client_name")
      client_array.push(client_name)
    end
    client_array
  end


end
