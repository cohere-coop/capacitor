
  class AccountOwnsAllPolicy
    attr_accessor :account
    def initialize(account)
      @account = account
    end

    def ensure_access!(attributes_collection, field, relation)
      ids = (attributes_collection || {}).map do |id, attrs|
        attrs[field]
      end.compact

      raise UnauthorizedActionError unless account.send(relation).where(id: ids).count == ids.count
    end
  end
