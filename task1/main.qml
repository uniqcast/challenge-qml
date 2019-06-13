import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id:root
    visible: true
    width: 1920
    height: 1080
    title: qsTr("Task 1")
    color: "#676767"

    // row of movies
    Row{
        spacing: 10
        leftPadding: 10
        rightPadding: 10
        anchors.centerIn: parent

        // 1. film Detective Pikachu
        Image{
            id: pikachu
            source: "images/pikachu_poster.jpg"
            fillMode: Image.PreserveAspectFit
            width: root.width / 5 - 10
            height: root.height / 1.5

            focus: true
            scale: focus ? 1.02 : 1
            KeyNavigation.right: phoenix

            MouseArea{
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onEntered: parent.focus = true
            }

            Text {
                id: pikachutxt
                text: parent.focus ? "Name: Detective Pikachu\nYear: 2019\nRating 7/10" : "Name: Detective Pikachu\nYear: 2019"
                anchors.top: parent.bottom
                width: parent.width
                font.pointSize: 12
                color: "white"
            }
        }

        // 2. film X-Men: Dark Phoenix
        Image{
            id: phoenix
            source: "images/phoenix_poster.jpg"
            fillMode: Image.PreserveAspectFit
            width: root.width / 5 - 10
            height: root.height / 1.5

            scale: focus ? 1.02 : 1
            KeyNavigation.left: pikachu
            KeyNavigation.right: mib

            MouseArea{
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onEntered: parent.focus = true
            }

            Text {
                id: phoenixtxt
                text: parent.focus ? "Name: X-Men: Dark Phoenix\nYear: 2019\nRating 7.5/10" : "Name: X-Men: Dark Phoenix\nYear: 2019"
                anchors.top: parent.bottom
                width: parent.width
                font.pointSize: 12
                color: "white"
            }
        }

        // 3. film Men In Black International
        Image{
            id: mib
            source: "images/mib_poster.jpg"
            fillMode: Image.PreserveAspectFit
            width: root.width / 5 - 10
            height: root.height / 1.5

            scale: focus ? 1.02 : 1
            KeyNavigation.left: phoenix
            KeyNavigation.right: spiderman

            MouseArea{
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onEntered: parent.focus = true
            }

            Text {
                id: mibtxt
                text: parent.focus ? "Name: Men In Black International\nYear: 2019\nRating 9/10" : "Name: Men In Black International\nYear: 2019"
                anchors.top: parent.bottom
                width: parent.width
                font.pointSize: 12
                color: "white"
            }
        }

        // 4. film Spider-Man: Far From Home
        Image{
            id: spiderman
            source: "images/spiderman_poster.jpg"
            fillMode: Image.PreserveAspectFit
            width: root.width / 5 - 10
            height: root.height / 1.5

            scale: focus ? 1.02 : 1
            KeyNavigation.left: mib
            KeyNavigation.right: wick3

            MouseArea{
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onEntered: parent.focus = true
            }

            Text {
                id: spidermantxt
                text: parent.focus ? "Name: Spider-Man: Far From Home\nYear: 2019\nRating 10/10" : "Name: Spider-Man: Far From Home\nYear: 2019"
                anchors.top: parent.bottom
                width: parent.width
                font.pointSize: 12
                color: "white"
            }
        }

        // 5. film John Wick 3
        Image{
            id: wick3
            source: "images/wick3_poster.jpg"
            fillMode: Image.PreserveAspectFit
            width: root.width / 5 - 10
            height: root.height / 1.5

            scale: focus ? 1.02 : 1
            KeyNavigation.left: spiderman

            MouseArea {
                width: parent.width
                height: parent.height
                hoverEnabled: true
                onEntered: parent.focus = true
            }

            Text {
                id: wick3txt
                text: parent.focus ? "Name: John Wick 3\nYear: 2019\nRating 8/10" : "Name: John Wick 3\nYear: 2019"
                anchors.top: parent.bottom
                width: parent.width
                font.pointSize: 12
                color: "white"
            }
        }
    } // row
}// window
