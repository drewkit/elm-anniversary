# Elm Anniversary

This package takes a Time.Zone, Time.Posix as well as a simple anniversary record and performs basic calculations.

## Basic Usage

```elm
> import Anniversary
> import Time exposing (utc, millisToPosix)

-- calendar date of October 6th, 2023 (in utc time zone)
> testPosix = millisToPosix 1696631960626

> Anniversary.isDay utc testPosix { day = 20, month = 3 }
False : Bool

> Anniversary.getYears utc testPosix { day = 20, month = 3, year = 2012  }
11 : Int

> Anniversary.getNext utc testPosix { day = 20, month = 3 }
{ day = 20, month = 3, year = 2024 }
    : Anniversary.DayMonthYear

> Anniversary.getLast utc testPosix { day = 20, month = 3 }
{ day = 20, month = 3, year = 2023 }
    : Anniversary.DayMonthYear
```