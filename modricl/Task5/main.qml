import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.5
import QtGraphicalEffects 1.0
import "ionicons.js" as Ionicons

ApplicationWindow {
    visible: true
    id: root
    color: "#292929"
    width: Screen.width
    height: Screen.height
    //    visibility: "FullScreen"
    header: TopBar{}

    FontLoader { id: ioniconsFont; source: "ionicons.ttf" }

    property string hours: ""
    property string minutes: ""
    property date date

    Timer {
        interval: 100; running: true; repeat: true;
        onTriggered: {
            date = new Date()
            hours = date.getHours()
            minutes = date.getMinutes()
            if (hours < 10) {hours = "0" + hours}
            if (minutes < 10) {minutes = "0" + minutes}
        }
    }

    property bool hideProperty: true

    Timer {
        id: buttonTimer
        interval: 5000
        onTriggered: {
            hideProperty = false
        }
    }

    StackView {
        id: stackView
        focus: true
        initialItem: gridView
        anchors.fill: parent

        Item {
            id: newView
            Rectangle {
                anchors.fill: parent
                color: "#0000ff"
            }
        }

        GridLayout {
            id: gridView
            anchors.fill: parent
            columnSpacing: 0
            rowSpacing: 0
            flow: root.width > root.height ? GridLayout.LeftToRight : GridLayout.TopToBottom
            LayoutMirroring.enabled: true

            Rectangle {
                id: videoArea
                Layout.fillWidth: true
                Layout.preferredHeight: (root.width / 16) * 9
                color: "#292929"
                z: 1

                property bool expanded: false

                MediaPlayer {
                    id: mediaplayer
                    autoPlay: true
                }

                VideoOutput {
                    id: videoOutput
                    anchors.fill: parent
                    fillMode: VideoOutput.PreserveAspectFit
                    source: mediaplayer
                }

                ProgressBar {
                    id: progressBar
                    visible: hideProperty
                    height: root.height * 0.01
                    width: parent.width
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    from: formatTime(channelListView.currentItem ? channelListView.currentItem.startTime : "")
                    to:  formatTime(channelListView.currentItem ? channelListView.currentItem.endTime : "")
                    value: date.getTime();
                    background: Rectangle {
                        anchors.fill: parent
                        color: "#efefef"
                    }
                    contentItem: Item {
                        anchors.fill: parent

                        Rectangle {
                            width: progressBar.visualPosition * progressBar.width
                            height: parent.height
                            color: "#ff0000"
                        }
                    }

                    Text {
                        id: start
                        visible: hideProperty
                        anchors.left: parent.left
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 10
                        color: "#dedede"
                        style: Text.Outline
                        styleColor: "#000000"
                        font.pixelSize: progressBar.height * 2
                        text: channelListView.currentItem ? channelListView.currentItem.startTime : ""
                    }

                    Text {
                        id: end
                        visible: hideProperty
                        anchors.right: parent.right
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 10
                        color: "#dedede"
                        style: Text.Outline
                        styleColor: "#000000"
                        font.pixelSize: progressBar.height * 2
                        text: channelListView.currentItem ? channelListView.currentItem.endTime : ""
                    }

                    Rectangle {
                        width: progressBar.height * 2
                        height: width
                        anchors.horizontalCenter: progressBar.left
                        anchors.horizontalCenterOffset: progressBar.visualPosition * progressBar.width
                        anchors.verticalCenter: parent.verticalCenter
                        radius: width*0.5
                        color: "#ff0000"
                    }
                }

                DropShadow {
                    visible: root.width < root.height ? true : false
                    anchors.fill: videoArea
                    horizontalOffset: 0
                    verticalOffset: 5
                    radius: 12.0
                    samples: 25
                    spread: 0
                    color: "#80000000"
                    source: videoArea
                    z: -1
                }

                RowLayout {
                    id: mediaButtonContainer
                    width: parent.width * 0.3
                    anchors.centerIn: parent
                    z: 1

                    Button {
                        id: replayButton
                        visible: hideProperty
                        width: parent.width / 3
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        background: Item {}
                        contentItem: Text {
                            color: "#ffffff"
                            font.family: "Ionicons"
                            text: Ionicons.img['refresh']
                            font.pixelSize: videoArea.width * 0.05
                            style: Text.Outline
                            styleColor: "#000000"
                            horizontalAlignment: Text.AlignHCenter
                        }

                        MouseArea {
                            preventStealing: true
                            anchors.fill: parent
                            onClicked: {
                                mediaplayer.seek(0)
                            }
                        }
                    }

                    Button {
                        id: triggerButton
                        visible: hideProperty
                        width: parent.width / 3
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        background: Item {}
                        contentItem: Text {
                            color: "#ffffff"
                            font.family: "Ionicons"
                            text: mediaplayer.playbackState == 1 ? Ionicons.img['pause'] : Ionicons.img['play']
                            font.pixelSize: videoArea.width * 0.05
                            style: Text.Outline
                            styleColor: "#000000"
                            horizontalAlignment: Text.AlignHCenter
                        }

                        MouseArea {
                            preventStealing: true
                            anchors.fill: parent
                            onClicked: mediaplayer.playbackState == MediaPlayer.PlayingState ? mediaplayer.pause() : mediaplayer.play()
                        }
                    }

                    Button {
                        id: stopButton
                        visible: hideProperty
                        width: parent.width / 3
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        background: Item {}
                        contentItem: Text {
                            color: "#ffffff"
                            font.family: "Ionicons"
                            text: Ionicons.img['stop']
                            font.pixelSize: videoArea.width * 0.05
                            style: Text.Outline
                            styleColor: "#000000"
                            horizontalAlignment: Text.AlignHCenter
                        }

                        MouseArea {
                            preventStealing: true
                            anchors.fill: parent
                            onClicked: {

                                mediaplayer.stop()
                            }
                        }
                    }
                }

                Text {
                    id: videoInformation
                    visible: hideProperty
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: mediaButtonContainer.bottom
                    anchors.topMargin: videoArea.width * 0.1
                    color: "#ffffff"
                    text: channelListView.currentItem ? channelListView.currentItem.channelInfo : ""
                    font.pixelSize: root.width * 0.04
                    style: Text.Outline
                    styleColor: "#000000"

                }

                Button {
                    id: expandButton
                    visible: hideProperty
                    anchors.top: videoArea.top
                    anchors.topMargin: videoArea.height * 0.05
                    anchors.right: videoArea.right
                    anchors.rightMargin: videoArea.height * 0.05
                    z: 1
                    background: Item {}
                    contentItem: Text {
                        color: "#ffffff"
                        font.family: "Ionicons"
                        text: videoArea.expanded == true ? Ionicons.img['android-contract'] : Ionicons.img['android-expand']
                        font.pixelSize: videoArea.width * 0.05
                        style: Text.Outline
                        styleColor: "#000000"
                    }

                    MouseArea {
                        preventStealing: true
                        anchors.fill: parent
                        onClicked: {
                            videoArea.expanded = !videoArea.expanded
                        }
                    }
                }

                MouseArea {
                    preventStealing: true
                    anchors.fill: parent
                    onClicked: {
                        hideProperty = true
                        buttonTimer.restart()
                    }
                }
            }

            Rectangle {
                id: channelList
                Layout.fillHeight: true

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
                    highlight: SelectedItem {}
                    onCurrentItemChanged: {
                        mediaplayer.source = channelListView.currentItem.channelUrl
                        hideProperty = true
                        buttonTimer.restart()
                    }
                }
            }

            states: [
                State {
                    name: "expanded"; when: videoArea.expanded
                    PropertyChanges {
                        target: videoArea
                        width: root.width
                        height: root.height
                        anchors.centerIn: parent
                    }
                    PropertyChanges {
                        target: channelList
                        visible: false
                    }
                },
                State {
                    name: "landscape"; when: (root.width > root.height)
                    PropertyChanges {
                        target: channelList
                        Layout.preferredWidth: parent.width * 0.35
                        Layout.maximumWidth: 700
                        Layout.minimumWidth: 300
                    }
                    PropertyChanges {
                        target: videoArea
                        Layout.fillHeight: true
                    }
                },
                State {
                    name: "portrait"; when: (root.width < root.height)
                    PropertyChanges {
                        target: channelList
                        Layout.fillWidth: true
                    }
                }
            ]
        }
    }


    function formatTime(time){
        var formatHours = time.split(':')[0];
        var formatMinutes = time.split(':')[1];

        var ft = new Date;
        ft.setHours(formatHours)
        ft.setMinutes(formatMinutes)

        return ft.getTime()
    }

    XmlListModel {
        id: xmlModel
        source: "channels.xml"
        query: "/channels/channel"

        XmlRole { name: "uid"; query: "uid/string()" }
        XmlRole { name: "url"; query: "url/string()" }
        XmlRole { name: "icon"; query: "icon/string()" }
        XmlRole { name: "started"; query: "start/string()" }
        XmlRole { name: "ended"; query: "end/string()" }
    }
}

