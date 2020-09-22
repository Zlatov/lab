require 'awesome_print'

a = Time.now
b = a.strftime("%Y-%m-%d")
c = a.strftime("%Y-%m-%d %H:%M:%S")
d = a.strftime("%Y-%m-%dT%H:%M:%S %z")
e = a.strftime("%Y-%m-%d %H:%M:%S %:z")
f = a.strftime("%Y-%m-%d %H:%M:%S %::z")
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
print 'e: '.red; puts e
print 'f: '.red; puts f
# exit


# Date (Year, Month, Day):
#   %Y - Year with century if provided, will pad result at least 4 digits.
#           -0001, 0000, 1995, 2009, 14292, etc.
#   %C - year / 100 (rounded down such as 20 in 2009)
#   %y - year % 100 (00..99)

#   %m - Month of the year, zero-padded (01..12)
#           %_m  blank-padded ( 1..12)
#           %-m  no-padded (1..12)
#   %B - The full month name (``January'')
#           %^B  uppercased (``JANUARY'')
#   %b - The abbreviated month name (``Jan'')
#           %^b  uppercased (``JAN'')
#   %h - Equivalent to %b

#   %d - Day of the month, zero-padded (01..31)
#           %-d  no-padded (1..31)
#   %e - Day of the month, blank-padded ( 1..31)

#   %j - Day of the year (001..366)

# Time (Hour, Minute, Second, Subsecond):
#   %H - Hour of the day, 24-hour clock, zero-padded (00..23)
#   %k - Hour of the day, 24-hour clock, blank-padded ( 0..23)
#   %I - Hour of the day, 12-hour clock, zero-padded (01..12)
#   %l - Hour of the day, 12-hour clock, blank-padded ( 1..12)
#   %P - Meridian indicator, lowercase (``am'' or ``pm'')
#   %p - Meridian indicator, uppercase (``AM'' or ``PM'')

#   %M - Minute of the hour (00..59)

#   %S - Second of the minute (00..60)

#   %L - Millisecond of the second (000..999)
#        The digits under millisecond are truncated to not produce 1000.
#   %N - Fractional seconds digits, default is 9 digits (nanosecond)
#           %3N  millisecond (3 digits)
#           %6N  microsecond (6 digits)
#           %9N  nanosecond (9 digits)
#           %12N picosecond (12 digits)
#           %15N femtosecond (15 digits)
#           %18N attosecond (18 digits)
#           %21N zeptosecond (21 digits)
#           %24N yoctosecond (24 digits)
#        The digits under the specified length are truncated to avoid
#        carry up.

# Time zone:
#   %z - Time zone as hour and minute offset from UTC (e.g. +0900)
#           %:z - hour and minute offset from UTC with a colon (e.g. +09:00)
#           %::z - hour, minute and second offset from UTC (e.g. +09:00:00)
#   %Z - Abbreviated time zone name or similar information.  (OS dependent)

# Weekday:
#   %A - The full weekday name (``Sunday'')
#           %^A  uppercased (``SUNDAY'')
#   %a - The abbreviated name (``Sun'')
#           %^a  uppercased (``SUN'')
#   %u - Day of the week (Monday is 1, 1..7)
#   %w - Day of the week (Sunday is 0, 0..6)

# ISO 8601 week-based year and week number:
# The first week of YYYY starts with a Monday and includes YYYY-01-04.
# The days in the year before the first week are in the last week of
# the previous year.
#   %G - The week-based year
#   %g - The last 2 digits of the week-based year (00..99)
#   %V - Week number of the week-based year (01..53)

# Week number:
# The first week of YYYY that starts with a Sunday or Monday (according to %U
# or %W). The days in the year before the first week are in week 0.
#   %U - Week number of the year. The week starts with Sunday. (00..53)
#   %W - Week number of the year. The week starts with Monday. (00..53)

# Seconds since the Epoch:
#   %s - Number of seconds since 1970-01-01 00:00:00 UTC.

# Literal string:
#   %n - Newline character (\n)
#   %t - Tab character (\t)
#   %% - Literal ``%'' character

# Combination:
#   %c - date and time (%a %b %e %T %Y)
#   %D - Date (%m/%d/%y)
#   %F - The ISO 8601 date format (%Y-%m-%d)
#   %v - VMS date (%e-%^b-%4Y)
#   %x - Same as %D
#   %X - Same as %T
#   %r - 12-hour time (%I:%M:%S %p)
#   %R - 24-hour time (%H:%M)
#   %T - 24-hour time (%H:%M:%S)
