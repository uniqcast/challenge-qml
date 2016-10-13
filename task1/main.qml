import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("task1")
    color: "#000"

    ListModel {
            id: testmodel
            ListElement {
                imageUrl: "images/image1.jpg"
                name: "Frozen"
                release: "2013"
                rating: "8/10"
            }
            ListElement {
                imageUrl: "images/image2.jpg"
                name: "Iron Man 3"
                release: "2013"
                rating: "8.4/10"
            }
            ListElement {
                imageUrl: "images/image3.jpg"
                name: "War Horse"
                release: "2011"
                rating: "7/10"
            }
            ListElement {
                imageUrl: "images/image4.jpg"
                name: "Guardians of the galaxy"
                release: "2014"
                rating: "8/10"
            }
            ListElement {
                imageUrl: "images/image5.jpg"
                name: "Thor The Dark World"
                release: "2013"
                rating: "9.1/10"
            }
        }

Rectangle{
    id:container
    width: parent.width; height: parent.height
    color: "black"
    anchors.fill: parent
    anchors.leftMargin: 40
    anchors.rightMargin: 40
    ListView{
        id: movieList
        width: parent.width

        Component{
            id: movieDeligate
            Rectangle{
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: movie.height
                id:wrapper
                width: movie.width
                height: movie.height
                color: "#000"
                states: [
                    State {
                        name: "selected"
                        when: wrapper.ListView.isCurrentItem
                        PropertyChanges {
                            target: movieImg
                            scale: 1
                        }
                        PropertyChanges {
                            target: movieRating
                            opacity: 100
                        }
                        PropertyChanges {
                            target: wrapper
                            color: "#222"
                        }
                    }
                ]
                transitions:
                    Transition {
                    to: "selected"
                    PropertyAnimation{properties: "scale"; easing.type: Easing.InOutElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                    PropertyAnimation{properties: "color"; easing.type: Easing.InOutElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                }

                Item{
                    width: container.width/5; height: container.height
                    Column {
                        id: movie
                        width: container.width/5
                        Image {id: movieImg;source: imageUrl; width: container.width/5; fillMode: Image.PreserveAspectFit; scale: 0.9}
                        Text {color: "#555"; text: '<b>Name:</b> ' + name; width: parent.width; elide: Text.ElideRight}
                        Text {color: "#555"; text: '<b>Release year: </b>' + release; width: parent.width; elide: Text.ElideRight }
                        Text {id:movieRating; opacity: 0; color: "#555"; text: '<b>Rating:</b> ' + rating; width: parent.width; elide: Text.ElideRight}
                    }
                }

                MouseArea{
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {movieList.currentIndex = index }
                }
            }
        }

        orientation: ListView.Horizontal
        model: testmodel
        delegate: movieDeligate
        focus: true
        spacing: 2
    }
}
}
