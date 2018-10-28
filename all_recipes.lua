local list = {}
for _, recipe in pairs(game.player.force.recipes) do
   item = "{\"name\":\"" .. recipe.name .. "\""
   item = item .. ",\"energy\":" .. recipe.energy
   item = item .. ",\"products\":["
   sep = ""
   for _, product in pairs(recipe.products) do
      if product.amount ~= nil then
         item = item .. sep .. "{\"amount\":" .. product.amount .. ",\"name\":\"" .. product.name .. "\"}"
         sep = ", "
      end
   end
   item = item .. " ],"
   item = item .. "\"ingredients\":["
   sep = ""
   for _, ingredient in pairs(recipe.ingredients) do
      item = item .. sep .. "{\"amount\":" .. ingredient.amount .. ",\"name\":\"" .. ingredient.name .. "\"}"
      sep = ", "
   end
   item = item .. " ] }"
   table.insert(list, item)
end
game.write_file("recipes.json", "[" .. table.concat(list, ",") .. "]", true)
