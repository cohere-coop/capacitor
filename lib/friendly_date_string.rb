# Provides a `to_friendly_date_s` to time objects and `to_friendly_s` on date objects
# Which results in the format "Wednesday Jan 5"
module FriendlyDateString
  refine DateTime do
    def to_friendly_date_s
      to_date.to_friendly_s
    end
  end

  refine Date do
    def to_friendly_s
      strftime("%A %B %-d")
    end
  end

  refine Time do
    def to_friendly_date_s
      to_date.to_friendly_s
    end
  end

  if const_defined? "ActiveSupport::TimeWithZone"
    refine ActiveSupport::TimeWithZone do
      def to_friendly_date_s
        to_date.to_friendly_s
      end
    end
  end
end
