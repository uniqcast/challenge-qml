import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Window {
    id: root
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Task 3")
    color: "black"
    Component.onCompleted: fetchData()

    function fetchData(){
        var xhr = new XMLHttpRequest();
        var url = "https://api.themoviedb.org/4/list/1?format=json&nojsoncallback=1&tags=munich";

        xhr.open("GET", url);
        xhr.setRequestHeader('Authorization','Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjBkOGVlMGQzODdiNjdhYTY0ZjAzZDllODM5MmViMyIsInN1YiI6IjU2MjlmNDBlYzNhMzY4MWI1ZTAwMTkxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UxgW0dUhS62m41KjqEf35RWfpw4ghCbnSmSq4bsB32o')
        xhr.send();

        xhr.onreadystatechange = function(){
            if(xhr.readyState === XMLHttpRequest.DONE) {

                var json = JSON.parse(xhr.responseText)

                for (var i = 0; i < json.results.length; i++)
                {
                    var result = json.results[i];
                    gridModel.append({
                            "title" : result.title,
                            "poster" : result.poster_path,
                            "backdrop" : result.backdrop_path,
                            "release" : result.release_date,
                            "vote_avg" : result.vote_average
                            });
                }
            } // if
        } // function
    } // fetchData

    ListModel{
        id: gridModel
    }

    GridView{
        id: view
        anchors.margins: 5

        width: root.width
        height: root.height
        focus: true

        cellWidth: root.width / 5
        cellHeight: ( 2/3 * parent.width / 5 ) + 10
        model: gridModel

        delegate:
                Rectangle{
                    opacity: focus ? 1 : 0.5
                    color: root.color

                    width: root.width / 5
                    height: img.height + nameTxt.height

                    MouseArea {
                        anchors.fill: parent
                        onClicked: view.currentIndex = index
                    }

                    Image{
                        id: img
                        anchors.centerIn: parent
                        width: view.cellWidth - 5
                        height: 2/3 * view.cellHeight - nameTxt.height

                        source: parent.focus ? "https://image.tmdb.org/t/p/w500" + model.poster : "https://image.tmdb.org/t/p/w500" + model.backdrop
                        fillMode: Image.PreserveAspectCrop

                        Rectangle{
                            id: nameRect
                            width: parent.width
                            height: nameTxt.contentHeight
                            color: "#000"
                            anchors.bottom: parent.bottom
                            Text {
                                id: nameTxt
                                text: model.title
                                color: "white"
                                width: parent.width
                                elide: Text.ElideRight
                                font.pixelSize: 16
                            }
                        }
                    }
                    Rectangle{
                        width: img.width
                        height: releaseTxt.contentHeight
                        anchors.top: img.bottom
                        color: root.color
                        Text {
                            id: releaseTxt
                            text: model.release
                            color: "white"
                            anchors.right: parent.right
                            rightPadding: 5
                        }
                        Text {
                            id: avgTxt
                            text: model.vote_avg
                            color: "white"
                            anchors.left: parent.left
                        }
                    }
                    // name text
                } // Rectangle
    } // GridView
} // window
