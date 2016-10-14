import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0

Window {
    visible: true
    id: root
    color: "#171717"
    width: Screen.width
    height: Screen.height

    ColumnLayout {
        width: parent.width * 0.95
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        ListView {
            id: movieListView
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: root.height * 0.7
            anchors.fill: parent
            model: xmlModel
            boundsBehavior: Flickable.StopAtBounds
            delegate: MovieItem {}
            spacing: root.width / 200
            orientation: ListView.Horizontal
            interactive: true
            focus: true
            highlightMoveVelocity: 1000
            highlightMoveDuration: 100
            cacheBuffer: 3
        }

        XmlListModel {
            id: xmlModel
            source: "movies.xml"
            query: "/root/movie"

            XmlRole { name: "imagePath"; query: "imagePath/string()" }
            XmlRole { name: "movieName"; query: "movieName/string()" }
            XmlRole { name: "movieYear"; query: "movieYear/string()" }
            XmlRole { name: "movieRating"; query: "movieRating/string()" }
        }
    }
}

