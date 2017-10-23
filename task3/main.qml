import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0

Window {
    id: root
    visible: true
    title: qsTr("Task 3")
    color: "#000"
    visibility: Window.Maximized

    Rectangle {
        id: frame
        color: "#333333"
        anchors.fill: parent

        GridView {
            id: view
            cellWidth: view.width/5
            cellHeight: cellWidth*1.4
            anchors.fill: parent
            anchors.margins: 10
            clip: true
            focus: true
            boundsBehavior: Flickable.DragOverBounds
            highlightMoveDuration: 200
            model: movieModel
            delegate: Rectangle {

                id: selected
                width: view.cellWidth
                height: view.cellHeight
                color: '#000'
                Image {
                    opacity: selected.focus ? 1 : 0.5
                    Behavior on opacity {NumberAnimation{duration: 300}}
                    antialiasing: true
                    source: selected.focus ? "https://image.tmdb.org/t/p/w300" + modelData.poster_path : "https://image.tmdb.org/t/p/w600" + modelData.backdrop_path
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop

                    MouseArea {
                        anchors.fill: parent
                        onClicked: view.currentIndex = index
                    }

                    Rectangle {
                        //visible: selected.focus ? true : false
                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 70
                        color: '#000'
                        opacity: selected.focus ? 0.8 : 0.6

                        Text {
                            id: title
                            anchors.top: parent.top
                            anchors.topMargin: 5
                            width: parent.width
                            elide: Text.ElideRight
                            font {
                              pixelSize: 20
                              bold:true
                            }
                            horizontalAlignment: Text.AlignHCenter
                            color: "white"
                            text: modelData.title
                        }
                        Text {
                            elide: Text.ElideRight
                            width: parent.width/3
                            anchors {
                                top: title.bottom
                                topMargin: 10
                                left: parent.left
                                leftMargin: 10
                            }
                            color: "white"
                            text: 'Rating: ' + modelData.vote_average + '/10'
                        }
                        Text {
                            elide: Text.ElideRight
                            width: parent.width/2.1
                            anchors {
                                top: title.bottom
                                topMargin: 10
                                right: parent.right
                                rightMargin: 10
                            }
                            color: "white"
                            text: 'Release date: ' + modelData.release_date
                        }
                    }
                }
            }
        }

        ListModel {
            id: movieModel
        }

        Component.onCompleted: {
            request()
        }

        function request () {
            var xhr = new XMLHttpRequest()
            var url = "https://api.themoviedb.org/4/list/1"
            xhr.open("GET", url, true)

            xhr.setRequestHeader('Authorization', 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YjBkOGVlMGQzODdiNjdhYTY0ZjAzZDllODM5MmViMyIsInN1YiI6IjU2MjlmNDBlYzNhMzY4MWI1ZTAwMTkxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UxgW0dUhS62m41KjqEf35RWfpw4ghCbnSmSq4bsB32o');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                    print('HEADERS_RECEIVED')
                } else if (xhr.readyState === XMLHttpRequest.DONE) {
                    var json = JSON.parse(xhr.responseText.toString())
                    view.model = json.results
                    print(JSON.stringify(json.results))
                }
            }
            xhr.send()
        }
    }
}

