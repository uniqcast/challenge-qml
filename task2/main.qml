import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0

/*
brzina skrolanja
*/

Window {
    id: root
    visible: true
    height: 500
    width: 1000
    minimumHeight: 400
    minimumWidth: 250




    title: qsTr("Task 2")
    color: "#000"

    Rectangle {
        id: frame
        color: "#333333"
        anchors.centerIn: parent
        height: 330
        width: root.width - 40

        ListView {
            id: view
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5
            orientation: ListView.Horizontal
            clip: true
            focus: true
            boundsBehavior: Flickable.DragOverBounds
            highlightMoveDuration: 200
            model: movieXml
            delegate: movieDelegate
        }

        XmlListModel {
            id: movieXml
            source: "qrc:///movieModel.xml"
            query: "/movieModel/movie"
            XmlRole {name: "name"; query: "name/string()"}
            XmlRole {name: "year"; query: "year/string()"}
            XmlRole {name: "rating"; query: "rating/string()"}
            XmlRole {name: "image"; query: "image/string()"}
        }

        Component {
            id: movieDelegate

            Column {
                id: column
                spacing: 2
                width: frame.width<300 ? frame.width/3 : frame.width/5
                height: ListView.view.height

                Image {
                    scale: column.focus ? 0.9 : 1
                    Behavior on scale {NumberAnimation{duration: 100}}
                    antialiasing: true
                    source: image
                    width: column.width
                    height: column.height - 55
                    fillMode: Image.PreserveAspectFit
                    MouseArea {
                        anchors.fill: parent
                        onClicked: view.currentIndex = index
                    }
                }
                Text {
                    width: parent.width
                    height: column.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: name + " (" + year + ")"
                }
                Text {
                    anchors.horizontalCenter: column.horizontalCenter
                    visible: column.focus ? true : false
                    color: "white"
                    text: rating
                }
            }
        }
    }
}
