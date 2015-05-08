require 'spec_helper'

describe Stylist do
  describe '#stylist_name' do
    it('returns the name of the stylist') do
      test_stylist = Stylist.new(stylist_name: "Babs")
      expect(test_stylist.stylist_name).to(eq("Babs"))
    end
  end

  describe('.all') do
    it('will be empty at first') do
      expect(Stylist.all).to(eq([]))
    end
  end

  describe ('#save') do
    it('stores a stylist to the database') do
      test_stylist = Stylist.new(stylist_name: "Babs Bunny")
      test_stylist.save
      expect(Stylist.all).to(eq([test_stylist]))
    end
  end

  describe ('#==') do
    it('is the same stylist if they have the same name') do
      stylist1 = Stylist.new(stylist_name: "Elmira")
      stylist2 = Stylist.new(stylist_name: "Elmira")
      expect(stylist1).to(eq(stylist2))
    end
  end

  describe('#delete') do
    it('will delete a stylist from the salon') do
      test_stylist = Stylist.new(stylist_name: "Tweety")
      test_stylist.save
      test_stylist2 = Stylist.new(stylist_name: "Babs")
      test_stylist2.save
      test_stylist.delete
      expect(Stylist.all).to(eq([test_stylist2]))
    end
  end

  describe('#update') do
    it('lets the user update a stylist name in the DB') do
      stylist = Stylist.new(stylist_name: "Elmer")
      stylist.save()
      stylist.update(stylist_name: "Elmer Fudd")
      expect(stylist.stylist_name).to(eq("Elmer Fudd"))
    end
  end

  describe('#clients') do
    it('returns the list of clients assigned to a stylist') do
      client = Client.new(client_name: "Anita Haircut")
      client.save
      stylist = Stylist.new(stylist_name: "Snip Snip")
      stylist.save
      client.assign_stylist(stylist)
      expect(stylist.clients).to(eq([client.client_name]))
    end
  end

end
