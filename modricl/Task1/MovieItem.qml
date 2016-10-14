import QtQuick 2.6
import QtGraphicalEffects 1.0

Rectangle {
    id: movieItem
    width: (movieListView.width / 5) - movieListView.spacing
    color: "#00000000"
    height: imageItem.height
    scale: ListView.isCurrentItem ? 1 : 0.9
    Behavior on scale { NumberAnimation { duration: 200 } }


    Image {
        id: imageItem
        width: movieItem.width
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        source: imagePath
    }

    Text {
        id: nameText
        color: "#ffffff"
        anchors.left: imageItem.left
        anchors.leftMargin: 0
        font.pixelSize: movieItem.width / 10
        text: movieName
        anchors.top: imageItem.bottom
        anchors.topMargin: movieItem.width / 35
    }

    Text {
        id: yearText
        color: "#ffffff"
        text: movieYear
        anchors.left: imageItem.left
        anchors.leftMargin: 0
        anchors.top: nameText.bottom
        anchors.topMargin: movieItem.width / 50
        font.pixelSize: movieItem.width / 15
    }


    DropShadow {
        id: shadowItem
        anchors.fill: imageItem
        horizontalOffset: movieItem.width / 100
        verticalOffset: movieItem.width / 100
        radius: movieItem.width / 50
        samples: 20
        color: "#80000000"
        source: imageItem
    }

    Text {
        id: ratingText
        color: "#ffffff"
        text: movieRating
        anchors.horizontalCenter: imageItem.horizontalCenter
        anchors.verticalCenter: imageItem.verticalCenter
        font.pixelSize: imageItem.width / 5
        style: Text.Outline
        styleColor: "black"
        visible: movieItem.focus ? true : false
    }

    MouseArea {
        id: mouseArea
        anchors.fill: movieItem
        hoverEnabled: true
        onEntered: {
            movieListView.currentIndex = index
        }
    }
}
