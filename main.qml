import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    id: root

    property Activity activeActivity: mainPage

    width: 338
    height: 600

    visible: true
    color: "#cecece"

    title: activeActivity.title

    MainPage {
        id: mainPage

        drawer: drawer
    }

    Drawer {
        id: drawer
    }
}
