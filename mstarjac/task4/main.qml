import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "ionicons.js" as Ionicons

ApplicationWindow {
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Task4")
    id: mainWindow
    color: "#000"
    visibility: "FullScreen"

    XmlListModel{
        id: listModel
        source: "channels.xml"
        query: "/channels/channel"
        XmlRole {name: "name"; query: "uid/string()" }
        XmlRole {name: "url"; query: "url/string()"}
    }
    Rectangle{
        color: "#000"

        FontLoader { source: "fonts/ionicons.ttf" }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                preventStealing: true
                ppbutton.visible = true
                fscreen.visible = true
                buttonTimer.restart();
            }
        }
        Timer{
            id: buttonTimer
            interval: 5000
            onTriggered: {
                ppbutton.visible = false
                fscreen.visible = false
            }
        }

        property bool expanded: false
        id: root
        width: mainWindow.width
        height: mainWindow.height
        state: "NORMAL"
        states: [

            State {
                name: "FULLSCREEN"
                when: root.expanded
                ParentChange{target: videoContainer; parent: fullScreen}
                PropertyChanges {
                    target: fullScreen
                    visible: true
                }
                PropertyChanges {
                    target: listContainer
                    visible: false
                }
            },
            State {
                name: "portrait"; when: (Screen.width < Screen.height)
                PropertyChanges { target: listContainer; width: parent.width; height: 500; anchors.top: videoWrap.bottom }
                PropertyChanges { target: videoWrap; width: parent.width; height: (parent.width / 16) * 9; anchors.right: root.right; anchors.top: root.top}
            },
            State {
                name: "landscape"; when: (Screen.width > Screen.height)
                PropertyChanges { target: listContainer; width: root.width/3; height: parent.height; anchors.left: parent.left; anchors.top: parent.top }
                PropertyChanges { target: videoWrap; width: root.width-listContainer.width; height: parent.height; anchors.right: parent.right; anchors.top: parent.top}
            }
        ]

        Component{
            id:listDelegate
            Item{
                property string videolink: url
                height: channelName.contentHeight+20
                width: listContainer.width
                id: listItem
                Rectangle{
                    height: channelName.contentHeight+20
                    width: listContainer.width
                    color: "#000"
                    Text {
                        id: channelName
                        text: name
                        color: listItem.ListView.isCurrentItem ? "red" : "white"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 16
                    }
                    Rectangle{
                        color: "white"
                        width: parent.width
                        height: 1
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: channelList.currentIndex = index
                    }
                }
            }
        }
        Rectangle{
            id: listContainer
            width: root.width/3
            height: root.height
            anchors.left: root.left
            anchors.top: root.top
            color: "#000"

            ListView{
                width: parent.width
                height: parent.height
                id: channelList
                model: listModel
                delegate: listDelegate
                focus: true
                onCurrentItemChanged: {
                    player.stop();player.source = channelList.currentItem.videolink;ppbutton.text = Ionicons.img["pause"];ppbutton.visible = true
                    fscreen.visible = true
                    buttonTimer.restart();
                }
            }
        }

        Rectangle{
            width: root.width-listContainer.width
            height: videoplayer.height
            anchors.right: root.right
            anchors.top: root.top
            color: "#000"
            id: videoWrap
            Item{
                id: videoContainer
                width: parent.width
                height: parent.height
                anchors.centerIn: parent.Center
                anchors.fill: parent
                MediaPlayer{
                    id: player
                    autoPlay: true
                }

                VideoOutput{
                    id: videoplayer
                    source: player
                    width: parent.width
                    height: videoplayer.width*9/16
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: VideoOutput.PreserveAspectFit
                }

                Text {
                    anchors.horizontalCenter: videoplayer.horizontalCenter
                    anchors.verticalCenter: videoplayer.verticalCenter
                    id: ppbutton
                    font.family: "Ionicons"
                    font.pointSize: 20
                    color: "#FFF"
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{if(player.playbackState == MediaPlayer.PlayingState){
                                player.pause()
                                ppbutton.text = Ionicons.img["play"]
                            }
                            else{
                                player.play()
                                ppbutton.text = Ionicons.img["pause"]
                            }
                        }
                    }
                }
                Text {
                    anchors.right: videoplayer.right
                    anchors.bottom: videoplayer.bottom
                    id: fscreen
                    font.family: "Ionicons"
                    font.pointSize: 20
                    text:  root.state == "FULLSCREEN" ? Ionicons.img['arrow-shrink'] : Ionicons.img['arrow-expand']
                    color: "#FFF"
                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            root.expanded = !root.expanded
                        }
                    }
                }
            }
        }
    }
    Item{
        id:fullScreen
        width: mainWindow.width
        height: mainWindow.height
        visible: false
    }
}
