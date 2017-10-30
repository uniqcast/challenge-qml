import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    height: 500
    width: 1000
    minimumHeight: 500
    minimumWidth: 900
    title: qsTr("Task 1")
    color: "#000"

    Rectangle {
        id: frame
        color: "#333333"
        anchors.centerIn: parent
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height-100
        width: parent.width-100

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.topMargin: 10
            id: row

            Rectangle {
                id: column1
                focus: true
                KeyNavigation.right: column2
                width: frame.width/5
                color: "#333333"
                height: width*1.6
                Image {
                    id: image1
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column1.focus ? 1 : 0.9
                    source: "images/hackers.jpg"
                    anchors.top: parent.top
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column1.focus = true
                    }
                }
                Text {
                    id: text1
                    anchors.top: image1.bottom
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
                    anchors.top: text1.bottom

                    anchors.horizontalCenter: column1.horizontalCenter
                    visible: column1.focus ? true : false
                    color: "white"
                    text: "Rating: 6.2"
                }
            }
            Rectangle {
                id: column2
                KeyNavigation.right: column3
                KeyNavigation.left: column1
                width: frame.width/5
                color: "#333333"
                height: width*1.6
                Image {
                    id: image2
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column2.focus ? 1 : 0.9
                    source: "images/master.jpg"
                    anchors.top: parent.top
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column2.focus = true
                    }
                }
                Text {
                    id: text2
                    anchors.top: image2.bottom
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
                    anchors.top: text2.bottom

                    anchors.horizontalCenter: column2.horizontalCenter
                    visible: column2.focus ? true : false
                    color: "white"
                    text: "Rating: 7.4"
                }
            }
            Rectangle {
                id: column3
                KeyNavigation.right: column4
                KeyNavigation.left: column2
                width: frame.width/5
                color: "#333333"
                height: width*1.6
                Image {
                    id: image3
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column3.focus ? 1 : 0.9
                    source: "images/matrix.jpg"
                    anchors.top: parent.top
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column3.focus = true
                    }
                }
                Text {
                    id: tex3
                    anchors.top: image3.bottom
                    width: parent.width
                    height: column3.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "Matrix (1999)"
                }
                Text {
                    anchors.top: tex3.bottom

                    anchors.horizontalCenter: column3.horizontalCenter
                    visible: column3.focus ? true : false
                    color: "white"
                    text: "Rating: 8.7"
                }
            }
            Rectangle {
                id: column4
                KeyNavigation.right: column5
                KeyNavigation.left: column3
                width: frame.width/5
                color: "#333333"
                height: width*1.6
                Image {
                    id: image4
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column4.focus ? 1 : 0.9
                    source: "images/mononoke.jpg"
                    anchors.top: parent.top
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column4.focus = true
                    }
                }
                Text {
                    id: text4
                    anchors.top: image4.bottom
                    width: parent.width
                    height: column4.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "Princess Mononoke (1997)"
                }
                Text {
                    anchors.top: text4.bottom

                    anchors.horizontalCenter: column4.horizontalCenter
                    visible: column4.focus ? true : false
                    color: "white"
                    text: "Rating: 8.4"
                }
            }
            Rectangle {
                id: column5
                KeyNavigation.left: column4
                width: frame.width/5
                color: "#333333"
                height: width*1.6
                Image {
                    id: image5
                    Behavior on scale {NumberAnimation{duration: 100}}
                    scale: column5.focus ? 1 : 0.9
                    source: "images/pulp.jpg"
                    anchors.top: parent.top
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: column5.focus = true
                    }
                }
                Text {
                    id: text5
                    anchors.top: image5.bottom
                    width: parent.width
                    height: column5.focus ? 35 : 10
                    elide: Text.ElideRight
                    wrapMode: Text.WordWrap
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    text: "Pulp Fiction (1994)"
                }
                Text {
                    anchors.top: text5.bottom

                    anchors.horizontalCenter: column5.horizontalCenter
                    visible: column5.focus ? true : false
                    color: "white"
                    text: "Rating: 8.9"
                }
            }

        }
    }
}
