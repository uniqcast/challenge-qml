import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.9
import QtQuick.Layouts 1.3

ApplicationWindow
{
    id: root
    visible: true
    color: "darkGrey"
    property bool showControls: true
    Rectangle
    {
        id: frame
        anchors.fill: parent
        color: '#000'
        GridLayout
        {
            id: grid
            anchors.fill: parent
            layoutDirection: Qt.RightToLeft
            flow: width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom
            Rectangle
            {
                id: gridChild
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "red"
                Rectangle
                {
                    id: screenParent
                    anchors.fill: parent
                    color: '#000'
                    Behavior on height
                    {
                        NumberAnimation {duration: 100}
                    }
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            showControls = true
                            showControlsTimer.restart()
                        }
                    }
                    Video
                    {
                        anchors.fill: parent
                        id: screen
                        state: 'normal'
                        autoPlay: true
                        source: movieXml.get(view.currentIndex || 0).url
                        Image
                        {
                            height: 150
                            width: height
                            anchors.centerIn: parent
                            visible: opacity > 0 ? true : false
                            opacity: showControls ? 1 : 0
                            Behavior on opacity {NumberAnimation{}}
                            source: screen.playbackState == MediaPlayer.PlayingState ? "images/pause.svg" : "images/play.svg"
                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:  {screen.playbackState == MediaPlayer.PlayingState ? screen.pause() : screen.play(); showControls: true; showControlsTimer.restart()}
                            }
                        }
                        Rectangle
                        {
                            id: controls
                            anchors.bottom: parent.bottom
                            width: parent.width
                            color: '#00000000'
                            height: parent.height/7
                            visible: opacity > 0 ? true : false
                            opacity: showControls ? 1 : 0
                            Behavior on opacity {NumberAnimation{}}

                            Image
                            {
                                height: parent.height*0.8
                                width: height
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                source: screen.state == 'normal' ? "images/expand.svg" : "images/contract.svg"
                                MouseArea
                                {
                                    anchors.fill: parent
                                    onClicked:
                                    {
                                        if (MediaPlayer.PlayingState)
                                        {
                                            screen.state = screen.state == 'normal' ? 'fullscreen' : 'normal'
                                            showControls = true
                                            showControlsTimer.restart()
                                        }
                                    }
                                }
                            }
                        }
                        Timer
                        {
                            id: showControlsTimer
                            interval: 5000; running: true
                            onTriggered: showControls = false
                        }
                        states:
                            [
                            State
                            {
                                name: 'fullscreen'
                                ParentChange {target: screenParent; parent: frame; height: frame.height; width: frame.width}
                            },
                            State
                            {
                                name: 'normal'
                                ParentChange {target: screenParent; parent: gridChild; height: frame.height; width: frame.width}
                            }
                        ]

                    }
                }
            }
            Rectangle
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#1e1b18"
                ListView
                {
                    anchors.fill: parent
                    clip: true
                    id: view
                    spacing: 5
                    focus: true
                    boundsBehavior: Flickable.DragOverBounds
                    highlightMoveDuration: 200
                    model: movieXml
                    delegate: movieDelegate
                    currentIndex: 0
                }
            }
        }
        XmlListModel
        {
            id: movieXml
            source: "qrc:///channels.xml"
            query: "/channels/channel"
            XmlRole {name: "uid"; query: "uid/string()"}
            XmlRole {name: "url"; query: "url/string()"}
        }
        Component
        {
            id: movieDelegate
            Rectangle
            {
                id: column
                width: parent.width
                height: 200
                focus: true
                color: '#000'
                Text
                {
                    anchors.fill: parent
                    anchors.leftMargin: 50
                    verticalAlignment: Text.AlignVCenter
                    color: column.focus ? 'red' : 'white'
                    font.pixelSize: 60
                    text: uid
                }
                Rectangle
                {
                    height: 2
                    width: parent.width
                    color: 'white'
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        view.currentIndex = index
                    }
                }
            }
        }
    }
}
