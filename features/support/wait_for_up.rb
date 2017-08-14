# frozen_string_literal: true

# Waits for the given URI to come up
class WaitForUp
  attr_accessor :up, :count, :uri, :max_attempts, :name
  def initialize(uri, max_attempts: 30, name: "Service")
    self.uri = uri
    self.up = false
    self.count = 0
    self.max_attempts = max_attempts
    self.name = name
  end

  def wait
    until up?
      puts "Waiting for #{name} at #{uri}" if count.zero?
      raise "It didnt' come up after #{max_attempts} times!" if count > max_attempts
      print "."
      sleep(1)
      self.count += 1
    end
  end

  def up?
    response = Net::HTTP.get_response(URI(uri))
    response.is_a?(Net::HTTPSuccess)
  rescue Errno::ECONNREFUSED, Errno::EADDRNOTAVAIL => _
    false
  end
end
