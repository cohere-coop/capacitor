# Co-erces an HStore object of feature flags into a ruby model
class Features
  include Virtus.model
  attribute :check_in, Boolean, default: true

  def self.dump(features)
    features.to_hash
  end

  def self.load(features)
    new(features)
  end
end
