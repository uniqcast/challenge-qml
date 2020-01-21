# Movie Browser: Dynamic Content

Visit [QmlBook](https://qmlbook.github.io). Go through chapters 5 and 6 thoroughly.

In [previous subtask](../subtask-1) you were supposed to create a simple application that contained 5 movie posters in a row.

This time, we will expand on that idea and support custom number of movies.

## Elements

* Save your movie data externally in one `xml` file so that they can be easily added or removed.
* Use `XmlListModel` to read and use your model data.
* Use `ListView` to render your movies in one row, list should be scrollable when there are more movies than it fits on screen.
* Show 3 movies at a time if there is less than 300 pixels available in container width, otherwise show 5.

Keep in mind to still support keyboard and mouse navigation. However, this time, select a movie when clicked, not when hovered.

Current movie selector should be scaling. You should also add behaviour animation when scaling.
