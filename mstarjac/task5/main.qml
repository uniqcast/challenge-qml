import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.2
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.6
import QtGraphicalEffects 1.0
import "ionicons.js" as Ionicons
import "progressCalc.js" as Timecalc

ApplicationWindow {
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Task5")
    id: appWrap
    visibility: "FullScreen"
    color: "#000"

    XmlListModel{
        id: xmlModel
        source: "channels.xml"
        query: "/channels/channel"
        XmlRole {name: "channelTitle"; query: "uid/string()" }
        XmlRole {name: "icon"; query: "icon/string()"}
        XmlRole {name: "start"; query: "start/string()"}
        XmlRole {name: "end";query: "end/string()"}
        XmlRole {name: "url";query: "url/string()"}
    }

    header: TopBar{}

    FontLoader { source: "fonts/ionicons.ttf"; id:loader }

    property bool expanded: false
    property bool muted: false
    property date date

    StackView {
        id: stack
        initialItem: gridlayout
        focus: true

        MouseArea{
            anchors.fill: gridlayout
            onClicked: {
                preventStealing: true
                playerButtons.visible = true
                fscreen.visible = true
                nowPlaying.visible = true
                muteButton.visible = true
                progressBar.visible = true
                buttonTimer.restart();
            }
        }

        Timer{
            id: buttonTimer
            interval: 5000
            onTriggered: {
                playerButtons.visible = false
                nowPlaying.visible = false
                fscreen.visible = false
                muteButton.visible = false
                progressBar.visible = false
            }
        }

        GridLayout{
            width: appWrap.width
            //40 is the height of topItemsBar
            height: appWrap.height- 40
            rowSpacing: 0
            columnSpacing: 0
            flow: width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom
            LayoutMirroring.enabled: true
            id: gridlayout
            states: [
                State {
                    name: "FULLSCREEN"
                    when: appWrap.expanded
                    PropertyChanges {
                        target: videoWrap
                        width: parent.width
                        height: parent.height
                    }
                    PropertyChanges {
                        target: listWrap
                        visible: false
                    }
                    PropertyChanges {
                        target: gridlayout
                        height: appWrap.height
                    }
                }
            ]

            Rectangle{
                id: videoWrap
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "#000"
                z: 1
                Rectangle{
                    id: video
                    width: parent.width
                    height: videoplayer.height
                    color: "#000"
                    anchors.centerIn: parent.Center
                    anchors.verticalCenter: parent.verticalCenter
                    MediaPlayer{
                        id: player
                        autoPlay: true
                    }

                    VideoOutput{
                        id: videoplayer
                        source: player
                        width: video.width
                        height: videoplayer.width*9/16
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: VideoOutput.PreserveAspectFit
                    }

                    Item{
                        anchors.horizontalCenter: video.horizontalCenter
                        anchors.verticalCenter: video.verticalCenter
                        id: playerButtons
                        Text {
                            id: replaybutton
                            font.pixelSize: video.height*0.1
                            color: "#FFF"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: ppbutton.left
                            rightPadding: video.width*0.15
                            text: Ionicons.img["reply"]
                            font.family: loader.name
                            MouseArea{
                                anchors.fill: parent
                                onClicked:{
                                    player.stop()
                                    player.seek(0)
                                    player.play()
                                }
                            }
                        }

                        Text {
                            id: ppbutton
                            font.pixelSize: video.height*0.1
                            color: "#FFF"
                            anchors.verticalCenter: parent.verticalCenter
                            text: player.playbackState == MediaPlayer.PlayingState ? Ionicons.img["pause"] : Ionicons.img["play"]
                            font.family: loader.name
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
                            id: stopButton
                            color: "#e9e9e9"
                            text: Ionicons.img["stop"]
                            font.family: loader.name
                            font.pixelSize: video.height*0.1
                            leftPadding: video.width*0.15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: ppbutton.right
                            visible: player.playbackState == MediaPlayer.StoppedState ? false : true
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(player.playbackState == MediaPlayer.PlayingState){
                                        player.stop()
                                        ppbutton.text = Ionicons.img["play"]
                                    }
                                }
                            }
                        }

                        Text {
                            id: bufferingIndicator
                            text: player.status == MediaPlayer.Buffered ? "":"Buffering..."
                            color: "#e9e9e9"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.top: ppbutton.bottom
                        }
                    }
                    Text {
                        id: nowPlaying
                        text: channelList.currentItem.playingTitle
                        color: "#FFF"
                        anchors.horizontalCenter: video.horizontalCenter
                        anchors.bottom: parent.bottom
                        font.pixelSize: video.height*0.1
                        bottomPadding: 30
                    }
                    Text {
                        anchors.right: video.right
                        anchors.top: video.top
                        id: fscreen
                        font.pixelSize: video.height*0.1
                        font.family: loader.name
                        text:  gridlayout.state == "FULLSCREEN" ? Ionicons.img['android-contract'] : Ionicons.img['arrow-expand']
                        topPadding: 15
                        rightPadding: 10
                        color: "#FFF"
                        MouseArea{
                            anchors.fill: parent
                            onClicked:{
                                appWrap.expanded = !appWrap.expanded
                            }
                        }
                    }
                    Text {
                        id: muteButton
                        color: "#e9e9e9"
                        text: appWrap.muted ? Ionicons.img["volume-mute"] : Ionicons.img["volume-medium"]
                        font.family: loader.name
                        font.pixelSize: video.height*0.1
                        leftPadding: 15
                        topPadding: 15
                        anchors.left: video.left
                        anchors.top: video.top
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {

                                appWrap.muted = !appWrap.muted
                                volumeSlider.value = appWrap.muted ? 0 : 0.5
                            }
                        }
                        Slider{
                            id: volumeSlider
                            width: 100
                            height: 5
                            from:0.0
                            to:1.0
                            value: 0.5
                            stepSize: 0.1
                            anchors.left: parent.left
                            anchors.top:muteButton.bottom
                            anchors.leftMargin: 5
                            background: Rectangle{
                                color: "white"
                                radius: 2
                            }
                            handle: Rectangle {
                                    x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height/1.5
                                    implicitWidth: volumeSlider.height*3
                                    implicitHeight: volumeSlider.height*3
                                    radius: 3
                                    color: volumeSlider.pressed ? "#f0f0f0" : "#f6f6f6"
                                    border.color: "#bdbebf"
                                }

                            onValueChanged: {
                                player.volume = value;
                                appWrap.muted = volumeSlider.value == 0 ? true : false
                            }
                        }
                    }
                    Rectangle {
                        id: progressBar
                        anchors.left: video.left
                        anchors.right: video.right
                        anchors.bottom: video.bottom
                        height: 5
                        anchors.leftMargin: 15
                        anchors.rightMargin: 15
                        color: "#909090"

                        Item {
                            width: 15
                            height: progressBar.height
                            anchors.left: rightArrowWrapp.right

                            LinearGradient {
                                anchors.fill: parent
                                start: Qt.point(0, 0)
                                end: Qt.point(10, 0)
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "#909090" }
                                    GradientStop { position: 1.0; color: "black"; }
                                }
                            }
                        }

                        Item {
                            id: rightArrowWrapp
                            clip: true
                            width: rightArrow.contentWidth/2
                            height: rightArrow.contentHeight
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -2.5
                            Text {
                                id: rightArrow
                                text: Ionicons.img["android-arrow-dropup"]
                                font.family: loader.name
                                color: "#909090"
                                font.pixelSize: 50
                            }
                        }
                        Item {
                            width: 15
                            height: progressBar.height
                            anchors.right: leftArrowWrapp.left

                            LinearGradient {
                                anchors.fill: parent
                                start: Qt.point(0, 0)
                                end: Qt.point(30, 0)
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "black" }
                                    GradientStop { position: 1.0; color: "#ff5a5e"; }
                                }
                            }
                        }

                        Item {
                            id: leftArrowWrapp
                            clip: true
                            width: leftArrow.contentWidth/2
                            height: leftArrow.contentHeight
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -2.5
                            Text {
                                id: leftArrow
                                text: Ionicons.img["android-arrow-dropup"]
                                font.family: loader.name
                                color: "#ff5a5e"
                                font.pixelSize: 50
                                anchors.right: leftArrowWrapp.right
                            }
                        }

                        ProgressBar{
                            from: Timecalc.getStart(channelList.currentItem.videostart)
                            to: Timecalc.getEnd(channelList.currentItem.videoend)
                            value: date.getTime()
                            width: progressBar.width
                            id:progress

                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom

                            background: Rectangle {
                                color: "#909090"
                            }

                            contentItem: Item {
                                implicitWidth: background.implicitWidth
                                implicitHeight: background.implicitHeight

                                Rectangle {
                                    width: progress.position*progress.width
                                    height: parent.height
                                    color: "#ff5a5e"
                                }
                            }


                            Text {
                                id: progressBarIndicator
                                color: "#ff5a5e"
                                anchors.horizontalCenter: progress.left
                                anchors.horizontalCenterOffset: progress.position*progress.width
                                anchors.verticalCenter: progress.verticalCenter
                                text: Ionicons.img["record"]
                                font.family: loader.name
                                font.pixelSize: progressBar.height*3

                            }
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                if (player.seekable) {
                                    player.position = player.duration * mouse.x/width;
                                }
                            }
                        }
                        Text {
                            id: startTime
                            text: channelList.currentItem.videostart
                            color: "#e9e9e9"
                            anchors.left: parent.left
                            anchors.bottom: parent.top
                            bottomPadding: 10
                            font.pointSize: 10
                        }
                        Text {
                            id: endTime
                            text: channelList.currentItem.videoend
                            color: "#e9e9e9"
                            anchors.right: parent.right
                            anchors.bottom: parent.top
                            bottomPadding: 10
                            font.pointSize: 10
                        }

                    }
                }

                Item {
                    width: video.width
                    height: 100
                    anchors.top: video.bottom
                    z:-5

                    LinearGradient {
                        anchors.fill: parent
                        start: Qt.point(0, 0)
                        end: Qt.point(0, 100)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "black" }
                            GradientStop { position: 1.0; color: "#00000000"; }
                        }
                    }
                }

            }

            Rectangle{
                id: listWrap
                Layout.fillHeight: true
                Layout.preferredWidth: gridlayout.width > gridlayout.height ? parent.width*0.35 : parent.width
                color: "#000"
                Rectangle{
                    id: listContent
                    width: parent.width
                    height: parent.height
                    color: "#000"
                    ListView{
                        width: parent.width
                        height: parent.height
                        id: channelList
                        model: xmlModel
                        focus: true
                        delegate: LlistDelegate {}
                        onCurrentItemChanged: {
                            player.stop();player.source = channelList.currentItem.videolink;ppbutton.text = Ionicons.img["pause"];playerButtons.visible = true
                            fscreen.visible = true; nowPlaying.visible = true; muteButton.visible = true;progressBar.visible = true;
                            buttonTimer.restart();
                        }
                    }
                }
            }
        }
        Component {
            id: searchView
            Rectangle{
                width: appWrap.width
                height: appWrap.height
            }
        }
    }
}



