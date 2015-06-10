class LogsDecorator < Draper::CollectionDecorator
  DEFAULT_RECENT_RANGES = [7, 14, 21]
  DEFAULT_ORDERS = [:worked_at, :quality, :amount]
  def recents
    DEFAULT_RECENT_RANGES
  end

  def orders
    DEFAULT_ORDERS
  end
end
