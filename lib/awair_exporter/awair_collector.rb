# frozen_string_literal: true

module AwairExporter
  class AwairCollector < Prometheus::Middleware::Collector
    NAMESPACE = "awair"

    def initialize(app)
      super(app, metrics_prefix: NAMESPACE)

      init_metrics
    end

    protected

    def init_metrics
      @temperature = @registry.gauge("#{NAMESPACE}_temperature_celsius".to_sym, docstring: "Temperature in Celsius")
      @dew_point = @registry.gauge("#{NAMESPACE}_dew_point_celsius".to_sym, docstring: "Dew point in Celsius")
      @humidity = @registry.gauge("#{NAMESPACE}_humidity".to_sym, docstring: "Humidiry in %")
      @co2 = @registry.gauge("#{NAMESPACE}_co2".to_sym, docstring: "CO2 in ppm")
      @voc = @registry.gauge("#{NAMESPACE}_voc".to_sym, docstring: "VOC in ppb")
      @pm25 = @registry.gauge("#{NAMESPACE}_pm25".to_sym, docstring: "PM2.5 in micrograms per cubic meter")
      @score = @registry.gauge("#{NAMESPACE}_score".to_sym, docstring: "Awair calculated score")
    end

    def collect_device_data
      AwairClient.new.latest
    end

    def record(env, code, duration)
      data = collect_device_data

      @temperature.set(data["temp"])
      @dew_point.set(data["dew_point"])
      @humidity.set(data["humid"])
      @co2.set(data["co2"])
      @voc.set(data["voc"])
      @pm25.set(data["pm25"])
      @score.set(data["score"])

      super(env, code, duration)
    end
  end
end
