import QtQuick 2.6
import QtQuick.Window 2.0

Window {
    visible: true
    id: root
    color: "#292929"

    MovieListModel {
        id: movieModel
    }

    ListView {
        id: movieListView
        anchors.fill: parent
        model: movieModel
        delegate: MovieItem {}
        spacing: 10
        orientation: ListView.Horizontal
        interactive: true
        highlight: Component {
            SelectedItem {}
        }
        focus: true
        highlightMoveVelocity: 1000
        highlightMoveDuration: 100
    }
}
