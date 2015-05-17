import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: root

    width: 338
    height: 600

    visible: true
    color: "#cecece"

    Toolbar {
        id: toolbar

        title: "Paul's Tutorials"
        subtitle: "Learn Programming"
    }

    MainPage {
        id: mainPage

        anchors.top: toolbar.bottom
    }
}
