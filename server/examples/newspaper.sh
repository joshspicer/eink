#!/bin/bash

 curl -X PATCH \
    -d '{ \
      \"header1\": \"Recipe of the Day\", \
      \"header2\": \"Weather Report\", \
      \"header3\": \"Local News\", \
      \"data1\": \"Creamy Tortellini Soup. Heat olive oil in a large stockpot or Dutch oven over medium heat. Add Italian sausage and cook until browned, about 3-5 minutes, making sure to crumble the sausage as it cooks; drain excess fat.  Stir in garlic, onion and Italian seasoning. Cook, stirring frequently, until onions have become translucent, about 2-3 minutes; season with salt and pepper, to taste.  Whisk in flour until lightly browned, about 1 minute.  Gradually whisk in chicken stock and tomato sauce. Bring to a boil; reduce heat and simmer, stirring occasionally, until reduced and slightly thickened, about 10 minutes.  Stir in tortellini; cover and cook until tender, about 5-7 minutes. Stir in kale until wilted, about 1-2 minutes. Stir in heavy cream and basil until heated through, about 1 minute; season with salt and pepper, to taste.  Serve immediately.  \", \
      \"data2\": \"Today in Seattle, we are experiencing light showers with a high of 55 degrees and a low of 45 degrees. The humidity is at 80 percent. As the day progresses, expect the showers to clear up, giving way to cloudy skies in the afternoon. Winds are coming from the southwest at 10 miles per hour. Looking ahead, the forecast for the next few days shows a mix of sun and clouds with temperatures ranging from the mid-40s to low 60s. Remember to keep your umbrella handy! \", \
      \"data3\": \"In local news, the annual Seattle Art Fair is set to return next month, featuring works from over 100 local and international artists. The fair will also include a series of public programs such as artist talks, performances, and guided tours. Tickets are now available online.\", \
      \"fontsize\": \"14\" \
      }' \
    http://localhost:3000/update?mode=newspaper
