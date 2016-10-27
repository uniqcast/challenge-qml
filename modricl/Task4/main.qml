import QtQuick 2.7
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.5
import "ionicons.js" as Ionicons

ApplicationWindow {
    id: root
    visible: true
    height: Screen.height
    width: Screen.width
    visibility: "FullScreen"
    color: "#171717"

    FontLoader { id: ioniconsFont; source: "ionicons.ttf" }

    property bool buttonVisible: true

    Timer {
        id: buttonTimer
        interval: 5000
        onTriggered: {
            buttonVisible = false
        }
    }

    Rectangle {
        id: channelList

        ListView {
            id: channelListView
            anchors.fill: parent
            model: xmlModel
            boundsBehavior: Flickable.StopAtBounds
            delegate: ChannelItem {}
            orientation: ListView.Vertical
            focus: true
            highlightMoveVelocity: 1000
            highlightMoveDuration: 100
            cacheBuffer: 3
            onCurrentItemChanged: {
                mediaplayer.source = channelListView.currentItem.channelUrl
                buttonVisible = true
                buttonTimer.restart()
            }
        }
    }

    Rectangle {
        id: videoArea
        color: "#292929"

        property bool expanded: false

        MediaPlayer {
            id: mediaplayer
            autoPlay: true
        }

        VideoOutput {
            id: videoOutput
            anchors.fill: parent
            source: mediaplayer
            fillMode: VideoOutput.PreserveAspectFit
        }

        Button {
            id: triggerButton
            visible: buttonVisible
            anchors.centerIn: parent
            z: 1
            style: ButtonStyle {
                label: Text {
                    color: "#ffffff"
                    font.family: "Ionicons"
                    text: mediaplayer.playbackState == 1 ? Ionicons.img['pause'] : Ionicons.img['play']
                    font.pointSize: 30
                    style: Text.Outline
                    styleColor: "black"
                }
                background: Item {}
            }

            MouseArea {
                preventStealing: true
                anchors.fill: parent
                onClicked: mediaplayer.playbackState == MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()
            }
        }

        Button {
            id: expandButton
            visible: buttonVisible
            anchors.bottom: videoArea.bottom
            anchors.bottomMargin: videoArea.height * 0.05
            anchors.right: videoArea.right
            anchors.rightMargin: videoArea.height * 0.05
            z: 1
            style: ButtonStyle {
                label: Text {
                    color: "#ffffff"
                    font.family: "Ionicons"
                    text: videoArea.expanded == true ? Ionicons.img['arrow-shrink'] : Ionicons.img['arrow-expand']
                    font.pointSize: 30
                    style: Text.Outline
                    styleColor: "black"
                }
                background: Item {}
            }

            MouseArea {
                preventStealing: true
                anchors.fill: parent
                onClicked: {
                    videoArea.expanded = !videoArea.expanded
                }
            }
        }

        states: [
            State {
                name: "expanded"; when: videoArea.expanded
                PropertyChanges { target: videoArea; width: root.width; height: root.height; anchors.centerIn: parent }
            },
            State {
                name: "landscape"; when: (root.width > root.height)
                PropertyChanges { target: channelList; width: parent.width  * 0.35; height: parent.height; anchors.left: parent.left; anchors.top: parent.top }
                PropertyChanges { target: videoArea; width: parent.width * 0.65; height: parent.height; anchors.right: parent.right; anchors.top: parent.top }
            },
            State {
                name: "portrait"; when: (root.width < root.height)
                PropertyChanges { target: channelList; width: parent.width; height: parent.height; anchors.left: parent.left; anchors.top: videoArea.bottom }
                PropertyChanges { target: videoArea; width: parent.width; height: (parent.width / 16) * 9; anchors.right: parent.right; anchors.top: parent.top }
            }
        ]

        MouseArea {
            preventStealing: true
            anchors.fill: parent
            onClicked: {
                buttonVisible = true
                buttonTimer.restart()
            }
        }
    }

    XmlListModel {
        id: xmlModel
        source: "channels.xml"
        query: "/channels/channel"

        XmlRole { name: "uid"; query: "uid/string()" }
        XmlRole { name: "url"; query: "url/string()" }
    }
}
