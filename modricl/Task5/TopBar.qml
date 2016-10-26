import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "ionicons.js" as Ionicons

ToolBar {
    id: topBar
    height: root.height * 0.08
    background: Rectangle {
        color: "#000000"
    }

    FontLoader { id: ioniconsFont; source: "ionicons.ttf" }

    ToolButton {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.01
        contentItem: Text {
            id: nameText
            color: "#ffffff"
            text: "Task 5"
            font.pixelSize: topBar.height * 0.4
        }
    }

    ToolButton {
        id: searchButton
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: backButton.left
        anchors.rightMargin: parent.width * 0.02
        contentItem: Text {
            color: "#ffffff"
            font.family: "Ionicons"
            text: Ionicons.img['android-search']
            font.pixelSize: topBar.height * 0.5
        }
        onClicked: {
            stackView.push(newView)
        }
    }

    ToolButton {
        id: backButton
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: topBarSeparator.left
        anchors.rightMargin: parent.width * 0.01
        contentItem: Text {
            color: "#ffffff"
            font.family: "Ionicons"
            text: Ionicons.img['android-arrow-back']
            font.pixelSize: topBar.height * 0.5
        }
        onClicked: {
            Qt.quit()
        }
    }

    Rectangle {
        id: topBarSeparator
        height: parent.height * 0.7
        width: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: clock.left
        anchors.rightMargin: parent.width * 0.01
        color: "#454545"
    }

    Rectangle {
        id: clock
        width: parent.height
        height: parent.height * 0.5
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.01
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Text {
            id: hoursText
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            color: "#ffffff"
            text: hours
            font.pixelSize: parent.height
        }

        Rectangle {
            id: minutesContainer
            height: parent.height
            width: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: hoursText.right
            anchors.leftMargin: hoursText.width * 0.1
            color: "transparent"

            Text {
                id: minutesText
                anchors.top: parent.top
                color: "#ffffff"
                font.pixelSize: topBar.height * 0.25
                text: minutes
            }

            Rectangle {
                width: minutesText.width
                height: parent.height * 0.07
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.15
                color: "#ffffff"
            }
        }
    }

    states: [
        State {
            name: "expanded"; when: videoArea.expanded
            PropertyChanges {
                target: topBar
                height: 0
                visible: false
            }
        }
    ]
}
