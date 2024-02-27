module Anniversary exposing
    ( getYears, isDay
    , getLast, getNext
    )

{-| Perform basic anniversary calculations

@docs getYears, isDay

-}

import Time exposing (Month(..), toDay, toMonth, toYear)


type alias DayMonthYear =
    { day : Int, month : Int, year : Int }


getDate : Time.Zone -> Time.Posix -> DayMonthYear
getDate zone time =
    let
        month =
            case toMonth zone time of
                Jan ->
                    1

                Feb ->
                    2

                Mar ->
                    3

                Apr ->
                    4

                May ->
                    5

                Jun ->
                    6

                Jul ->
                    7

                Aug ->
                    8

                Sep ->
                    9

                Oct ->
                    10

                Nov ->
                    11

                Dec ->
                    12
    in
    { day = toDay zone time
    , month = month
    , year = toYear zone time
    }


{-| Calculates the number of anniversary years passed
-}
getYears : Time.Zone -> Time.Posix -> DayMonthYear -> Int
getYears currentZone currentTime birthDate =
    let
        currentDate =
            getDate currentZone currentTime

        yearDiff =
            currentDate.year - birthDate.year

        comparedMonth =
            compare currentDate.month birthDate.month

        comparedDay =
            compare currentDate.day birthDate.day
    in
    if yearDiff <= 0 then
        0

    else
        case
            ( comparedMonth
            , comparedDay
            )
        of
            ( EQ, LT ) ->
                yearDiff - 1

            ( EQ, _ ) ->
                yearDiff

            ( LT, _ ) ->
                yearDiff - 1

            ( GT, _ ) ->
                yearDiff


type alias DayMonth a =
    { a | day : Int, month : Int }


{-| Returns a Bool on whether or not the provided Time.Zone / Time.Posix occurs on the anniversary
-}
isDay : Time.Zone -> Time.Posix -> DayMonth a -> Bool
isDay currentZone currentTime anniversaryDate =
    let
        currentDate =
            getDate currentZone currentTime

        comparedMonth =
            compare currentDate.month anniversaryDate.month

        comparedDay =
            compare currentDate.day anniversaryDate.day
    in
    case
        ( comparedMonth
        , comparedDay
        )
    of
        ( EQ, EQ ) ->
            True

        ( _, _ ) ->
            False


getNext : Time.Zone -> Time.Posix -> DayMonth a -> DayMonthYear
getNext currentZone currentTime anniversaryDate =
    let
        currentDate =
            getDate currentZone currentTime

        comparedMonth =
            compare currentDate.month anniversaryDate.month

        comparedDay =
            compare currentDate.day anniversaryDate.day

        yearOfNextAnniversary =
            case
                ( comparedMonth
                , comparedDay
                )
            of
                ( EQ, LT ) ->
                    currentDate.year

                ( EQ, _ ) ->
                    currentDate.year + 1

                ( LT, _ ) ->
                    currentDate.year

                ( GT, _ ) ->
                    currentDate.year + 1
    in
    { day = anniversaryDate.day
    , month = anniversaryDate.month
    , year = yearOfNextAnniversary
    }


getLast : Time.Zone -> Time.Posix -> DayMonth a -> DayMonthYear
getLast currentZone currentTime anniversaryDate =
    let
        currentDate =
            getDate currentZone currentTime

        comparedMonth =
            compare currentDate.month anniversaryDate.month

        comparedDay =
            compare currentDate.day anniversaryDate.day

        yearOfLastAnniversary =
            case
                ( comparedMonth
                , comparedDay
                )
            of
                ( EQ, GT ) ->
                    currentDate.year

                ( EQ, _ ) ->
                    currentDate.year - 1

                ( LT, _ ) ->
                    currentDate.year - 1

                ( GT, _ ) ->
                    currentDate.year
    in
    { day = anniversaryDate.day
    , month = anniversaryDate.month
    , year = yearOfLastAnniversary
    }
