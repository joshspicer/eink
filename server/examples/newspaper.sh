#!/bin/bash

 curl -X PATCH \
    -d '{ \
      \"header1\": \"Recipe of the Day\", \
      \"header2\": \"Header 2\", \
      \"header3\": \"Header 3\", \
      \"data1\": \"Creamy Tortellini Soup. \\\  Heat olive oil in a large stockpot or Dutch oven over medium heat. Add Italian sausage and cook until browned, about 3-5 minutes, making sure to crumble the sausage as it cooks; drain excess fat.  Stir in garlic, onion and Italian seasoning. Cook, stirring frequently, until onions have become translucent, about 2-3 minutes; season with salt and pepper, to taste.  Whisk in flour until lightly browned, about 1 minute.  Gradually whisk in chicken stock and tomato sauce. Bring to a boil; reduce heat and simmer, stirring occasionally, until reduced and slightly thickened, about 10 minutes.  Stir in tortellini; cover and cook until tender, about 5-7 minutes. Stir in kale until wilted, about 1-2 minutes. Stir in heavy cream and basil until heated through, about 1 minute; season with salt and pepper, to taste.  Serve immediately.  \", \
      \"data2\": \"Hello this is some content within the second data section\", \
      \"data3\": \"Hello this is some content within the third data section\", \
      \"fontsize\": \"14\" \
      }' \
    http://localhost:3000/update?mode=newspaper
