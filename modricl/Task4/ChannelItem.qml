import QtQuick 2.6

Rectangle {
    id: channelItem
    width: parent.width
    height: nameText.height * 5
    color: "black"
    border.color: "white"
    border.width: root.width / 800

    property string channelUrl: url

    Text {
        id: nameText
        color: parent.ListView.isCurrentItem ? "red" : "white"
        font.pixelSize: channelItem.width / 30
        text: uid
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
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
