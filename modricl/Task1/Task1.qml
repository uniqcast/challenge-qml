import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window
{
    id: root
    visible: true
    height: Screen.height
    width: Screen.width
    visibility: "FullScreen"
    color: "#171717"

    MovieListModel
    {
        id: movieModel
    }

    ColumnLayout
    {
        width: parent.width * 0.95
        anchors.centerIn: parent

        ListView
        {
            id: movieListView
            Layout.preferredHeight: root.height * 0.7
            anchors.fill: parent
            model: movieModel
            boundsBehavior: Flickable.StopAtBounds
            delegate: MovieItem {}
            spacing: root.width / 100
            orientation: ListView.Horizontal
            interactive: true
            focus: true
        }
    }

}
