import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.0
import QtQuick.XmlListModel 2.0
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

ApplicationWindow {
    id: root
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Task 5")
    color: "black"

    property bool isFullscreen: false

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

    // Toolbar time timer
    Timer {
        interval: 60000
        repeat: true
        running: true
        onTriggered: timeText.text = Qt.formatTime(new Date(), "hh:mm")
    }

    header: ToolBar {
        id: topbar
        height: root.height / 20

        Rectangle {
            anchors.fill: parent
            color: "black"
                RowLayout {
                    id: rowLayout
                    anchors.fill: parent
                    width: root.width
                    // Task 5 text
                    Text {
                        text: "Task 5"
                        anchors.left: parent.left
                        color: "white"
                        leftPadding: 10
                        font.pixelSize: parent.height * 0.7
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    // search button
                    ToolButton {
                        anchors.right: backButton.left
                        anchors.rightMargin: width / 2
                        background.visible: false
                        width: topbar.height
                        height: topbar.height
                        anchors.verticalCenter: parent.verticalCenter
                        Image{
                            anchors.fill: parent
                            source: "icons/_ionicons_svg_md-search.png"
                            fillMode: Image.PreserveAspectFit
                        }
                        onClicked: {
                            loadEmptyScreen.source = "searchEmptyScreen.qml"
                        }
                        Loader {
                            id: loadEmptyScreen
                        }
                    }
                    // back button
                    ToolButton {
                        id: backButton
                        anchors.right: separator.left
                        anchors.rightMargin: width / 2
                        background.visible: false
                        width: topbar.height
                        height: topbar.height
                        anchors.verticalCenter: parent.verticalCenter
                        Image{
                            anchors.fill: parent
                            source: "icons/_ionicons_svg_md-undo.png"
                            fillMode: Image.PreserveAspectFit
                        }
                        onClicked: Qt.quit()
                    }
                    // separator
                    ToolSeparator {
                        id: separator
                        height: topbar.height
                        anchors.right: timeText.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    // current time
                    Text {
                        id: timeText
                        text: Qt.formatTime(new Date(), "hh:mm")
                        anchors.right: parent.right
                        rightPadding: 10
                        color: "white"
                        font.pixelSize: parent.height * 0.7
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
        }
    } // ToolBar

    // states
    Item {
        states: [
            State {
                name: "portrait"
                when: height > width && isFullscreen === false
                PropertyChanges {
                    target: lista
                    Layout.row: 1
                    Layout.preferredHeight: root.height * ( 2 / 3 )
                    Layout.preferredWidth: root.width
                }
                PropertyChanges {
                    target: videoRectangle
                    Layout.row: 0
                    Layout.preferredHeight: root.height / 3
                    Layout.preferredWidth: root.width
                }
            },
            State {
                name: "landscape"
                when: width > height && isFullscreen === false
                PropertyChanges {
                    target: lista
                    Layout.column: 0
                    Layout.preferredHeight: root.height
                    Layout.preferredWidth: root.width / 3
                }
                PropertyChanges {
                    target: videoRectangle
                    Layout.column: 1
                    Layout.preferredHeight: root.height
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
                    target: topbar
                    visible: false
                }
            }
        ]
    }

    GridLayout {
        anchors.fill: parent
        flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom

        Rectangle{
            id: lista
            color: "black"

            ListView{
                id: listViewID
                focus: true
                model: xmlModel

                orientation: ListView.Vertical
                onCurrentItemChanged: {
                    channelInfoID.text = xmlModel.get(currentIndex).uid
                    player.source = xmlModel.get(currentIndex).url
                }

                width: parent.width
                height: parent.height

                delegate:
                    Rectangle{
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
                        Rectangle{
                            id: channelName
                            color: "black"

                            width: lista.width - ( 1 / 5 * lista.width )
                            height: root.height / 10

                            anchors.right: parent.right
                            Text {
                                text: model.uid
                                color: channelOption.focus ? "red" : "white"
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: -5
                                anchors.margins: 10
                                font.pixelSize: 24
                                Text {
                                    anchors.top: parent.bottom
                                    text: model.start + " - " + model.end
                                    font.pixelSize: 16
                                    color: "gray"
                                }
                            }

                            Image {
                                source: "/icons/_ionicons_svg_md-arrow-dropright.png"
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.height / 2.5
                                height: parent.height / 2.5
                                fillMode: Image.PreserveAspectFit
                            }
                        }

                        // Channel icon
                        Rectangle{
                            id: channelIcon
                            color: "black"

                            height: root.height / 10
                            width: lista.width - channelName.width

                            anchors.left: parent.left
                            border.color: "gray"
                            border.width: 1
                            Image{
                                width: parent.width * 0.8
                                height: parent.height * 0.8
                                anchors.centerIn: parent
                                fillMode: Image.PreserveAspectFit
                                source: model.icon
                            }
                        }
                    }
            } // ListView
        } // lista ectangle

        Rectangle{
            id: videoRectangle
            color: "gray"

            Layout.fillWidth: true
            Layout.fillHeight: true

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    pausePlayButton.visible = true
                    fullscreenButton.visible = true
                    restartButton.visible = true
                    stopButton.visible = player.playbackState ? true : false
                    channelInfoID.visible = true
                    buttonTimer.restart();
                }
            }

            MediaPlayer {
                id: player
                autoPlay: true
            }

            ProgressBar {
                id: progressBarID
                anchors.bottom: videoOutput.bottom
                width: videoOutput.width
                height: videoOutput.height / 10
                from: 5
                to: 999999
                z: 99
                value: player.position
                background: {
                    color: "red"
                    width: width
                }
            }

            VideoOutput {
                id: videoOutput
                source: player
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: channelInfoID
                visible: false
                font.pixelSize: root.height / 35
                color: "white"
                anchors.centerIn: videoOutput
                anchors.verticalCenterOffset: root.height / 10
            }

            Image{
                id: pausePlayButton
                visible: false
                source: "/icons/_ionicons_svg_md-pause.svg"
                anchors.centerIn: videoOutput
                width: 75
                height: 75
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                            if(player.playbackState){
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
            } // image Pause/Play
            Image {
                id: fullscreenButton
                visible: false
                source: isFullscreen ? "/icons/_ionicons_svg_md-contract.svg" : "/icons/_ionicons_svg_md-expand.svg"
                anchors.top: videoOutput.TopRight
                anchors.horizontalCenter: videoOutput.right
                anchors.horizontalCenterOffset: -(height/2)
                height: 75
                width: 75
                MouseArea{
                    anchors.fill: parent
                    onClicked: isFullscreen = !isFullscreen
                }
            } // Image fullscreen
            Image {
                id: restartButton
                visible: false
                source: "/icons/_ionicons_svg_md-refresh.svg/"
                anchors.centerIn: videoOutput
                anchors.horizontalCenterOffset: -(pausePlayButton.width)
                height: 75
                width: 75
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        player.stop()
                        player.seek(0)
                        player.play()
                    }
                }
            } // restart button
            Image {
                id: stopButton
                visible: false
                source: "/icons/_ionicons_svg_md-square.svg"
                anchors.centerIn: videoOutput
                anchors.horizontalCenterOffset: pausePlayButton.width
                height: 75
                width: 75
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(player.playbackState){
                            player.stop()
                            pausePlayButton.source = "/icons/_ionicons_svg_md-play.svg"
                            parent.visible = false
                        }
                    }
                }
            } // stop button
        } // video rectangle

    } // gridLayout

    // button timer
    Timer{
        id: buttonTimer
        interval: 5000
        onTriggered: {
            pausePlayButton.visible = false
            fullscreenButton.visible = false
            restartButton.visible = false
            stopButton.visible = false
            channelInfoID.visible = false
        }
    } // button timer

} // appWindow
