import QtQuick 2.7
import "ionicons.js" as Ionicons

Item{
    property string videolink: url
    property string videostart: start
    property string videoend: end
    property string playingTitle: channelTitle

    height: singleitem.height
    width: parent.width
    id: listItem
    Rectangle{
        id: singleitem
        height: channelName.contentHeight+itemTime.contentHeight+20
        width: listWrap.width
        color: "#151515"
        border.color: listItem.ListView.isCurrentItem ? "#FFF" : "#999"
        border.width: listItem.ListView.isCurrentItem ? 1 : 0
        Row{
            Item {
                id: iconWrapp
                anchors.verticalCenter: parent.verticalCenter
                width: 72
                height: channelIcon.height
                Image {
                    height: channelIcon.width*0.7
                    width: 55
                    id: channelIcon
                    source: icon +".png"
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle{
            height: singleitem.height-2
            anchors.top: parent.top
            anchors.topMargin: 1
            width: 1
            color: "#333"
            }
            Item {
                width: listItem.width-iconWrapp.width
                anchors.left: iconWrapp.right
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    width: listItem.width-iconWrapp.width
                    id: channelName
                    text: channelTitle
                    color: listItem.ListView.isCurrentItem ? "red" : "#e9e9e9"
                    font.pointSize: 12
                    elide: Text.ElideRight
                    leftPadding: 5
                    anchors.bottom: itemTime.top
                    z: 3
                }
                Text {
                    id: itemTime
                    text: start + "-" + end
                    leftPadding: 5
                    topPadding: 5
                    color: "#848484"
                    font.pointSize: 9
                }
                Text {
                    id: arrowToRight
                    text: Ionicons.img["chevron-right"]
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: channelName.font.pointSize
                    color: "#363636"
                    rightPadding: 15
                }
            }

        }
        Rectangle{
            color: "#333"
            width: parent.width
            height: listItem.ListView.isCurrentItem ? 0 : 1
        }

        MouseArea{
            anchors.fill: parent
            onClicked: channelList.currentIndex = index
        }
    }
}
