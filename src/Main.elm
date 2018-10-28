import Browser
import Dict exposing (Dict)
import Html exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, float, int, list, map2, map4, string)


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
  { cookbook : Dict String Recipe
  , name : Maybe String
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model Dict.empty Nothing
  , getRecipeData ()
  )


-- UPDATE


type Msg
  = RecipeData (Result Http.Error (List Recipe))
  | SelectRecipe String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
      RecipeData result ->
        case result of
            Ok recipes ->
              ( { model | cookbook = (createCookbook recipes) }
              , Cmd.none
              )
            Err e ->
              let
                thing = Debug.log "error" e
              in
              ( model
              , Cmd.none
              )

      SelectRecipe name ->
        ( { model | name = Just name }
        , Cmd.none
        )

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW

makeRecipeButton : String -> Html Msg
makeRecipeButton name =
  li [] [
     button [ onClick (SelectRecipe name) ] [ text name ]
    ]

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Recipes" ]
    , div [] [ text (Maybe.withDefault "" model.name) ]
    , ul []
      (List.map makeRecipeButton (Dict.keys model.cookbook))
    ]

type alias Ingredient =
  { name: String
  , amount: Int
  }

type alias Recipe =
  { name : String
  , energy: Float
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
    (field "energy" float)
    (field "products" (list ingredientDecoder))
    (field "ingredients" (list ingredientDecoder))

allRecipesDecoder : Decoder (List Recipe)
allRecipesDecoder =
  list recipeDecoder

getRecipeData : () -> Cmd Msg
getRecipeData () =
  Http.send RecipeData <|
    Http.get "/src/recipes.json" allRecipesDecoder

createCookbook : List Recipe -> Dict String Recipe
createCookbook recipes =
  Dict.fromList
    (List.map (\x -> (x.name, x)) recipes)
