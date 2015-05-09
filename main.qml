import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    color: "#cecece"

    Card {
        id: card

        height: parent.height/4

        anchors.fill: parent

        Text {
            text: "Hello World! I'm a Card!"

            anchors.centerIn: parent
        }
    }
}
