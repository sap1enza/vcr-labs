class TestApi

  def initialize(endpoint)
    @endpoint = endpoint
  end

  def call
    post
  end

  def completed?
    @response_request.present?
  end

  def success?
    completed? && @response_request.status == 200
  end

  private

  attr_reader :endpoint

  def post
    @response_request = nil

    @response_request = client.get do |request|
      request.url endpoint
    end
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  def client
    @client ||=
      api_url = 'https://jsonplaceholder.typicode.com/'
      Faraday.new(url: api_url, headers: headers) do |faraday|
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
  end
end