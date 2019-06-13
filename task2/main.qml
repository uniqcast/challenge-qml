import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.XmlListModel 2.0

Window {
    id: root
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Task 2")
    color: "#676767"

    XmlListModel{
        id: xmlModel
        source: "qrc:/movies.xml"
        query: "/rss/movies/item"

        XmlRole { name: "source"; query: "source/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "release"; query: "release/string()" }
        XmlRole { name: "rating"; query: "rating/string()" }
    } // XmlListModel

    ListView{
        id: lista
        model: xmlModel
        width: parent.width
        height: parent.height

        orientation: ListView.Horizontal
        spacing: 10
        leftMargin: 10
        rightMargin: 10
        focus: true

        delegate:

            Rectangle{
                id: imageRectangle
                width: root.width > 300 ? root.width / 5 : root.width / 3
                height: root.height / 1.5

                color: "#676767"
                anchors.verticalCenter: parent.verticalCenter

                ScaleAnimator {
                        target: imageRectangle;
                        from: 1;
                        to: 1.02;
                        duration: 500
                        running: index === lista.currentIndex
                }

                ScaleAnimator {
                        target: imageRectangle;
                        from: 1.02;
                        to: 1;
                        duration: 500
                        running: imageRectangle.scale === 1.02 && index != lista.currentIndex
                }

                Column{
                    id: movie
                    width: parent.width
                    height: parent.height

                    Image {
                        id: movieImg
                        source: model.source;
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit 
                    }
                    Text {
                        color: "white"
                        text: "Name: " + model.name + "\nYear: " + model.release + "\nRating: " + model.rating
                        font.pointSize: 12
                        width: parent.height
                        anchors.top: movieImg.bottom
                    }
                    MouseArea{
                        width: parent.width
                        height: parent.height
                        onClicked: {
                            lista.currentIndex = index
                        }
                    }
                } // column
        } // Rectangle
    } // listview
} // window

