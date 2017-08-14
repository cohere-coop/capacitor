# frozen_string_literal: true

# Key/value store that normalizes keys to :key_name from "KeyName" or "Key
# name"
class Registry
  attr_accessor :store
  def initialize(store = {})
    self.store = store
  end

  def add(key, value)
    store[canonicize(key)] = value
  end

  def get(key)
    store.fetch(canonicize(key))
  end

  def canonicize(key)
    key.underscore.downcase.tr(" ", "_").to_sym
  end
end
