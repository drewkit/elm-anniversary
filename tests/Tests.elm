module Tests exposing (..)

import Anniversary exposing (getYears, isDay)
import Expect
import Test exposing (..)
import Time exposing (millisToPosix, utc)


testPosix : Time.Posix
testPosix =
    -- calendar date of October 6th, 2023 (in utc time zone)
    millisToPosix 1696631960626


isAnniversaryDay : Test
isAnniversaryDay =
    Test.describe "Anniversary.isDay"
        [ test "Well it's not Christmas"
            (\_ ->
                Expect.equal False
                    (isDay utc testPosix { month = 12, day = 25 })
            )
        , test "But it is National Noodle Day...!"
            (\_ ->
                Expect.equal True
                    (isDay utc testPosix { month = 10, day = 6 })
            )
        ]


getAnniversaryYears : Test
getAnniversaryYears =
    Test.describe "Anniversary.getYears"
        [ test "Elm was 11 years old on date of testPosix"
            (\_ ->
                Expect.equal 11
                    (getYears utc
                        testPosix
                        { day = 30, month = 3, year = 2012 }
                    )
            )
        , test "A child born this year has zero birthdays"
            (\_ ->
                Expect.equal 0
                    (getYears utc
                        testPosix
                        { day = 2, month = 2, year = 2023 }
                    )
            )
        , test "A child celebrates their first birthday today"
            (\_ ->
                Expect.equal 1
                    (getYears utc
                        testPosix
                        { day = 6, month = 10, year = 2022 }
                    )
            )
        , test "A child expected in several months has zero birthdays"
            (\_ ->
                Expect.equal 0
                    (getYears utc
                        testPosix
                        { day = 2, month = 1, year = 2024 }
                    )
            )
        , test "A child celebrates their sixth birthday today"
            (\_ ->
                Expect.equal 6
                    (getYears utc
                        testPosix
                        { day = 6, month = 10, year = 2017 }
                    )
            )
        , test "Leap year anniversary is not a problem"
            (\_ ->
                Expect.equal 3
                    (getYears utc
                        testPosix
                        { day = 29, month = 2, year = 2020 }
                    )
            )
        , test "Last month marked the twenty second anniversary of 9/11"
            (\_ ->
                Expect.equal 22
                    (getYears utc testPosix { day = 11, month = 9, year = 2001 })
            )
        ]


getNextAnniversary : Test
getNextAnniversary =
    Test.describe "Anniversary.getNext"
        [ test "provides DayMonthYear record for next occurrence of anniversary"
            (\_ ->
                Expect.equal { day = 30, month = 3, year = 2024 }
                    (Anniversary.getNext utc testPosix { day = 30, month = 3 })
            )
        , test "run2"
            (\_ ->
                Expect.equal { day = 10, month = 11, year = 2023 }
                    (Anniversary.getNext utc testPosix { day = 10, month = 11 })
            )
        , test "run3"
            (\_ ->
                Expect.equal { day = 4, month = 4, year = 2024 }
                    (Anniversary.getNext utc testPosix { day = 4, month = 4 })
            )
        , test "if current day is date of anniversary, then the next occurrence will be next year"
            (\_ ->
                Expect.equal { day = 6, month = 10, year = 2024 }
                    (Anniversary.getNext utc testPosix { day = 6, month = 10 })
            )
        ]


getLastAnniversary : Test
getLastAnniversary =
    Test.describe "Anniversary.getLast"
        [ test "provides DayMonthYear record for last occurrence of anniversary"
            (\_ ->
                Expect.equal { day = 30, month = 3, year = 2023 }
                    (Anniversary.getLast utc testPosix { day = 30, month = 3 })
            )
        , test "run2"
            (\_ ->
                Expect.equal { day = 10, month = 11, year = 2022 }
                    (Anniversary.getLast utc testPosix { day = 10, month = 11 })
            )
        , test "run3"
            (\_ ->
                Expect.equal { day = 4, month = 4, year = 2023 }
                    (Anniversary.getLast utc testPosix { day = 4, month = 4 })
            )
        , test "if current day is date of anniversary, then the last occurrence is from last year"
            (\_ ->
                Expect.equal { day = 6, month = 10, year = 2022 }
                    (Anniversary.getLast utc testPosix { day = 6, month = 10 })
            )
        ]
