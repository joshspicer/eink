## complexSearch

```
curl "https://api.spoonacular.com/recipes/complexSearch?query=pasta&diet=vegetarian" -H "x-api-key: $SPOONACULAR_API" | jq '.results[0]'

{
  "id": 654905,
  "title": "Pasta With Chickpeas and Kale",
  "image": "https://spoonacular.com/recipeImages/654905-312x231.jpg",
  "imageType": "jpg"
}
```

# In one query

```
recipe=$(curl "https://api.spoonacular.com/recipes/complexSearch?query=pasta&diet=vegetarian&addRecipeInformation=true&fillIngredients=true&number=1" -H "x-api-key: $SPOONACULAR_API" | jq '.results[0]')

title=$(echo $recipe | jq '.title')

# Ingredient formatted like "2 cups of chickpeas (cooked, drained)"

# Create meta like (cooked, drained) for each ingredient
meta=$(echo $recipe | jq '.extendedIngredients | map("\(.meta)") | join("| ")'| sed 's/"//g' | sed 's/\\//g')
rest=$(echo $recipe | jq '.extendedIngredients | map("\(.amount) \(.unit) of \(.name) <REPLACE_WITH_META>") | join("| ")'| sed 's/"//g' | sed 's/\\//g')

for i in $(seq 1 $(echo $recipe | jq '.extendedIngredients | length')); do
  rest=$(echo $rest | sed "s/<REPLACE_WITH_META>/$(echo $meta | cut -d'|' -f$i)/" | sed 's/\\//g')
done

```