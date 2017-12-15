# frozen_string_literal: true

# Waits for the given URI to come up
class WaitForUp
  attr_accessor :up, :count, :uri, :max_attempts, :name, :hint
  def initialize(uri, max_attempts: 30, name: "Service", hint: "<no hint provided>")
    self.uri = uri
    self.up = false
    self.count = 0
    self.max_attempts = max_attempts
    self.name = name
    self.hint = hint
  end

  def wait
    until up?
      puts "Waiting for #{name} at #{uri}" if count.zero?
      raise failure_message if count > max_attempts
      print "⏳"
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

  def failure_message
    <<~"END"
      It didn't come up after #{max_attempts} times!
      Hint: #{hint}
    END
  end
end
