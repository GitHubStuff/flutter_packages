# date_time_package

Collection of helpers that extend DateTime and String for time actions

## Overview

- DateTimeElement => enum year, month, day, hour, minute, second, millisecond, microseconds
- String consoleTimeStamp => Creates a string with hours, minutes, seconds, microseconds for use in console logs
- DateTime next(DateTimeElement element, [int delta = 1]) => applies a delta a given DateTimeElement **[Note: Deltas for 'month' adjust to last day of month eg. Oct 31 + a month => Nov 30 {the last day in november}]**
- DateTime round([DateTimeElement element = second]) => Zero's out all elements "Past" the element (day,month are set to 1){minimal day = year-01-01T00:00:00:00.00000}. **[NOTE: Year cannot be zeroed]**

### Conclusion

Be Kind To Each Other
