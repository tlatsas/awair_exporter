# frozen_string_literal: true

require "sinatra/base"
require "prometheus/middleware/collector"
require "prometheus/middleware/exporter"
require "awair_exporter/awair_client"
require "awair_exporter/awair_collector"

module AwairExporter
  class App < Sinatra::Base
    use Rack::Deflater
    use AwairCollector
    use Prometheus::Middleware::Exporter

    get "/" do
      puts settings.inspect

      body = <<~HTML
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="utf-8">
            <title>Awair Exporter</title>
          </head>
          <body>
            <h1>Prometheus Awair Exporter</h1>
            <div><a href="/metrics">Metrics</a></div>
          </body>
        </html>
      HTML

      [200, { "Content-Type" => "text/html" }, body]
    end
  end
end
