require 'spec_helper'

describe Client do
  describe '#client_name' do
    it('returns the name of the client') do
      test_client = Client.new(client_name: "Babs")
      expect(test_client.client_name).to(eq("Babs"))
    end
  end
end
