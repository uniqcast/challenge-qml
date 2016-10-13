import QtQuick 2.6
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

Window {
    visible: true
    id: root
    color: "#171717"

    MovieListModel {
        id: movieModel
    }

    ColumnLayout {

        width: parent.width * 0.95
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        ListView {
            id: movieListView
            Layout.alignment: Qt.AlignCenter
            Layout.preferredHeight: root.height * 0.7
            anchors.fill: parent
            model: movieModel
            boundsBehavior: Flickable.StopAtBounds
            delegate: MovieItem {}
            spacing: root.width / 100
            orientation: ListView.Horizontal
            interactive: true
            focus: true
            highlightMoveVelocity: 1000
            highlightMoveDuration: 100
        }
    }

}
