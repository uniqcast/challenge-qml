import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import "ionicons.js" as Ionicons

Rectangle
{
    id: channelItem
    width: parent.width
    height: width / 5
    color: "#171717"

    FontLoader { id: ioniconsFont; source: "ionicons.ttf" }

    property string channelUrl: url
    property string channelInfo: uid
    property string startTime: started
    property string endTime: ended

    Rectangle
    {
        id: itemSeparator
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
        color: "#454545"
        z: 1
    }

    Item
    {
        id: logoContainer
        width: parent.height
        height: parent.height

        Image
        {
            id: channelLogo
            height: parent.height * 0.7
            width: parent.width * 0.7
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
            source: icon + ".png"
        }
    }

    Rectangle
    {
        id: verticalSeparator
        height: parent.width
        width: 1
        anchors.left: logoContainer.right
        color: "#454545"
    }

    Item
    {
        id: infoContainer
        width: channelItem.width - logoContainer.width
        height: channelItem.height
        anchors.left: logoContainer.right
        anchors.top: channelItem.top

        Text
        {
            id: nameText
            anchors.left: infoContainer.left
            anchors.leftMargin: 15
            anchors.top: infoContainer.top
            anchors.topMargin: infoContainer.height * 0.25
            color: parent.parent.ListView.isCurrentItem ? "red" : "white"
            font.pixelSize: infoContainer.height * 0.20
            elide: Text.ElideRight
            text: uid
        }

        Text
        {
            id: timeText
            anchors.left: infoContainer.left
            anchors.leftMargin: 15
            anchors.top: nameText.bottom
            anchors.topMargin: infoContainer.height * 0.05
            color: "#565656"
            font.pixelSize: channelItem.height * 0.15
            text: started + " - " + ended
        }

        Text
        {
            id: playChevron
            anchors.verticalCenter: infoContainer.verticalCenter
            anchors.right: infoContainer.right
            anchors.rightMargin: 25
            color: "#565656"
            font.family: "Ionicons"
            font.pixelSize:  infoContainer.height * 0.20
            text: Ionicons.img['ios-arrow-forward']
        }
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: channelItem
        hoverEnabled: true
        onClicked:
        {
            channelListView.currentIndex = index
        }
    }
}
