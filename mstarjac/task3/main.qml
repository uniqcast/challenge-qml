import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

Window
{
    visible: true
    width: 640
    height: 480
    title: qsTr("Task3")
    id: root
    color: "#000"

    Rectangle
    {
        width: parent.width; height: parent.height
        color: "#000"

        ListModel
        {
                id: listModel
            }

        GridView
        {
            id: movieList
            model: listModel
            anchors.fill: parent
            cellWidth: parent.width/5
            cellHeight: ( 2/3*parent.width/5 ) + 10
            focus: true
            delegate: Item
            {
                width: parent.width/5
                height: movieImg.height+movieTitle.contentHeight
                id:movieItem
                anchors.leftMargin: 5
                anchors.rightMargin: 5

                Image
                {
                    id: movieImg
                    anchors.horizontalCenter: listModel.horizontalCenter
                    source: "https://image.tmdb.org/t/p/w500" + backdrop
                    width: movieList.cellWidth - 5
                    height: 2/3 * movieList.cellWidth - movieDetails.height
                    fillMode: Image.PreserveAspectCrop
                    opacity: 0.5

                    Rectangle
                    {
                        width: parent.width
                        height: movieTitle.contentHeight
                        color: "#000"
                        anchors.bottom: parent.bottom

                        Text
                        {
                            id:movieTitle
                            text: title
                            color: movieItem.GridView.isCurrentItem ? "#efefef" : "#555"
                            width: parent.width
                            elide: Text.ElideRight
                            font.pixelSize: 16
                        }
                    }
                }
                Rectangle
                {
                    id: movieDetails
                    width: movieItem.width
                    height: movieRelease.contentHeight
                    color: "#000"
                    anchors.bottom: movieItem.bottom
                    y:0

                    Text
                    {
                        id:movieRelease
                        text: Qt.formatDate(release, "yyyy")
                        color: "#555"
                        anchors.right: parent.right
                        rightPadding: 5
                    }

                    Text
                    {
                        id:movieVote
                        text: vote_avrage
                        color: "#555"
                        anchors.left: parent.left
                    }
                }

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: parent.GridView.view.currentIndex = index
                }

                states:
                    [
                    State
                    {
                        name: "selected"
                        when: movieItem.GridView.isCurrentItem

                        PropertyChanges
                        {
                            target: movieImg
                            source: "https://image.tmdb.org/t/p/w500" + poster
                            opacity: 1
                        }
                    }
                ]
            }
        }

        function request()
        {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "https://api.themoviedb.org/4/list/1?format=json&nojsoncallback=1&tags=munich");
            xhr.setRequestHeader("Authorization", "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjBkOGVlMGQzODdiNjdhYTY0ZjAzZDllODM5MmViMyIsInN1YiI6IjU2MjlmNDBlYzNhMzY4MWI1ZTAwMTkxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UxgW0dUhS62m41KjqEf35RWfpw4ghCbnSmSq4bsB32o")
            xhr.send();

            xhr.onreadystatechange = function()
            {
                if(xhr.readyState === XMLHttpRequest.DONE)
                {
                    var json = JSON.parse( xhr.responseText )
                    for ( var i = 0; i < json.results.length; i++ ) {
                    var result = json.results[i];

                    listModel.append({"title": result.title,
                                      "poster": result.poster_path,
                                      "backdrop": result.backdrop_path,
                                      "release": result.release_date,
                                      "vote_avrage": result.vote_average});}
                }
            }
        }
        Component.onCompleted:
        {
            request()
        }
    }
}
