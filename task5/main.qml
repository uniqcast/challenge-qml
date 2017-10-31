import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.9
import QtQuick.Layouts 1.3
import QtQml 2.2
import './seekConverter.js' as SeekConverter
import './ionicons.js' as Ionicons

ApplicationWindow
{
    id: root
    visible: true
    color: "darkGrey"
    property bool showControls: true
    FontLoader { source: "ionicons.ttf"; id:loader }
    Rectangle
    {
        id: fullscreenFrame
        anchors.fill: parent
        Rectangle
        {
            id: toolbar
            width: parent.width
            height: 160
            color: '#000'
            Text
            {
                anchors {verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 25}
                font.pointSize: 23
                color: 'white'
                text: 'Task 5'
            }
            Text
            {
                anchors.margins: 50
                anchors.right: back.left
                anchors.verticalCenter: parent.verticalCenter
                color: '#fff'
                font.pixelSize: parent.height-70
                text: Ionicons.img["search"]
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {toNextPage.source = "page2.qml"; frame.visible = false}
                }
            }
            Text
            {
                id: back
                anchors.margins: 50
                anchors.right: separator.left
                anchors.verticalCenter: parent.verticalCenter
                color: '#fff'
                font.family: loader.name
                font.pixelSize: parent.height-70
                text: Ionicons.img["reply"]
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: Qt.quit()
                }
            }
            Rectangle
            {
                id: separator
                anchors {right: time.left; rightMargin: 30; leftMargin: 80; verticalCenter: parent.verticalCenter}
                height: parent.height-30
                width: 2
                color: '#2E2E2E'
            }
            Text
            {
                id: time
                anchors {verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: 50}
                font.pointSize: 20
                color: 'white'
                function set()
                {
                    time.text = Qt.formatTime(new Date(), "hh:mm")
                }
            }
            Timer
            {
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered:
                {
                    time.set()
                    if(player.status == 6 || player.status == 5)
                    {
                        SeekConverter.getPosition(movieXml.get(view.currentIndex).start, movieXml.get(view.currentIndex).end)
                    } else progress.width == 0
                }
                }
        }
        Timer
        {
            id: showControlsTimer
            interval: 5000; running: true
            onTriggered: showControls = false
        }
        Loader
        {
            id: toNextPage
            anchors.fill: parent
        }
        Rectangle
        {
            id: frame
            anchors {top:toolbar.bottom; left: parent.left;right: parent.right; bottom: parent.bottom}
            color: '#000'
            GridLayout
            {
                id: grid
                rowSpacing: 2
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
                        id: playerParent
                        anchors.fill: parent
                        color: '#000'
                        Video
                        {
                            anchors.fill: parent
                            id: player
                            state: 'normal'
                            autoPlay: true
                            source: movieXml.get(view.currentIndex || 0).url
                            notifyInterval: 50
                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    showControls = true
                                    showControlsTimer.restart()
                                }
                            }
                            Rectangle
                            {
                                id: controls
                                anchors.bottom: currentTitle.top
                                width: parent.width
                                height: player.height/7
                                color: '#00000000'
                                visible: opacity > 0 ? true : false
                                opacity: showControls ? 1 : 0
                                Behavior on opacity {NumberAnimation{}}
                                Rectangle
                                {
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    Text
                                    {
                                        font.pixelSize: parent.height*0.8
                                        color: '#fff'
                                        text: Ionicons.img["android-refresh"]
                                        anchors {right: playPause.left; verticalCenter: parent.verticalCenter; rightMargin: 75}
                                        MouseArea
                                        {
                                            anchors.fill: parent
                                            onClicked: {player.stop(); player.play(); showControls = true; showControlsTimer.restart()}
                                        }
                                    }
                                    Text
                                    {
                                        id: playPause
                                        font.pixelSize: parent.height*0.8
                                        width: font.pixelSize*0.6
                                        color: '#fff'
                                        anchors.centerIn: parent
                                        text: player.playbackState == MediaPlayer.PlayingState ? Ionicons.img["pause"] : Ionicons.img["play"]
                                        MouseArea
                                        {
                                            anchors.fill: parent
                                            onClicked:  {player.playbackState == MediaPlayer.PlayingState ? player.pause() : player.play(); showControls = true; showControlsTimer.restart(); console.log(player.position)}
                                        }
                                    }
                                    Text
                                    {
                                        color: '#fff'
                                        text: Ionicons.img["stop"]
                                        font.pixelSize: parent.height*0.8
                                        anchors {left: playPause.right; verticalCenter: parent.verticalCenter; leftMargin: 75}
                                        visible: player.playbackState == MediaPlayer.PlayingState ? true : false
                                        MouseArea
                                        {
                                            anchors.fill: parent
                                            onClicked: {player.stop(); showControls = true; showControlsTimer.restart()}
                                        }
                                    }
                                }
                            }
                            Text
                            {
                                id: fullscreen
                                font.pixelSize: 100
                                color: '#fff'
                                anchors {right: parent.right; rightMargin: 20; top: parent.top; topMargin: 20}
                                text: player.state == 'normal' ? Ionicons.img["arrow-expand"] : Ionicons.img["arrow-shrink"]
                                visible: opacity > 0 ? true : false
                                opacity: showControls ? 1 : 0
                                Behavior on opacity {NumberAnimation{}}
                                MouseArea
                                {
                                    anchors.fill: parent
                                    onClicked:
                                    {
                                        if (MediaPlayer.PlayingState)
                                        {
                                            player.state = player.state == 'normal' ? 'fullscreen' : 'normal'
                                            showControls = true
                                            showControlsTimer.restart()
                                        }
                                    }
                                }
                            }
                            Text
                            {
                                id:currentTitle
                                text: movieXml.get(view.currentIndex).uid
                                height: 50
                                font.pointSize: 17
                                color: "white"
                                anchors {horizontalCenter: parent.horizontalCenter; bottom: timelineBar.top; bottomMargin: 10}
                                visible: opacity > 0 ? true : false
                                opacity: showControls ? 1 : 0
                                Behavior on opacity {NumberAnimation{}}
                            }
                            Rectangle
                            {
                                id: timelineBar
                                anchors.bottom: parent.bottom
                                width: parent.width
                                color: '#000'
                                height: 110
                                visible: opacity > 0 ? true : false
                                opacity: showControls ? 1 : 0
                                Behavior on opacity {NumberAnimation{}}
                                Text
                                {
                                    color: 'white'
                                    text: movieXml.get(view.currentIndex).start
                                    font.pointSize: 15
                                    anchors {leftMargin: 30; left: parent.left; top: parent.top}
                                }
                                Text
                                {
                                    color: 'white'
                                    text: movieXml.get(view.currentIndex).end
                                    font.pointSize: 15
                                    anchors {rightMargin: 30; right: parent.right; top: parent.top}
                                }
                                Rectangle
                                {
                                    id: progressParent
                                    anchors {bottom: parent.bottom; bottomMargin: 30; horizontalCenter: parent.horizontalCenter}
                                    width: parent.width-50
                                    height: 8
                                    color: 'grey'
                                    Rectangle
                                    {
                                        id: progress
                                        anchors {left: parent.left; bottom: parent.bottom; top: parent.top}
                                        color: 'red'
                                        Rectangle {
                                            visible: player.playbackState == MediaPlayer.PlayingState ? true : false
                                            anchors.horizontalCenter: parent.right
                                            anchors.verticalCenter: parent.verticalCenter
                                            color: 'red'
                                            height: 14
                                            width: 14
                                            radius: 7
                                        }
                                    }
                                }
                            }
                            states:
                                [
                                State
                                {
                                    name: 'fullscreen'
                                    ParentChange {target: playerParent; parent: fullscreenFrame; height: frame.height; width: frame.width}
                                },
                                State
                                {
                                    name: 'normal'
                                    ParentChange {target: playerParent; parent: gridChild; height: frame.height; width: frame.width}
                                }
                            ]
                        }
                    }
                }
                Rectangle
                {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: '#474747'
                    ListView
                    {
                        anchors.fill: parent
                        clip: true
                        id: view
                        spacing: 2
                        focus: true
                        boundsBehavior: Flickable.StopAtBounds
                        highlightMoveDuration: 200
                        model: movieXml
                        delegate: movieDelegate
                        currentIndex: 0

                        Rectangle
                        {
                         anchors.fill: parent
                         gradient: Gradient
                         {
                             GradientStop {position: 0.0; color: '#ff000000'}
                             GradientStop {position: 0.07; color: '#00000000'}
                             GradientStop {position: 0.93; color: '#00000000'}
                             GradientStop {position: 1.0; color: '#ff000000'}
                         }

                        }
                    }
                }
            }
            XmlListModel
            {
                id: movieXml
                source: "qrc:///channels.xml"
                query: "/channels/channel"
                XmlRole {name: "uid"; query: "uid/string()"}
                XmlRole {name: "icon"; query: "icon/string()"}
                XmlRole {name: "start"; query: "start/string()"}
                XmlRole {name: "end"; query: "end/string()"}
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
                    color: '#000'
                    property bool isCurrentItem: ListView.isCurrentItem
                    Image
                    {
                        id: slika
                        anchors.margins: 60
                        height: parent.height
                        anchors.left: parent.left
                        width: 100
                        source: icon + '.png'
                        fillMode: Image.PreserveAspectFit
                    }
                    Rectangle
                    {
                        height: parent.height
                        anchors.left: slika.right
                        anchors.right: strelica.left
                        anchors.leftMargin: 50
                        color: '#00000000'

                        Text
                        {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -23

                            id: title
                            height: 50
                            anchors.topMargin: 40
                            color: isCurrentItem ? 'red' : 'white'
                            elide: Text.ElideRight
                            font.pointSize: 16
                            text: uid
                        }
                        Text
                        {
                            anchors.topMargin: 10
                            anchors.top: title.bottom
                            height: 50
                            color:'grey'
                            elide: Text.ElideRight
                            font.pointSize: 12
                            text: start + ' - ' + end
                        }
                    }
                    Text
                    {
                        id:strelica
                        font.pixelSize: parent.height*0.3
                        anchors.verticalCenter: parent.verticalCenter
                        text: Ionicons.img["chevron-right"]
                        color: '#fff'
                        anchors.right: parent.right
                        anchors.rightMargin: 50
                    }
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            view.currentIndex = index
                            showControls = true
                            showControlsTimer.restart()
                        }
                    }
                }
            }
        }
    }
}
