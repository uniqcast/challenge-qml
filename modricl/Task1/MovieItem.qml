import QtQuick 2.6
import QtGraphicalEffects 1.0

Rectangle {
    id: movieItem
    width: (root.width / movieListView.count) - movieListView.spacing
    color: "#00000000"
    height: imageItem.height

    MouseArea {
        anchors.fill: parent
        onClicked: movieListView.currentIndex = index
    }

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
        anchors.topMargin: 10
    }

    Text {
        id: yearText
        color: "#ffffff"
        text: movieYear
        anchors.left: imageItem.left
        anchors.leftMargin: 0
        anchors.top: nameText.bottom
        anchors.topMargin: 10
        font.pixelSize: movieItem.width / 15
    }

    DropShadow {
        id: shadowItem
        anchors.fill: imageItem
        horizontalOffset: 5
        verticalOffset: 5
        radius: 8.0
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
        anchors.fill: movieItem
        onClicked: {
            movieListView.currentIndex = index
        }
    }
}
