import QtQuick 2.4
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0

Item {
    id: cardContain

    property alias color: card.color
    property bool toggled: false
    default property alias contents: card.data

    signal clicked
    signal pressAndHold

    width: 100
    height: 62

    Rectangle {
        id: card

        anchors.fill: parent
        anchors.margins: parent.width/20

        color: "#ffffff"
        clip: true

        radius: Screen.desktopAvailableHeight/320

        states: [ State {
            name: "pressed"; when: rippleTouch.pressed
            PropertyChanges { target: card; color: "#dfdfdf" }
        },
            State {
                name: "toggled"; when: cardContain.toggled
                PropertyChanges { target: card; color: "#c3c3c3" }
            }

        ]

        transitions: [ Transition {
            from: ""; to: "pressed"; reversible: true
            ColorAnimation { duration: 50 }
        },
            Transition {
                from: ""; to: "toggled"
                ColorAnimation { duration: 1000 }
            }

        ]

        RippleTouchArea {
            id: rippleTouch

            fillParent: true
            opacity: 1.0

            Component.onCompleted: {
                clicked.connect(cardContain.clicked);
                pressAndHold.connect(cardContain.pressAndHold);
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

