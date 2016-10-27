
[Font Awesome](http://fontawesome.io/) for QML

## How to use
Download "awesome.js" and "fonts/fontawesome.ttf".  
Place them inside your project folder.  
After that you need to include the awesome.js.  
To do that, add:
```QML
import "awesome.js" as Awesome
```
Next add FontLoader: 
```QML
    FontLoader {
        id: loader
        source: "fonts/fontawesome.ttf"
    }
```
Now to use the font you simply write it like this:
```QML
    Text {
        text: Awesome.awesome["fa-thumbs-up"]
        color: "black"
        font.family: loader.name
    }
```
NOTE: ```font.family``` has to be specified, in this case we use the font name from the FontLoader.  
```fa-thumbs-up``` will show the Thumbs up icon, for full list visit [Font Awesome Icons](http://fontawesome.io/icons/). Some of the values are removed from the ```awesome.js``` as they display the same icon (for example fa-photo,fa-image,fa-picture-o, only ```fa-image``` is available in the ```awesome.js```)  

For more info check the project

### Version
Font Awesome 4.7   
QT 5.7
