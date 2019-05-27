require 'rails_helper'

describe TestApi do
  describe '.call' do
    let(:body) do
      {
        title: 'Post Title',
        body: 'Lorem Ipsum',
        userId: 1
      }
    end

    context 'RSpec' do
      it 'POST' do
        response = double('response')
        api = described_class.new('posts', body)

        allow(api).to receive(:success?).and_return(true)
        allow(api).to receive(:call).and_return(response)

        api.call

        expect(api).to be_success
      end
    end

    context 'WebMock' do
      let(:expected_response) do
        {
          id: 101,
          title: 'Post Title',
          body: 'Lorem Ipsum',
          userId: 1
        }
      end

      it 'POST' do
        stub_request(:post, "https://jsonplaceholder.typicode.com/posts").
          with(
            body: body,
            headers: { 'Content-Type' => 'application/json' }
          ).to_return(status: 201, body: expected_response.to_json)

        api = described_class.new('posts', body)
        api.call

        expect(api).to be_success
      end
    end

    context 'VCR' do
      it 'POST' do
        VCR.use_cassette('posts_receipt') do
          api = described_class.new('posts', body)
          api.call

          expect(api).to be_success
        end
      end
    end
  end
end
