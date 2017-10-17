import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    height: 500
    width: 1000
    minimumHeight: 400
    minimumWidth: 900
    title: qsTr("Task 1")
    color: "#000"


    Rectangle {
        id: frame
        color: "#333333"
        anchors.centerIn: parent
        height: 320
        width: 900

        Row {
            anchors.top: parent.top
            anchors.topMargin: 10
            id: row
            spacing: 20
            x: 10

            Column {
                id: column1
                focus: true
                KeyNavigation.right: column2
                spacing: 2
                width: 160
                height: 320

                Image {
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column1.focus ? 0.9 : 1
                    antialiasing: true
                    source: "images/hackers.jpg"
                    width: 160
                    height: 250
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column1.focus = true
                    }
                }
                Text {
                    width: parent.width
                    height: column1.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "Hackers (1995)"
                }
                Text {
                    anchors.horizontalCenter: column1.horizontalCenter
                    visible: column1.focus ? true : false
                    color: "white"
                    text: "Rating: 6.2"
                }
            }

            Column {
                id: column2
                KeyNavigation.right: column3
                KeyNavigation.left: column1
                spacing: 2
                width: 160
                height: 320

                    Image {
                        Behavior on scale {NumberAnimation{duration: 100}}
                        scale: column2.focus ? 0.9 : 1
                        antialiasing: true
                        source: "images/master.jpg"
                        width: 160
                        height: 250
                        fillMode: Image.PreserveAspectCrop
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: column2.focus = true
                        }
                    }
                    Text {
                        width: parent.width
                        height: column2.focus ? 35 : 10
                        elide: Text.ElideRight
                        wrapMode: Text.WordWrap
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        text: "Master and Commander: The Far Side of the World (2003)"

                    }
                    Text {
                        anchors.horizontalCenter: column2.horizontalCenter
                        visible: column2.focus ? true : false
                        color: "white"
                        text: "Rating: 7.4"
                    }

            }

            Column {
                id: column3
                KeyNavigation.right: column4
                KeyNavigation.left: column2
                spacing: 2
                width: 160

                Image {
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column3.focus ? 0.9 : 1
                    antialiasing: true
                    source: "images/matrix.jpg"
                    width: 160
                    height: 250
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column3.focus = true
                    }
                }
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    height: column3.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    color: "white"
                    text: "Matrix (1999)"
                }
                Text {
                    anchors.horizontalCenter: column3.horizontalCenter
                    visible: column3.focus ? true : false
                    color: "white"
                    text: "Rating: 8.7"
                }
            }

            Column {
                id: column4
                KeyNavigation.right: column5
                KeyNavigation.left: column3
                spacing: 2
                width: 160

                Image {
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column4.focus ? 0.9 : 1
                    antialiasing: true
                    source: "images/mononoke.jpg"
                    width: 160
                    height: 250
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column4.focus = true
                    }
                }
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    height: column4.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    color: "white"
                    text: "Princess Mononoke (1997)"
                }
                Text {
                    anchors.horizontalCenter: column4.horizontalCenter
                    visible: column4.focus ? true : false
                    color: "white"
                    text: "Rating: 8.4"
                }
            }

            Column {
                id: column5
                KeyNavigation.left: column4
                spacing: 2
                width: 160

                Image {
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column5.focus ? 0.9 : 1
                    antialiasing: true
                    source: "images/pulp.jpg"
                    width: 160
                    height: 250
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column5.focus = true
                    }
                }
                Text {
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    height: column5.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    color: "white"
                    text: "Pulp Fiction (1994)"
                }
                Text {
                    anchors.horizontalCenter: column5.horizontalCenter
                    visible: column5.focus ? true : false
                    color: "white"
                    text: "Rating: 8.9"
                }
            }
        }
    }
}
