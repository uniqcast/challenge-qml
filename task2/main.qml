import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.XmlListModel 2.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("task2")
    color: "#000"
    id:root

    XmlListModel{
    id: testmodel
    source: "movieList.xml"
    query: "/rss/channel/item"
    XmlRole {name: "imageUrl"; query: "imageUrl/string()"}
    XmlRole {name: "name"; query: "name/string()"}
    XmlRole {name: "release"; query: "release/string()"}
    XmlRole {name: "rating"; query: "rating/string()"}
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
                id:wrapper
                width: movie.width
                height: movie.height
                color: "#000"
                states: [
                    State {
                        name: "smallSelected"
                        when: (wrapper.ListView.isCurrentItem && root.width<=300)
                        PropertyChanges {
                            target: movieRating
                            opacity: 100
                        }
                        PropertyChanges {
                            target: wrapper
                            color: "#222"
                        }
                        PropertyChanges {
                            target: movie
                            width: root.width/3
                        }
                        PropertyChanges{
                            target: movieImg
                            width: root.width/3
                            scale: 1
                        }
                        PropertyChanges{
                            target: container
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                        }
                    },
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
                    },
                    State {
                        name: "small"
                        when: root.width<=300
                        PropertyChanges {
                            target: movie
                            width: root.width/3
                        }
                        PropertyChanges{
                            target: movieImg
                            width: root.width/3
                        }
                        PropertyChanges{
                            target: container
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                        }
                    }
                ]
                transitions:[
                    Transition {
                        to: "selected"
                        PropertyAnimation{properties: "scale"; easing.type: Easing.InElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                        PropertyAnimation{properties: "color"; easing.type: Easing.InElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                    },
                    Transition {
                        from: "selected"
                        PropertyAnimation{properties: "scale"; easing.type: Easing.OutElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                    },
                    Transition {
                        to: "small"
                        PropertyAnimation{properties: "width"; easing.type: Easing.InElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                    },
                    Transition {
                        from: "small"
                        PropertyAnimation{properties: "width"; easing.type: Easing.OutElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                    },
                    Transition {
                        to: "smallSelected"
                        PropertyAnimation{properties: "width"; easing.type: Easing.InElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                    },
                    Transition {
                        from: "smallSelected"
                        to: "selected"
                        PropertyAnimation{properties: "width"; easing.type: Easing.OutElastic; easing.amplitude: 2.0; easing.period: 2.5 }
                    }
                ]
                Item{
                    id: movieItem
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
                onClicked: {movieList.currentIndex = index }
                }
            }
        }

        orientation: ListView.Horizontal
        model: testmodel
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height/4
        delegate: movieDeligate
        focus: true
        spacing: 2
    }

}
}
