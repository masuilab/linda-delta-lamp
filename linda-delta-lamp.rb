#!/usr/bin/env ruby
require 'rubygems'
require 'eventmachine'
require 'em-rocketio-linda-client'
require 'arduino_firmata'
$stdout.sync = true

EM::run do
  arduino = ArduinoFirmata.connect ENV["ARDUINO"], :eventmachine => true

  url   = ENV["LINDA_BASE"]  || ARGV.shift || "http://localhost:5000"
  space = ENV["LINDA_SPACE"] || "test"
  puts "connecting.. #{url}"
  linda = EM::RocketIO::Linda::Client.new url
  ts = linda.tuplespace[space]

  linda.io.on :connect do  ## RocketIO's "connect" event
    puts "connect!! <#{linda.io.session}> (#{linda.io.type})"
    ts.watch ["lamp"] do |tuple|
      p tuple
      next unless tuple.size == 2
      _, state = tuple
      case state.downcase
      when "on"
        arduino.digital_write 12, true
      when "off"
        arduino.digital_write 12, false
      end
      tuple << "success"
      ts.write tuple
    end
  end

  linda.io.on :disconnect do
    puts "RocketIO disconnected.."
  end
end
