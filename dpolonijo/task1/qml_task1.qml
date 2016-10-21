import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    title: qsTr("Task 1")
    visibility: "Maximized"
    id: root
    color: "#000"

    Rectangle {
        id: posters_wrap
        color: "#151515"
        width: parent.width * 0.8
        height: parent.height * 0.5
        anchors.centerIn: parent

        Row {
            id: row
            spacing: 20
            x: 20
            width: (parent.width - x)
            height: parent.height - 40
            anchors.verticalCenter: parent.verticalCenter

            Column {
                width: parent.width / 5 - row.spacing
                height: parent.height

                Image {
                    focus: true
                    id: p1
                    width: parent.width
                    height: parent.height * 0.96
                    source: "img/hobbit.jpg"

                    Text {
                        text: p1.focus ? "6.8" : ""
                        color: "#fff"
                        font.pixelSize: parent.width / 5
                        anchors.centerIn: parent
                    }

                    MouseArea {
                           anchors.fill: parent
                           hoverEnabled: true
                           cursorShape: Qt.PointingHandCursor                        
                           onEntered: {
                                p1.focus = true
                           }
                           onExited: {
                                p1.focus = true
                           }
                    }

                    scale: activeFocus ? 1.02 : 1

                    Behavior on scale { NumberAnimation { duration: 200 } }

                    KeyNavigation.right: p2
                    KeyNavigation.left: p5
                }

                Text {
                        text: "The Hobbit"
                        font.pixelSize: parent.width * 0.05;
                        color: "white"
                        topPadding: 10
                }

            }

            Column {
                width: parent.width / 5 - row.spacing
                height: parent.height

                Image {
                    id: p2
                    width: parent.width
                    height: parent.height * 0.96
                    source: "img/son_of_god.jpg"

                    Text {
                        text: p2.focus ? "7.2" : ""
                        color: "#fff"
                        font.pixelSize: parent.width / 5
                        anchors.centerIn: parent
                    }

                    MouseArea {
                           anchors.fill: parent
                           hoverEnabled: true
                           cursorShape: Qt.PointingHandCursor
                           onEntered: {
                                p2.focus = true
                           }
                           onExited: {
                                p2.focus = true
                           }
                    }

                    scale: activeFocus ? 1.02 : 1
                    Behavior on scale { NumberAnimation { duration: 200 } }

                    KeyNavigation.right: p3
                    KeyNavigation.left: p1
                }

                Text {
                        text: "Son of God"
                        font.pixelSize: parent.width * 0.05;
                        color: "white"
                        topPadding: 10
                }
            }

            Column {
                width: parent.width / 5 - row.spacing
                height: parent.height

                Image {
                    id: p3
                    width: parent.width
                    height: parent.height * 0.96
                    source: "img/tarzan.jpg"

                    Text {
                        text: p3.focus ? "5.9" : ""
                        color: "#fff"
                        font.pixelSize: parent.width / 5
                        anchors.centerIn: parent
                    }

                    MouseArea {
                           anchors.fill: parent
                           hoverEnabled: true
                           cursorShape: Qt.PointingHandCursor
                           onEntered: {
                                p3.focus = true
                           }
                           onExited: {
                                p3.focus = true
                           }
                    }

                    scale: activeFocus ? 1.02 : 1

                    Behavior on scale { NumberAnimation { duration: 200 } }

                    KeyNavigation.right: p4
                    KeyNavigation.left: p2
                }

                Text {
                        text: "Tarzan"
                        font.pixelSize: parent.width * 0.05;
                        color: "white"
                        topPadding: 10
                }
            }

            Column {
                width: parent.width / 5 - row.spacing
                height: parent.height

                Image {
                    id: p4
                    width: parent.width
                    height: parent.height * 0.96
                    source: "img/ride_along.jpg"

                    Text {
                        text: p4.focus ? "8.1" : ""
                        color: "#fff"
                        font.pixelSize: parent.width / 5
                        anchors.centerIn: parent
                    }

                    MouseArea {
                           anchors.fill: parent
                           hoverEnabled: true
                           cursorShape: Qt.PointingHandCursor
                           onEntered: {
                                p4.focus = true
                           }
                           onExited: {
                                p4.focus = true
                           }
                    }

                    scale: activeFocus ? 1.02 : 1
                    Behavior on scale { NumberAnimation { duration: 200 } }

                    KeyNavigation.right: p5
                    KeyNavigation.left: p3
                }

                Text {
                        text: "Ride Along"
                        font.pixelSize: parent.width * 0.05;
                        color: "white"
                        topPadding: 10
                }
            }

            Column {
                width: parent.width / 5 - row.spacing
                height: parent.height

                Image {
                    id: p5
                    width: parent.width
                    height: parent.height * 0.96
                    source: "img/wolf_of_wall_street.jpg"

                    Text {
                        text: p5.focus ? "7.1" : ""
                        color: "#fff"
                        font.pixelSize: parent.width / 5
                        anchors.centerIn: parent
                    }

                    MouseArea {
                           anchors.fill: parent
                           hoverEnabled: true
                           cursorShape: Qt.PointingHandCursor
                           onEntered: {
                                p5.focus = true
                           }
                           onExited: {
                                p5.focus = true
                           }
                    }

                    scale: activeFocus ? 1.02 : 1
                    Behavior on scale { NumberAnimation { duration: 200 } }

                    KeyNavigation.right: p1
                    KeyNavigation.left: p4
                }

                Text {
                        text: "The wolf of Wall Street"
                        font.pixelSize: parent.width * 0.05;
                        color: "white"
                        topPadding: 10
                }
            }

        }
    }
}
