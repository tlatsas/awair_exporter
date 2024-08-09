# frozen_string_literal: true

require "net/http"
require "json"

module AwairExporter
  class AwairClient
    DEFAULT_PORT = 80

    def initialize(host: nil, port: nil)
      @host = host || ENV["AWAIR_HOST"]
      @port = port || ENV["AWAIR_PORT"] || DEFAULT_PORT
    end

    def latest
      response = client.get("/air-data/latest")
      JSON.parse(response.body)
    end

    private

    def client
      @client ||= Net::HTTP.new(@host, @port)
    end
  end
end
