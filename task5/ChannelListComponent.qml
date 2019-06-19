import QtQuick 2.11
import "progressBarTimes.js" as GetTime

Rectangle {
    id: lista
    color: "black"

    property var cijeliObjekt: xmlModel.get(listViewID.currentIndex)

    ListView {
        id: listViewID
        focus: true

        width: parent.width
        height: parent.height

        model: xmlModel
        orientation: ListView.Vertical

        delegate:
            Rectangle {
                id: channelOption
                color: "transparent"

                width: lista.width
                height: root.height / 10

                MouseArea {
                    anchors.fill: parent
                    onClicked: listViewID.currentIndex = index
                }

                // border
                Rectangle {
                    color: "transparent"
                    anchors.fill: parent
                    z: 99

                    border.color: channelOption.focus ? "white" : "gray"
                    border.width: channelOption.focus ? 3 : 1
                }

                // Channel name
                Rectangle {
                    id: channelName
                    color: "black"

                    width: lista.width - ( 1 / 5 * lista.width )
                    height: root.height / 10
                    anchors.right: parent.right

                    Text {
                        text: model.uid
                        color: channelOption.focus ? "red" : "white"
                        font.pixelSize: 24

                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        anchors.verticalCenterOffset: -5
                        anchors.margins: 10

                        Text {
                            anchors.top: parent.bottom
                            text: model.start + " - " + model.end

                            font.pixelSize: 16
                            color: "gray"
                        }
                    }

                    Image {
                        source: "/icons/_ionicons_svg_md-arrow-dropright.png"
                        fillMode: Image.PreserveAspectFit

                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        width: parent.height / 2.5
                        height: parent.height / 2.5
                    }
                }

                // Channel icon
                Rectangle {
                    id: channelIcon
                    color: "black"

                    height: root.height / 10
                    width: lista.width - channelName.width

                    anchors.left: parent.left
                    border.color: "gray"
                    border.width: 1

                    Image {
                        width: parent.width * 0.8
                        height: parent.height * 0.8

                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectFit
                        source: model.icon
                    }
                }
            }
    } // ListView
} // lista rectangle
