import QtQuick 2.0

Rectangle
{
    anchors.fill: parent
    color: 'black'
    Text
    {
        id:tekst
        anchors.centerIn: parent
        font.pointSize: 40
        color: 'white'
        text: 'New empty screen!'
    }

    Rectangle
    {
        anchors.top: tekst.bottom
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width/2
        height: 200
        border.color: "#fff"
        border.width: 4
        color: '#000'
        Text
        {
            text: 'Tap to go back'
            color: 'white'
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                frame.visible = true
                toNextPage.source = ""
            }
        }
    }
}
