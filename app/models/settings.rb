class Settings
  include Virtus.model

  attribute :check_in_reminder_time, Integer, default: 6

  def self.dump(settings)
    settings.to_hash
  end

  def self.load(settings)
    new(settings)
  end

  def persisted?
    false
  end
end
