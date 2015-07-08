import QtQuick 2.4

Item {
    id: activity

    default property alias mainContents: contents.data
    property alias actions: toolbar.actions

    property alias title: toolbar.title
    property alias subtitle: toolbar.subtitle

    property bool openDefault: false
    property Drawer drawer

    readonly property real animateStart: (parent.y/3)

    anchors.fill: parent

    x: 0
    y: 0

    opacity: openDefault ? 1.0 : 0.0
    visible: openDefault
    focus: visible

    Keys.onReleased: {
        if (event.key == Qt.Key_Back)
        {
            event.accepted = true;
            close();
        }
    }


    ParallelAnimation {
        id: enter
        PropertyAnimation { target: activity; property: "y"; from: activity.animateStart; to: 0; easing.type: Easing.OutQuad }
        NumberAnimation { target: activity; property: "opacity"; from: 0.0; to: 1.0 }
    }

    SequentialAnimation {
        id: exit
        ParallelAnimation {
            PropertyAnimation { target: activity; property: "y"; from: 0; to: activity.animateStart; easing.type: Easing.InQuad }
            NumberAnimation { target: activity; property: "opacity"; from: 1.0; to: 0.0 }
        }
        ScriptAction {
            script: { visible = false; }
        }
    }

    Toolbar {
        id: toolbar

        onToggleMenu: drawer.toggle()
    }

    Rectangle {
        id: contents

        anchors {
            top: toolbar.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }

        color: "#cecece"
    }

    function open()
    {
        opacity = 0.0;
        visible = true;
        y = animateStart;

        enter.start();
    }

    function close()
    {
        if (!openDefault)
            exit.start();
        else
            Qt.quit();

        console.log("Close function called.");
    }
}

