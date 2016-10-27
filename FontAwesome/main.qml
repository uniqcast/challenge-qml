import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.XmlListModel 2.0
import "awesome.js" as Awesome

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Font Awesome")
    id: appWrap

    FontLoader {
        id: loader
        source: "fonts/fontawesome.ttf"
    }

    XmlListModel{
        id: awesomeModel
        source: "list.xml"
        query: "/fontawesome/item"
        XmlRole {name: "value";query: "value/string()"}
    }

    Rectangle{
        id: mainView
        color: "white"
        width: parent.width
        height: parent.height

        GridView{
            anchors.fill: parent
            cellHeight: 70
            cellWidth:  150
            model: awesomeModel
            focus: true
            delegate: Item {
                height: parent.height
                width: 150

                Text {
                    id: awesome
                    text: loader.status == FontLoader.Ready ? Awesome.awesome[value] : 'Not loaded'
                    color: "black"
                    font.pixelSize: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: loader.name
                }

                Rectangle{
                    id: valueBackground
                    height: 20
                    width: 150
                    anchors.top: awesome.bottom
                    Text {
                        id: awesomeValue
                        text: loader.status == FontLoader.Ready ? value : 'Not loaded'
                        color: "#000"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
