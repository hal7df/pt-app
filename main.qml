import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: root

    width: 338
    height: 600

    visible: true
    color: "#cecece"

    title: "Paul's Tutorials"

    Toolbar {
        id: toolbar

        title: "Paul's Tutorials"
    }

    MainPage {
        id: mainPage

        anchors.top: toolbar.bottom
    }
}
