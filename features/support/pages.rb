# frozen_string_literal: true

require_relative "registry"

# Custom page class for capacitor specific stuff
class Page < SitePrism::Page
  def self.reference_as
    name.gsub("Page", "")
  end

  def self.inherited(child)
    registry.add(child.reference_as, child)
  end

  def self.registry
    @registry ||= Registry.new
  end

  attr_accessor :session
  def initialize(session)
    self.session = session
    super()
  end

  def perform(action, data)
    arguments = data.split(" ")
    model  = arguments.pop
    traits = arguments.map { |arg| arg.delete(",").to_sym }
    object = build(model, *traits)
    public_send(action, object)
  end

  def build(model, *traits)
    FactoryGirl.build(model, *traits)
  end
end

# Represents the Home Page for feature testing purposes
class HomePage < Page
  set_url "/"
end
