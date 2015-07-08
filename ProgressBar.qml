import QtQuick 2.4
import QtQuick.Window 2.0

Rectangle {
    id: progressBarContain

    property real progress
    property bool active: false
    readonly property bool indeterminate: progress == -1

    anchors {
        left: parent.left
        right: parent.right
    }

    height: {
        if (Screen.desktopAvailableHeight > Screen.desktopAvailableWidth)
            return 0.003125*Screen.desktopAvailableHeight;
        else
            return 0.003125*Screen.desktopAvailableWidth;
    }

    opacity: active ? 1.0 : 0.0
    visible: opacity != 0.0

    color: "#b2dfdb"

    clip: true
    width: parent.width

    Behavior on opacity {
        PropertyAnimation {}
    }

    Rectangle {
        id: progressBar

        property real widthScale: 0.25
        property int endX: parent.width

        anchors {
            top: parent.top
            bottom: parent.bottom
        }

        color: "#009688"
        width: parent.indeterminate ? widthScale*parent.width : parent.progress*parent.width

        onXChanged: console.log(x,endX)

        SequentialAnimation {
            running: progressBarContain.indeterminate
            loops: Animation.Infinite

            ScriptAction { script: progressBar.x = -0.25*progressBarContain.width }
            ParallelAnimation {
                PropertyAnimation { target: progressBar; property: "x"; to: progressBar.endX; duration: 1500 }
                NumberAnimation { target: progressBar; property: "widthScale"; to: 0.7; duration: 500 }
            }
            ScriptAction { script: progressBar.x = -0.75*progressBarContain.width }
            ParallelAnimation {
                PropertyAnimation { target: progressBar; property: "x"; to: progressBar.endX; duration: 1500 }
                NumberAnimation { target: progressBar; property: "widthScale"; to: 0.25; duration: 500 }
            }
        }
    }
}

