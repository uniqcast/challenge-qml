### QML Task3

Visit [QmlBook](https://qmlbook.github.io).

Go through chapters 11 to 14 thoroughly.

Learn about [themoviedb](https://www.themoviedb.org) REST API structure on
https://developers.themoviedb.org/4/getting-started

In [task1](../task1) and [task2](../task2) you were working with static data.

This time, we will use REST API for creating your movies.

Use predefined movie list from https://api.themoviedb.org/4/list/1.

This is command line example for fetching movie data using [curl](https://curl.haxx.se):
```
curl -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjBkOGVlMGQzODdiNjdhYTY0ZjAzZDllODM5MmViMyIsInN1YiI6IjU2MjlmNDBlYzNhMzY4MWI1ZTAwMTkxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UxgW0dUhS62m41KjqEf35RWfpw4ghCbnSmSq4bsB32o' https://api.themoviedb.org/4/list/1
```

* show movies in a grid with 5 movies per row
* fetch movie data using JavaScript [XMLHttpRequest](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest)
* on application start, select first movie
* allow changing selected movie using mouse click, and keys left/right/up/down
* when movie is selected show poster image, for unselected, show backdrop image (for information on how to fetch image, see themoviedb API)
* make unselected movies 50% opaque
* stretch poster image to fill container dimensions
* at the bottom of the poster image show movie title with black background that fills witdh of the movie container, and wraps height of the text
* if movie title is too big, elide text on the right
* below image show year of release on the right and vote average on the left
