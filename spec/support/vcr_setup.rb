require 'vcr'

VCR.configure do |c|
  # Onde os cassettes ficarão salvos
  c.cassette_library_dir = 'spec/vcr_cassettes'

  # Gem para fazer a requisição HTTP
  c.hook_into :webmock

  # Salva o cassete apenas uma vez
  c.default_cassette_options = { :record => :once }
 
  # Gera os nomes automaticamente ( :vcr )
  c.configure_rspec_metadata!

  # Permite conexão externa quando não existir cassettes
  c.allow_http_connections_when_no_cassette = true
end
