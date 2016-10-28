import QtQuick 2.7
import QtGraphicalEffects 1.0

Rectangle
{
    id: movieItem
    width: ( movieListView.width / ( movieListView.width > 300 ? 5 : 3 ) ) - movieListView.spacing
    height: imageItem.height
    scale: ListView.isCurrentItem ? 1 : 0.9
    Behavior on scale { NumberAnimation { duration: 200 } }

    Image
    {
        id: imageItem
        width: movieItem.width
        fillMode: Image.PreserveAspectFit
        source: imagePath
    }

    Text
    {
        id: nameText
        anchors.top: imageItem.bottom
        anchors.topMargin: movieItem.width / 35
        font.pixelSize: movieItem.width / 10
        color: "#ffffff"
        text: movieName
    }

    Text
    {
        id: yearText
        anchors.top: nameText.bottom
        anchors.topMargin: movieItem.width / 50
        font.pixelSize: movieItem.width / 15
        color: "#ffffff"
        text: movieYear
    }


    DropShadow
    {
        id: shadowItem
        anchors.fill: imageItem
        horizontalOffset: movieItem.width / 100
        verticalOffset: movieItem.width / 100
        radius: movieItem.width / 50
        samples: 20
        color: "#80000000"
        source: imageItem
    }

    Text
    {
        id: ratingText
        visible: movieItem.focus ? true : false
        anchors.centerIn: parent
        font.pixelSize: imageItem.width / 5
        style: Text.Outline
        styleColor: "black"
        color: "#ffffff"
        text: movieRating
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered:
        {
            movieListView.currentIndex = index
        }
    }
}
