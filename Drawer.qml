import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {
    id: drawer

    property ListModel tree
    property bool open: false

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    x: -(0.9*width)
    z: 100

    width: parent.height > parent.width ? 0.8*parent.width : 0.4*parent.width

    focus: open

    SequentialAnimation {
        id: openAnimate
         PropertyAnimation { target: drawer; property: "x"; to: 0; easing.type: Easing.OutQuad }
         ScriptAction { script: { drawer.open = true; } }
    }

    SequentialAnimation {
        id: closeAnimate
        PropertyAnimation { target: drawer; property: "x"; to: -(0.9*drawer.width); easing.type: Easing.OutQuad }
        ScriptAction { script: { drawer.open = false; } }
    }

    RectangularGlow {
        anchors.fill: visibleDrawer

        glowRadius: 0.1*parent.width
        color: "#000000"

        visible: parent.x > -(0.9*parent.width)
        opacity: (parent.x+(0.9*parent.width))/(0.9*parent.width)
    }

    Rectangle {
        id: visibleDrawer

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        width: 0.9*parent.width
        color: "#eeeeee"
        antialiasing: true


        onWidthChanged: console.log("Drawer width", width);
    }

    MultiPointTouchArea {
        id: dragArea

        anchors.fill: parent

        minimumTouchPoints: 1
        maximumTouchPoints: 1

        onTouchUpdated: {
            console.log("Touch point differential",(touchPoints[0].x-touchPoints[0].startX));

            if (touchPoints.length == 1 && (touchPoints[0].x-touchPoints[0].startX) <= 0.9*drawer.width)
                drawer.x += (touchPoints[0].x-touchPoints[0].startX);
        }

        onReleased: {
            if (touchPoints.length == 1)
            {
                var point = touchPoints[0];

                if (point.velocity.x > 50)
                    openAnimate.start();
                else if (point.velocity.x < -50)
                    closeAnimate.start();
                else {
                    if (drawer.open)
                    {
                        if (-((point.x-point.startX)+drawer.x)/(0.9*drawer.width) > 0.5)
                            openAnimate.start();
                        else
                            closeAnimate.start();
                    }
                    else
                    {
                        if (-((point.x-point.startX)+drawer.x)/(0.9*drawer.width) < 0.5)
                            closeAnimate.start();
                        else
                            openAnimate.start();
                    }
                }

                console.log("Released");
            }
        }
    }

    function toggle()
    {

    }
}

