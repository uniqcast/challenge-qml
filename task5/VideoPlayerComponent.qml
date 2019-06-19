import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import "progressBarTimes.js" as GetTime
import QtQuick.Shapes 1.12
import QtGraphicalEffects 1.0

Rectangle {
    id: videoRectangle
    color: "gray"

    Layout.fillWidth: true
    Layout.fillHeight: true

    property var cijeliObjekt
    property var currentTime: GetTime.getTime(Qt.formatTime(new Date(), "hh:mm"));

    onCijeliObjektChanged: {
        channelInfoID.text = cijeliObjekt.uid
        player.source = cijeliObjekt.url

        startText.text = cijeliObjekt.start
        endText.text = cijeliObjekt.end

        progressBarID.from = GetTime.getTime(cijeliObjekt.start)
        progressBarID.to = GetTime.getTime(cijeliObjekt.end)
        progressBarID.value = currentTime
    }

    // Timer for button visibility
    Timer {
        id: buttonTimer
        interval: 5000
        onTriggered: {
            pausePlayButton.visible = false
            fullscreenButton.visible = false

            restartButton.visible = false
            stopButton.visible = false
            channelInfoID.visible = false
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            progressBarID.from = GetTime.getTime(cijeliObjekt.start)
            progressBarID.to = GetTime.getTime(cijeliObjekt.end)
            progressBarID.value = currentTime

            pausePlayButton.visible = true
            fullscreenButton.visible = true
            restartButton.visible = true

            stopButton.visible = player.playbackState ? true : false
            channelInfoID.visible = true
            buttonTimer.restart();
        }
    }

    // ProgressBar start time text
    Text {
        id: startText
        color: "white"

        anchors.left: progressRectangle.left
        anchors.bottom: progressRectangle.bottom

        bottomPadding: 30
        leftPadding: 10
        z: 99
    }

    // ProgressBar end time text
    Text {
        id: endText
        color: "white"

        anchors.right: progressRectangle.right
        anchors.bottom: progressRectangle.bottom

        bottomPadding: 30
        rightPadding: 10
        z: 99
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

    // Left gradient
    Item {
        anchors.left: parent.left
        anchors.right: progressRectangle.left
        anchors.verticalCenter: progressRectangle.verticalCenter

        height: progressRectangle.height
        width: 15

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(20, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "black" }
                GradientStop { position: 1.0; color: "red" }
            }
        }
    }

    // Right gradient
    Item {
        anchors.right: parent.right
        anchors.left: progressRectangle.right
        anchors.verticalCenter: progressRectangle.verticalCenter

        height: progressRectangle.height
        width: 15

        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(20, 0)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "silver" }
                GradientStop { position: 1.0; color: "black" }
            }
        }
    }

    // ProgressBar
    Rectangle {
        id: progressRectangle
        height: 10

        anchors.left: videoOutput.left
        anchors.right: videoOutput.right
        anchors.bottom: videoOutput.bottom

        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.bottomMargin: 50

        ProgressBar {
            value: currentTime
            width: parent.width
            id: progressBarID

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            background: Rectangle {
                    color: "silver"
                }

            contentItem: Item {
                    Rectangle {
                        width: progressBarID.position * progressBarID.width
                        height: parent.height
                        color: "red"
                    }
            }

            // Circle
            Rectangle {
                color: "red"
                radius: 15
                width: 20
                height: 20

                anchors.horizontalCenter: progressBarID.left
                anchors.horizontalCenterOffset: progressBarID.position * progressBarID.width
                anchors.verticalCenter: progressBarID.verticalCenter
            }

            // Left triangle
            Shape {
                id: leftTriangle

                anchors.left: progressBarID.left
                anchors.leftMargin: 7

                anchors.verticalCenter: progressBarID.verticalCenter
                anchors.verticalCenterOffset: -progressBarID.height * 1.1

                scale: 0.7
                transform: Rotation { angle: 180 }

                ShapePath {
                    strokeColor: "red"
                    strokeWidth: 1
                    fillColor: "red"

                    startX: 10; startY: 10
                    PathLine { x: leftTriangle.width - 10; y: leftTriangle.height - 10 }
                    PathLine { x: 10; y: leftTriangle.height - 10 }
                    PathLine { x: 10; y: 10 }
                }
            }

            // Right triangle
            Shape {
                id: rightTriangle

                anchors.right: progressBarID.right
                anchors.rightMargin: 7

                anchors.verticalCenter: progressBarID.verticalCenter
                anchors.verticalCenterOffset: -progressBarID.height * 1.1

                scale: 0.7
                transform: Rotation { angle: 90 }

                ShapePath {
                    strokeColor: "silver"
                    strokeWidth: 1
                    fillColor: "silver"

                    startX: 10; startY: 10
                    PathLine { x: rightTriangle.width - 10; y: rightTriangle.height - 10 }
                    PathLine { x: 10; y: rightTriangle.height - 10 }
                    PathLine { x: 10; y: 10 }
                }
            }

        }
    } // ProgressBar

    // Channel name text
    Text {
        id: channelInfoID
        visible: false

        font.pixelSize: 24
        color: "white"

        anchors.verticalCenter: videoOutput.verticalCenter
        anchors.verticalCenterOffset: pausePlayButton.height
        anchors.horizontalCenter: videoOutput.horizontalCenter
    }

    // Pause/play Button
    Image {
        id: pausePlayButton
        visible: false
        source: "/icons/_ionicons_svg_md-pause.svg"
        anchors.centerIn: videoOutput
        width: 50
        height: 50
        MouseArea {
            anchors.fill: parent
            onClicked: {
                    if(player.playbackState) {
                        player.stop()
                        stopButton.visible = false
                        parent.source = "/icons/_ionicons_svg_md-play.svg"
                    }
                    else{
                        player.play()
                        stopButton.visible = true
                        parent.source = "/icons/_ionicons_svg_md-pause.svg"
                    }
            }
        }
    }

    // Fullscreen Button
    Image {
        id: fullscreenButton
        visible: false
        source: isFullscreen ? "/icons/_ionicons_svg_md-contract.svg" : "/icons/_ionicons_svg_md-expand.svg"

        anchors.top: videoOutput.TopRight
        anchors.horizontalCenter: videoOutput.right
        anchors.horizontalCenterOffset: -(height/2)

        height: 50
        width: 50

        MouseArea {
            anchors.fill: parent
            onClicked: isFullscreen = !isFullscreen
        }
    }

    // Restart Button
    Image {
        id: restartButton
        visible: false
        source: "/icons/_ionicons_svg_md-refresh.svg/"

        anchors.centerIn: videoOutput
        anchors.horizontalCenterOffset: -(pausePlayButton.width)

        height: 50
        width: 50

        MouseArea {
            anchors.fill: parent
            onClicked: {
                player.stop()
                player.seek(0)
                player.play()
            }
        }
    }

    // Stop Button
    Image {
        id: stopButton
        visible: false
        source: "/icons/_ionicons_svg_md-square.svg"

        anchors.centerIn: videoOutput
        anchors.horizontalCenterOffset: pausePlayButton.width

        height: 50
        width: 50

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(player.playbackState) {
                    player.stop()
                    pausePlayButton.source = "/icons/_ionicons_svg_md-play.svg"
                    parent.visible = false
                }
            }
        }
    }

} // video rectangle
