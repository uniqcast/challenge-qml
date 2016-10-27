import QtQuick 2.7
import QtGraphicalEffects 1.0

Rectangle {
    id: movieItem
    width: movieGridView.cellWidth - 5
    height: movieGridView.cellHeight - 5
    opacity: movieItem.focus ? 1 : 0.5
    color: "#00000000"

    Image {
        id: imageItem
        width: movieItem.width
        height: movieItem.height * 0.88
        fillMode: movieItem.focus ? Image.Stretch : Image.PreserveAspectCrop
        anchors.left: parent.left
        source: movieItem.focus ? "https://image.tmdb.org/t/p/w500" + poster_path : "https://image.tmdb.org/t/p/w500" + backdrop_path
        opacity: movieItem.focus ? 1 : 0.5
    }

    Rectangle {
        id: nameTextContainer
        width: childrenRect.width * 1.2
        height: childrenRect.height
        anchors.left: imageItem.left
        anchors.bottom: imageItem.bottom
        color: "#000"
        z: 10
        Text {
            id: nameText
            color: "#ffffff"
            font.pixelSize: movieItem.width / 15
            text: original_title
            width: movieItem.width
            leftPadding: movieItem.width / 50
            elide: Text.ElideRight
        }
    }

    Text {
        id: yearText
        anchors.right: imageItem.right
        anchors.rightMargin: movieItem.width / 50
        anchors.bottom: movieItem.bottom
        anchors.bottomMargin: movieItem.width / 35
        font.pixelSize: movieItem.width / 18
        color: "#ffffff"
        text: Qt.formatDateTime(new Date(release_date), "yyyy")
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
        anchors.bottom: movieItem.bottom
        anchors.bottomMargin: movieItem.width / 35
        anchors.left: imageItem.left
        anchors.leftMargin: movieItem.width / 50
        font.pixelSize: imageItem.width / 18
        color: "#ffffff"
        text: vote_average
    }

    MouseArea {
        anchors.fill: movieItem
        onClicked: {
            movieGridView.currentIndex = index
        }
    }
}
