# Movie Browser: REST API

Visit [QmlBook](https://qmlbook.github.io). Go through chapters 11 to 14 thoroughly.

Learn about [themoviedb](https://www.themoviedb.org) REST API structure on https://developers.themoviedb.org/4/getting-started.

In [subtask 1](../subtask-1) and [subtask 2](../subtask-2) you were working with static data.

This time, we will use REST API for creating your movies.

## Elements

* Use predefined movie list from https://api.themoviedb.org/4/list/1.
    * Command line example for fetching movie data using [curl](https://curl.haxx.se):
    ```curl -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjBkOGVlMGQzODdiNjdhYTY0ZjAzZDllODM5MmViMyIsInN1YiI6IjU2MjlmNDBlYzNhMzY4MWI1ZTAwMTkxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UxgW0dUhS62m41KjqEf35RWfpw4ghCbnSmSq4bsB32o' https://api.themoviedb.org/4/list/1```
* Show movies in a grid with 5 movies per row.
* Fetch movie data using JavaScript [XMLHttpRequest](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest).
* On application start, select first movie.
* Allow changing selected movie using mouse click, and keys left/right/up/down.
* When movie is selected show poster image, for unselected, show backdrop image (for information on how to fetch image, see themoviedb API).
* Make unselected movies 50% opaque.
* Stretch poster image to fill container dimensions.
* At the bottom of the poster image show movie title with black background that fills witdh of the movie container, and wraps height of the text.
* If movie title is too big, elide text on the right.
* Below image show year of release on the right and vote average on the left.
