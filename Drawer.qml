import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {
    id: drawer

    property ListModel tree
    property bool open: false
    property real drawerWidth: parent.height > parent.width ? 0.75*parent.width : 0.4*parent.width
    property real baseWidth: drawerWidth + drawerHandle
    property real addedWidth: (parent.width - baseWidth)*((x + drawerWidth)/drawerWidth)
    property real drawerHandle: parent.height > parent.width ? 0.05*parent.width : 0.035*parent.width

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    x: -drawerWidth
    z: 100

    width: baseWidth + addedWidth

    focus: open

    SequentialAnimation {
        id: openAnimate
         PropertyAnimation { target: drawer; property: "x"; to: 0; easing.type: Easing.OutQuad }
         ScriptAction { script: { drawer.open = true; } }
    }

    SequentialAnimation {
        id: closeAnimate
        PropertyAnimation { target: drawer; property: "x"; to: -(drawer.drawerWidth); easing.type: Easing.OutQuad }
        ScriptAction { script: { drawer.open = false; } }
    }

    RectangularGlow {
        anchors.fill: visibleDrawer

        glowRadius: 0.1*parent.width
        color: "#000000"

        visible: parent.x > -(parent.drawerWidth)
        opacity: (parent.x+parent.drawerWidth)/(parent.drawerWidth)
    }

    Rectangle {
        id: visibleDrawer

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        width: parent.drawerWidth
        color: "#eeeeee"
        antialiasing: true

        Item {
            id: drawerHeader

            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
            }

            height: parent.height/5
            clip: true

            Rectangle {
                anchors.fill: parent
                anchors.rightMargin: -1

                color: "#000000"
            }

            Image {
                anchors {
                    top: parent.top
                    right: parent.right
                    left: parent.left
                    verticalCenter: parent.bottom
                }

                source: "qrc:/img/PaulsTutorials.png"
                smooth: true

                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                anchors {
                    top: parent.verticalCenter
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#00000000" }
                    GradientStop { position: 1.0; color: "#dd000000" }
                }

                Text {
                    anchors {
                        left: parent.left
                        bottom: parent.bottom
                        margins: parent.height/5
                    }

                    color: "#ffffff"

                    text: "Paul's Tutorials"

                    font.pixelSize: parent.height/2
                }
            }
        }
    }

    MouseArea {
        id: dragArea

        anchors.fill: parent

        drag {
            axis: Drag.XAxis
            target: drawer
            minimumX: -drawer.drawerWidth
            maximumX: 0
            filterChildren: true
        }

        onReleased: {
            var threshold;

            if (parent.open)
                threshold = -(parent.drawerWidth/4);
            else
                threshold = -3*(parent.drawerWidth/4);

            if (parent.x < threshold)
                closeAnimate.start();
            else
                openAnimate.start();
        }
    }

    function toggle()
    {
        if (open)
            closeAnimate.start();
        else
            openAnimate.start();
    }
}

