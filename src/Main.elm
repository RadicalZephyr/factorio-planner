import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, field, int, list, map2, map4, string)


-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL


type alias Model =
  {
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model
  , Cmd.none
  )


-- UPDATE


type Msg
  = Dummy


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      Dummy ->
        ( model
        , Cmd.none
        )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Hello World" ]
    ]

type alias Ingredient =
  { name: String
  , amount: Int
  }

type alias Recipe =
  { name : String
  , energy: Int
  , products: List Ingredient
  , ingredients : List Ingredient
  }

ingredientDecoder : Decoder Ingredient
ingredientDecoder =
  map2 Ingredient
    (field "name" string)
    (field "amount" int)

recipeDecoder : Decoder Recipe
recipeDecoder =
  map4 Recipe
    (field "name" string)
    (field "energy" int)
    (field "products" (list ingredientDecoder))
    (field "ingredients" (list ingredientDecoder))
