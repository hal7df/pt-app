import QtQuick 2.4

Rectangle {
    id: toolbar

    property string title
    property string subtitle: ""
    property ListModel actions

    signal toggleMenu

    anchors {
        top: parent.top
        right: parent.right
        left: parent.left
    }

    height: parent.height > parent.width ? parent.height/10 : parent.height/5

    color: "#333333"
    clip: true

    IconWidget {
        id: drawerOpen

        anchors.left: parent.left

        iconName: "menu"
        scale: Math.SQRT2

        Component.onCompleted: clicked.connect(toolbar.toggleMenu)
    }

    Text {
        id: titleLabel

        anchors {
            top: parent.top
            left: drawerOpen.right
            bottom: parent.bottom
            rightMargin: height/4
            bottomMargin: parent.subtitle == "" ? 0 : parent.height/4
        }

        text: parent.title
        color: "#ffffff"

        font.pixelSize: parent.subtitle == "" ? height/3 : height/2

        verticalAlignment: Text.AlignVCenter
        scale: paintedWidth > width ? width/paintedWidth : 1
    }

    Text {
        id: subtitleLabel

        anchors {
            top: titleLabel.bottom
            bottom: parent.bottom
            left: titleLabel.left
            topMargin: -parent.height/6
        }

        text: parent.subtitle
        color: "#ffffff"

        font.pixelSize: 4*height/7

        verticalAlignment: Text.AlignVCenter
    }

    /*Row {
        id: organizer

        anchors.fill: parent

    }*/
}

