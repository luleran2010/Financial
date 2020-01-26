import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 300
    height: 460
    anchors.fill: parent

    property alias delegate: listView.delegate
    property alias model: listView.model

    title: qsTr("Home")

    ListView {
        id: listView
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
