import QtQuick 2.4

Item {
    id: widget

    property string iconName
    property bool disabled

    signal clicked
    signal pressAndHold

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    width: height

    Rectangle {
        id: back

        anchors.fill: parent

        radius: height/2

        color: "#dfdfdf"
        opacity: 0.0

        states: State {
            name: "pressed"; when: touch.pressed
            PropertyChanges { target: back; opacity: 0.3 }
        }

        transitions: Transition {
            from: ""; to: "pressed"; reversible: true
            NumberAnimation { target: back; property: "opacity"; duration: 50 }
        }
    }

    RippleTouchArea {
        id: touch

        enabled: !parent.disabled

        Component.onCompleted: {
            clicked.connect(parent.clicked);
            pressAndHold.connect(parent.pressAndHold);
        }
    }

    Image {
        id: icon

        anchors {
            fill: parent
            margins: parent.width*0.29289322
        }

        fillMode: Image.PreserveAspectFit
        smooth: true

        source: {
            if (height <= 18)
                return "qrc:/icon/ic_"+parent.iconName+"-18dp.png";
            else if (height > 18 && height <= 24)
                return "qrc:/icon/ic_"+parent.iconName+"-24dp.png";
            else if (height > 24 && height <= 36)
                return "qrc:/icon/ic_"+parent.iconName+"-36dp.png";
            else if (height > 36 && height <= 48)
                return "qrc:/icon/ic_"+parent.iconName+"-48dp.png";
            else if (height > 48 && height <= 72)
                return "qrc:/icon/ic_"+parent.iconName+"-72dp.png";
            else if (height > 72)
                return "qrc:/icon/ic_"+parent.iconName+"-96dp.png";
            else
                return "";
        }
    }
}

