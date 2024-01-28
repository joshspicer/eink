#!/bin/bash

set -e


RECIPE_TITLE='%%%RECIPE_TITLE%%%'
INGREDIENT_POINTER='%%%INGREDIENT_POINTER%%%'
METHOD_POINTER='%%%METHOD_POINTER%%%'

if [ -z "$SPOONACULAR_API" ]; then
  echo "Please set the SPOONACULAR_API environment variable"
  exit 1
fi

QUERY="$1"

if [ -z "$QUERY" ]; then
  echo "Please provide a query"
  exit 1
fi

recipe=$(curl "https://api.spoonacular.com/recipes/complexSearch?query=$QUERY&diet=vegetarian&addRecipeInformation=true&fillIngredients=true&number=1" -H "x-api-key: $SPOONACULAR_API" | jq '.results[0]')

if [ "$recipe" == "null" ]; then
  echo "No recipe found for query: $QUERY"
  echo $recipe
  exit 1
fi

# recipe=$(cat ./oneQuery.json)

title=$(echo $recipe | jq '.title')
echo "[T] $title"

INGREDIENTS_LATEX="" # \ingredient{1 tbsp olive oil}
METHODS_LATEX="" # \method{Heat oil in a pan}

# Ingredient formatted like "2 cups of chickpeas (cooked, drained)"
for i in $(seq 1 $(echo $recipe | jq '.extendedIngredients | length')); do  
  # Get this ingredient's meta
  rawMeta="$(echo $recipe | jq -r ".extendedIngredients[$i-1].meta")"

  # loop through this ingredients "meta" array
  meta="("
  for j in $(seq 1 $(echo $rawMeta | jq '. | length')); do
    m=$(echo $rawMeta | jq -r ".[$j-1]")

    # If this is not the first meta, add a comma
    if [ $j -gt 1 ]; then
      meta="$meta, "
    fi

    # Append
    meta="$meta$m"
  done
  meta="$meta)"

  # Get this ingredient
  ingredient=$(echo $recipe | jq -r ".extendedIngredients[$i-1].amount, .extendedIngredients[$i-1].unit, .extendedIngredients[$i-1].name" | tr '\n' ' ')

  if [ "$meta" != "()" ]; then
    ingredient="$ingredient $meta"
  fi

  echo "[I] $ingredient"

  # Add to latex
  INGREDIENTS_LATEX="$INGREDIENTS_LATEX\n\\ingredient{$ingredient}"
done

# Extract instructions
for i in $(seq 1 $(echo $recipe | jq '.analyzedInstructions[0].steps | length')); do
  echo "[R] $(echo $recipe | jq -r ".analyzedInstructions[0].steps[$i-1].step")"

  # Add to latex
  METHODS_LATEX="$METHODS_LATEX\n\\method{$(echo $recipe | jq -r ".analyzedInstructions[0].steps[$i-1].step")}"
done

I_LATEX=$(echo -e "$INGREDIENTS_LATEX")
M_LATEX=$(echo -e "$METHODS_LATEX")

# Filter out any characters that will break latex
I_LATEX=$(echo "$I_LATEX" | sed -e 's/[^a-zA-Z0-9\.\,\(\)\{\}\-\_\n ]//g')
M_LATEX=$(echo "$M_LATEX" | sed -e 's/[^a-zA-Z0-9\.\,\(\)\{\}\-\_\n ]//g')

echo
echo "I_LATEX: $I_LATEX"
echo
echo "M_LATEX: $M_LATEX"
echo

# Escape the FIRST, LEADING  backslash per line, that's it
I_LATEX=$(echo "$I_LATEX" | sed -e 's/\\/\\\\/g')
M_LATEX=$(echo "$M_LATEX" | sed -e 's/\\/\\\\/g')

# Handle newlines
I_LATEX=$(echo "$I_LATEX" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\\n/g')
M_LATEX=$(echo "$M_LATEX" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\\n/g')


# Replace pointers
sed -i "s/$RECIPE_TITLE/$title/g" /output/template.tex
sed -i "s/$INGREDIENT_POINTER/$I_LATEX/g" /output/template.tex
sed -i "s/$METHOD_POINTER/$M_LATEX/g" /output/template.tex
