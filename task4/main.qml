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
                            if (controls.height === 0) showControls.restart()
                            else {showControls.stop(); resetControls.restart()}
                        }
                    }
                    Video
                    {
                        anchors.fill: parent
                        id: screen
                        state: 'normal'
                        autoPlay: true
                        source: movieXml.get(view.currentIndex || 0).url
                        Rectangle
                        {
                            id: controls
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: 0
                            visible: true
                            gradient: Gradient
                            {
                                GradientStop {position: 0.0; color: '#00000000'}
                                GradientStop {position: 0.5; color: '#ff000000'}
                            }
                            Image
                            {
                                height: parent.height*0.8
                                width: height
                                anchors.centerIn: parent
                                source: screen.playbackState == MediaPlayer.PlayingState ? "images/pause.svg" : "images/play.svg"
                                MouseArea
                                {
                                    anchors.fill: parent
                                    onClicked:  screen.playbackState == MediaPlayer.PlayingState ? screen.pause() : screen.play()
                                }
                            }
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
                                        }
                                    }
                                }
                            }
                            SequentialAnimation
                            {
                                id:showControls
                                NumberAnimation {target: controls; property: "height"; from: 0; to: screen.height/7; duration: 50; easing.type: Easing.InOutQuad}
                                PauseAnimation {duration: 5000}
                                NumberAnimation {target: controls; property: "height"; from: screen.height/7; to: 0; duration: 200; easing.type: Easing.InOutQuad}

                            }
                            SequentialAnimation
                            {
                                id:resetControls
                                PauseAnimation {duration: 5000}
                                NumberAnimation {target: controls; property: "height"; from: screen.height/7; to: 0; duration: 200; easing.type: Easing.InOutQuad}
                            }
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
                color: ListView.isCurrentItem ? 'red' : '#000'
                Text
                {
                    anchors.fill: parent
                    anchors.leftMargin: 50
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
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
