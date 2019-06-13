import QtQuick 2.11
import QtQuick.Window 2.11
import QtMultimedia 5.9
import QtQuick.XmlListModel 2.0
import QtQuick.Controls 2.1

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 720
    title: qsTr("Task 4")
    color: "black"

    property bool isFullscreen: false

    Item{
        states: [
            State {
                name: "fullscreen"
                when: isFullscreen === true

                PropertyChanges{
                    target: channelRectangle
                    width: root.width
                    height: root.height
                }
            },
            State {
                name: "landscape"
                when: isFullscreen === false && (Screen.desktopAvailableHeight < Screen.desktopAvailableWidth)
                PropertyChanges {
                    target: channelRectangle
                    width: root.width - channelList.width
                    height: root.height
                }
                PropertyChanges{
                    target: channelList
                    anchors.top: channelRectangle.top

                    anchors.left: root.left
                    width: root.width / 3
                    height: root.height
                }
            },
            State {
                name: "portrait"
                when: isFullscreen === false && (Screen.desktopAvailableHeight > Screen.desktopAvailableWidth)
                PropertyChanges{
                    target: channelRectangle
                    height: root.height / 4
                    width: root.width

                }
                PropertyChanges{
                    target: channelList
                    anchors.top: channelRectangle.bottom
                    width: channelRectangle.width
                    height: root.height - channelRectangle.height
                }
            }
        ]
    } // item

    ListView{
        id: channelList
        model: xmlModel

        anchors.left: root.left
        width: root.width / 3
        height: root.height

        focus: true
        orientation: ListView.Vertical

        //onCurrentItemChanged: player.source = xmlModel.get(currentIndex).url

        delegate:
            Rectangle{
                width: parent.width
                height: root.height / 10

                property bool isCurrentItem: channelList.currentIndex === index

                onIsCurrentItemChanged: {
                    if (isCurrentItem)
                        player.source = model.url
                }

                color: "black"
                border.color: "white"

                Text {
                    text: model.uid
                    color: parent.focus ? "red" : "white"

                    anchors.centerIn: parent
                    font.pixelSize: ( root.height / 10 ) / 2
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: channelList.currentIndex = index
                }
            } // Rectangle
    } // ListView

    XmlListModel {
        id: xmlModel
        source: "qrc:/channels.xml"
        query: "/channels/channel"

        XmlRole { name: "uid"; query: "uid/string()" }
        XmlRole { name: "url"; query: "url/string()" }
    }

    Timer{
        id: buttonTimer
        interval: 5000
        onTriggered: {
            pausePlayButton.visible = false
            fullscreenButton.visible = false
        }
    }

    Rectangle {
        id: channelRectangle
        width: root.width - channelList.width
        height: root.height

        color: "gray"
        anchors.right: parent.right

        MouseArea{
            anchors.fill: parent
            onClicked: {
                pausePlayButton.visible = true
                fullscreenButton.visible = true
                buttonTimer.restart();
            }
        }

        MediaPlayer {
            id: player
            autoPlay: true
        }

        VideoOutput {
            id: videoOutput
            source: player
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }

        Image{
            id: pausePlayButton
            visible: false
            source: "/icons/_ionicons_svg_md-pause.svg"
            anchors.centerIn: videoOutput
            height: 100
            width: 100
            MouseArea{
                anchors.fill: parent
                onClicked: {
                        if(player.playbackState){
                            player.stop()
                            parent.source = "/icons/_ionicons_svg_md-play.svg"
                        }
                        else{
                            player.play()
                            parent.source = "/icons/_ionicons_svg_md-pause.svg"
                        }
                }
            }
        } // image Pause/Play

        Image {
            id: fullscreenButton
            visible: false
            source: "/icons/_ionicons_svg_md-expand.svg"
            anchors.bottom: videoOutput.bottom
            anchors.horizontalCenter: videoOutput.right
            anchors.horizontalCenterOffset: -(height/2)
            height: 100
            width: 100
            MouseArea{
                anchors.fill: parent
                onClicked: {
                   isFullscreen = !isFullscreen
                   if(isFullscreen){
                        parent.source = "/icons/_ionicons_svg_md-contract.svg"
                   }
                   else{
                        parent.source = "/icons/_ionicons_svg_md-expand.svg"
                   }
                }
            }
        } // Image fullscreen

    } // Rectangle

} // Window
