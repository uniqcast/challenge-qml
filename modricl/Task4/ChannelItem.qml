import QtQuick 2.7

Rectangle {
    id: channelItem
    width: parent.width
    height: nameText.height * 5
    color: "black"

    property string channelUrl: url

    Text {
        id: nameText
        anchors.centerIn: parent
        font.pixelSize: channelItem.width / 30
        color: parent.ListView.isCurrentItem ? "red" : "white"
        text: uid
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
