# frozen_string_literal: true

begin
  require "dotenv/load"
rescue LoadError
  nil # ignore
end

if ENV["AWAIR_HOST"].nil?
  puts "Please set AWAIR_HOST environment variable"
  exit 1
end

lib_path = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require "bundler/setup"
require "awair_exporter"

run AwairExporter::App
