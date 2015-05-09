import QtQuick 2.4
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    id: cardContain

    property alias color: card.color
    default property alias contents: card.data

    signal clicked

    width: 100
    height: 62

    Rectangle {
        id: card

        anchors.fill: parent
        anchors.margins: parent.width/20

        color: "#ffffff"
        clip: true

        radius: Screen.desktopAvailableHeight/320

        states: State {
            name: "pressed"; when: area.pressed
            PropertyChanges { target: card; color: "#dfdfdf" }
        }

        transitions: Transition {
            from: ""; to: "pressed"; reversible: true
            ColorAnimation { duration: 50 }
        }

        Rectangle {
            id: ripple

            property real centerX
            property real centerY

            x: centerX - (width/2)
            y: centerY - (height/2)

            radius: width/2
            height: width
            width: 0

            opacity: 1.0
            color: "#c3c3c3"

            ParallelAnimation {
                id: rippleAnimation
                NumberAnimation { target: ripple; property: "opacity"; to: 1.0; duration: 100 }
                NumberAnimation { target: ripple; property: "width"; to: card.width > card.height ? card.width*3 : card.height*3; duration: 1500 }
                NumberAnimation { target: ripple; property: "x"; to: (-card.width/4); duration: 1500 }
            }

            SequentialAnimation {
                id: fastAnimation

                ParallelAnimation {
                    NumberAnimation { target: ripple; property: "opacity"; to: 0.0; duration: 200; easing.type: Easing.InSine }
                    NumberAnimation { target: ripple; property: "width"; to: card.width > card.height ? card.width*3 : card.height*3; duration: 200 }
                    NumberAnimation { target: ripple; property: "x"; to: (-card.width/4); duration: 200 }
                }

                ScriptAction {
                    script: {
                        ripple.width = 0;
                    }
                }
            }
        }

        MouseArea {
            id: area

            anchors.fill: parent
            z: 30

            Component.onCompleted: {
                clicked.connect(cardContain.clicked);
            }

            onPressAndHold: {
                ripple.centerX = mouse.x;
                ripple.centerY = mouse.y;

                rippleAnimation.start();

                mouse.accepted = true;
            }

            onReleased: {
                if (rippleAnimation.running)
                {
                    rippleAnimation.stop();
                    fastAnimation.start();
                }
                else
                {
                    ripple.width = 0;
                    ripple.opacity = 0.0;
                }
            }
        }
    }

    DropShadow {
        anchors.fill: card

        verticalOffset: card.radius

        radius: 8
        smooth: true
        samples: 16

        color: "#30000000"
        source: card
    }
}

