import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "ionicons.js" as Ionicons

ToolBar
{
    height: 45
    id: topItemsBar

    Rectangle
    {
        anchors.fill: parent
        height: 45
        color: "#000"

        states:
        [
            State
            {
                name: "name"
                when: appWrap.expanded

                PropertyChanges
                {
                    target: topItemsBar
                    height:0
                    visible: false
                }
            }
        ]

        RowLayout
        {
            anchors.fill: parent

            Text
            {
                id: taskname
                text: qsTr("Task 5")
                color: "#e9e9e9"
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 15
            }

            Item
            {
                id: topIcons
                height: parent.height
                width: searchIcon.contentWidth + backIcon.contentWidth + 30
                anchors.right: vertLine.right
                anchors.rightMargin: 15

                Text
                {
                    id: searchIcon
                    color: "#e9e9e9"
                    text: Ionicons.img["search"]
                    font.family: loader.name
                    font.pointSize: 18
                    rightPadding: 30
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: stack.push(searchView)
                    }
                }

                Text
                {
                    id: backIcon
                    color: "#e9e9e9"
                    text: Ionicons.img["arrow-return-left"]
                    font.family: loader.name
                    anchors.left: searchIcon.right
                    font.pointSize: 18
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: Qt.quit()
                    }
                }
            }

            Rectangle
            {
                id: vertLine
                height: parent.height - 4
                width: 1
                color: "#333"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: timeClock.left
                anchors.rightMargin: 10
            }

            Item
            {
                anchors.right: parent.right
                id: timeClock
                width: timeHours.contentWidth + timeMinutes.contentWidth + 10
                height: parent.height

                Timer
                {
                    id: clockTimer
                    interval: 3600
                    running: true

                    onTriggered:
                    {
                        timeHours.text = Qt.formatDateTime(new Date(), "HH")
                        timeMinutes.text = Qt.formatDateTime(new Date(), "mm")
                        date = new Date
                        clockTimer.restart()
                    }
                }

                Text
                {
                    id: timeHours
                    text: Qt.formatDateTime(new Date(), "HH")
                    color: "#e9e9e9"
                    anchors.verticalCenter: parent.verticalCenter
                    rightPadding: 2
                    font.pixelSize: vertLine.height*0.5
                }

                Item
                {
                    id: minutesWrap
                    anchors.left: timeHours.right

                    Text
                    {
                        id: timeMinutes
                        text: Qt.formatDateTime(new Date(), "mm")
                        color: "#e9e9e9"
                        rightPadding: 10
                        topPadding: 12
                        font.pixelSize: vertLine.height*0.35

                        Rectangle
                        {
                            id: minuteUnderline
                            width: timeMinutes.contentWidth
                            anchors.top: timeMinutes.bottom
                            height: 1
                            color: "#e9e9e9"
                            anchors.topMargin: 2
                        }
                    }
                }
            }
        }

        Component.onCompleted: clockTimer.start()
    }
}
