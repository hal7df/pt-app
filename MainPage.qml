import QtQuick 2.4

Item {
    id: page

    anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }

    signal launchCpp
    signal launchWpi
    signal launchRef

    Image {
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: parent.height/20
        }

        source: "qrc:/img/PaulsTutorials.png"
        smooth: true
        height: width
        width: parent.height > parent.width ? parent.width/5 : parent.height/5
    }
}

