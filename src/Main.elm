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
