require 'spec_helper'

describe Client do
  describe '#client_name' do
    it('returns the name of the client') do
      test_client = Client.new(client_name: "Babs")
      expect(test_client.client_name).to(eq("Babs"))
    end
  end

  describe('.all') do
    it('will be empty at first') do
      expect(Client.all).to(eq([]))
    end
  end

  describe ('#save') do
    it('stores a client to the database') do
      test_client = Client.new(client_name: "Babs Bunny")
      test_client.save
      expect(Client.all).to(eq([test_client]))
    end
  end

  describe ('#==') do
    it('is the same client if they have the same name') do
      client1 = Client.new(client_name: "Elmira")
      client2 = Client.new(client_name: "Elmira")
      expect(client1).to(eq(client2))
    end
  end

  describe('#delete') do
    it('will delete a client from the salon') do
      test_client = Client.new(client_name: "Tweety")
      test_client.save
      test_client2 = Client.new(client_name: "Babs")
      test_client2.save
      test_client.delete
      expect(Client.all).to(eq([test_client2]))
    end
  end

  describe('#update') do
    it('lets the user update a client name in the DB') do
      client = Client.new(client_name: "Elmer")
      client.save()
      client.update(client_name: "Elmer Fudd")
      expect(client.client_name).to(eq("Elmer Fudd"))
    end
  end

  # describe('#assign_stylist') do
  #   it('assigns a stylist to a client') do
  #     client = Client.new(client_name: "Sylvester")
  #     client.save
  #     stylist = Stylist.new(stylist_name: "Bugs Bunny")
  #     stylist.save
  #     client.assign_stylist(stylist)
  #     expect(client.stylist_id).to(eq(stylist.id))
  #   end
  # end


end
