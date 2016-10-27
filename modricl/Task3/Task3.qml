import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0

Window {
    id: root
    visible: true
    height: Screen.height
    width: Screen.width
    visibility: "FullScreen"
    color: "#171717"
    Component.onCompleted: {
        getData();
    }

    ListModel { id: listModelJson }

    GridView {
        id: movieGridView
        anchors.fill: parent
        cellWidth: (root.width / (root.width > 300 ? 5 : 3))
        cellHeight: movieGridView.cellWidth
        focus: true
        model: listModelJson
        interactive: true
        delegate: MovieItem {}
        highlight: Component {
            SelectedItem {}
        }
    }

    function getData() {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.themoviedb.org/4/list/1";
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
                dataHandler(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.setRequestHeader("Authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjBkOGVlMGQzODdiNjdhYTY0ZjAzZDllODM5MmViMyIsInN1YiI6IjU2MjlmNDBlYzNhMzY4MWI1ZTAwMTkxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UxgW0dUhS62m41KjqEf35RWfpw4ghCbnSmSq4bsB32o");
        xmlhttp.send();
    }

    function dataHandler(response) {
        var arr = JSON.parse(response);
        for(var i = 0; i < arr.results.length; i++) {
            listModelJson.append( {"poster_path" : arr.results[i].poster_path,
                                     "backdrop_path" : arr.results[i].backdrop_path,
                                     "original_title" : arr.results[i].original_title,
                                     "vote_average" : arr.results[i].vote_average,
                                     "release_date" : arr.results[i].release_date
                                 })
        }
    }
}

