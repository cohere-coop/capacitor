def time_zone_options_for_select(selected = nil, priority_zones = nil, model = ::ActiveSupport::TimeZone)
        zone_options = "".html_safe
        zones = model.all
        convert_zones = lambda { |list| list.map { |z| [ z.to_s, z.name ] } }
end
