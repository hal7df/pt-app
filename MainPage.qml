import QtQuick 2.4

Activity {
    id: page

    signal launchCpp
    signal launchWpi
    signal launchRef

    title: "Paul's Tutorials"
    openDefault: true

    Image {
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: parent.height/20
        }

        source: "qrc:/img/PaulsTutorials.png"
        smooth: true
        height: width
        width: parent.height > parent.width ? parent.width/5 : parent.height/5
    }

    Text {
        anchors {
            bottom: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
            bottomMargin: parent.height/7
        }

        text: "Select an option below."

        font.pixelSize: parent.height/30
        scale: paintedWidth > parent.width ? parent.width/paintedWidth : 1
    }

    GridView {
        id: selectorGrid

        anchors {
            top: parent.verticalCenter
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }

        cellWidth: parent.width > parent.height ? width/2 : width
        cellHeight: parent.width > parent.height ? parent.width/7 : parent.height/6

        clip: true

        interactive: height < count*cellHeight
        boundsBehavior: Flickable.StopAtBounds

        model: optionModel

        delegate: Card {

            width: selectorGrid.cellWidth
            height: selectorGrid.cellHeight

            Text {
                id: sym

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    margins: parent.height/10
                }

                text: symbol

                font {
                    pixelSize: height*0.75
                    bold: true
                }

            }

            Text {
                anchors {
                    right: parent.right
                    left: sym.right
                    leftMargin: parent.width/20
                    top: parent.top
                }

                height: 0.6*parent.height
                width: parent.width-(parent.height+(parent.width/20))

                text: optTitle

                elide: Text.ElideRight

                font.pixelSize: 0.75*height
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                anchors {
                    right: parent.right
                    left: sym.right
                    leftMargin: parent.width/20
                    bottom: parent.bottom
                }

                height: 0.4*parent.height
                width: parent.width-(parent.height+(parent.width/20))

                text: subtitle

                elide: Text.ElideRight

                font.pixelSize: 0.8*height
                verticalAlignment: Text.AlignVCenter
            }

        }
    }

    ListModel {
        id: optionModel
        ListElement {
            symbol: "C++"
            optTitle: "C++ Guided Tutorial"
            subtitle: "Basics of C++"
        }

        ListElement {
            symbol: "WPI"
            optTitle: "WPILib Tutorial"
            subtitle: "FRC WPILib/C++ robot programming"
        }

        ListElement {
            symbol: "REF"
            optTitle: "WPILib Reference"
            subtitle: "WPILib doxygen"
        }
    }
}

