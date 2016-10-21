import QtQuick 2.6

Rectangle {
    id: channelItem
    width: parent.width
    height: nameText.height * 5
    color: "black"

    property string channelUrl: url

    Text {
        id: nameText
        color: parent.ListView.isCurrentItem ? "red" : "white"
        font.pixelSize: channelItem.width / 30
        text: uid
        anchors.centerIn: parent
    }

    Rectangle {
     width: parent.width
     height: 2
     color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: channelItem
        hoverEnabled: true
        onClicked: {
            channelListView.currentIndex = index
        }
    }
}
