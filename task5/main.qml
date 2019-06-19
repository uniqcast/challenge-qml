import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.0
import QtQuick.XmlListModel 2.0
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import "progressBarTimes.js" as GetTime

ApplicationWindow {
    id: root
    visible: true

    width: 1920
    height: 1080

    title: qsTr("Task 5")
    color: "black"

    property bool isFullscreen: false
    property var cijeliObjekt: lista.cijeliObjekt

    XmlListModel {
        id: xmlModel
        source: "qrc:/channels.xml"
        query: "/channels/channel"

        XmlRole { name: "uid"; query: "uid/string()" }
        XmlRole { name: "icon"; query: "icon/string()" }
        XmlRole { name: "start"; query: "start/string()" }
        XmlRole { name: "end"; query: "end/string()" }
        XmlRole { name: "url"; query: "url/string()" }
    }

    // ToolBar
    header: ToolBarComponent { id: toolBarID }

    // States
    Item {
        states: [
            State {
                name: "portrait"
                when: height > width && isFullscreen === false
                PropertyChanges {
                    target: lista
                    Layout.row: 1
                    Layout.preferredHeight: root.height * ( 2 / 3 ) - root.header.height
                    Layout.preferredWidth: root.width
                }
                PropertyChanges {
                    target: videoRectangle
                    Layout.row: 0
                    Layout.preferredHeight: ( root.height / 3 ) - root.header.height
                    Layout.preferredWidth: root.width
                }
            },
            State {
                name: "landscape"
                when: width > height && isFullscreen === false
                PropertyChanges {
                    target: lista
                    Layout.column: 0
                    Layout.preferredHeight: root.height - root.header.height
                    Layout.preferredWidth: root.width / 3
                }
                PropertyChanges {
                    target: videoRectangle
                    Layout.column: 1
                    Layout.preferredHeight: root.height - root.header.height
                    Layout.preferredWidth: root.width * ( 2 / 3 )
                }
            },
            State {
                name: "fullscreen"
                when: isFullscreen
                PropertyChanges {
                    target: videoRectangle
                    width: root.width
                    height: root.height
                }
                PropertyChanges {
                    target: toolBarID
                    visible: false
                }
            }
        ]
    }

    GridLayout {
        anchors.fill: parent
        flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom

        ChannelListComponent {id: lista}
        VideoPlayerComponent {
            id: videoRectangle
            cijeliObjekt: root.cijeliObjekt
        }

    }   // gridLayout

} // appWindow
