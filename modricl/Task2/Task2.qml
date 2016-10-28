import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0

Window
{
    id: root
    visible: true
    height: Screen.height
    width: Screen.width
    visibility: "FullScreen"
    color: "#171717"

    ColumnLayout
    {
        width: parent.width * 0.95
        anchors.centerIn: parent

        ListView
        {
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
            cacheBuffer: 3
        }

        XmlListModel
        {
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
