require 'rails_helper'

describe TestApi do

  describe '.call' do
    it 'get users' do
      VCR.use_cassette('users_receipt') do
        api = described_class.new('users')
        api.call

        expect(api.success?).to be_truthy
      end
    end
  end
end