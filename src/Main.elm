module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


---- MODEL ----


type alias Model =
    { total : Int
    , userInput : String
    , error : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { total = 0
      , userInput = ""
      , error = Nothing
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = AddCalorie
    | Clear
    | UserInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddCalorie ->
            ( { model | total = model.total + 1 }, Cmd.none )

        Clear ->
            ( { model | total = 0 }, Cmd.none )

        UserInput val ->
            case String.toInt val of
                Ok input ->
                    ( { model
                        | total = input
                        , error = Nothing
                      }
                    , Cmd.none
                    )

                Err err ->
                    ( { model
                        | total = 0
                        , error = Just err
                      }
                    , Cmd.none
                    )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ (toString model.total)) ]
        , input
            [ type_ "number", onInput UserInput ]
            []
        , div [] [ text (Maybe.withDefault "" model.error)]
        , button
            [ type_ "button"
            , onClick AddCalorie
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
