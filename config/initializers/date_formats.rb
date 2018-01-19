# frozen_string_literal: true

Date::DATE_FORMATS[:friendly_date] = "%A %B %-d"
Time::DATE_FORMATS[:friendly_date] = "%A %B %-d"

Date::DATE_FORMATS[:hour_of_day] = "%-l:00%p"
Time::DATE_FORMATS[:hour_of_day] = "%-l:00%p"
