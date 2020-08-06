import QtQuick 2.1
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.0

RowLayout {
    id: expandedVideo
    anchors.top: parent.top
    anchors.topMargin: 15
    anchors.left: parent.left
    anchors.leftMargin: 10
    anchors.right: parent.right
    anchors.rightMargin: 10
    width: parent.width - 15
    height: parent.height - 15
    anchors.verticalCenter: parent.verticalCenter
    opacity: 0
    spacing: 15
    property alias videoDeactivate: videoDeactivate
    property alias videoMultithreading: videoMultithreading
    property alias video2pass: video2pass
    property alias videoCodecSelection: vCodecBitrateSettings.videoCodecSelection
    property alias videoBitrateSelection: vCodecBitrateSettings.videoBitrateSelection
    property alias videoResolutionSelection: vCodecBitrateSettings.videoResolutionSelection
    
    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
    
    ColumnLayout {
        Layout.row: 0
        width: parent.width / 2
        visible: parent.opacity != 0
        
        Text {
            id: expandedVideoHeader
            font.bold: true
            text: videoDeactivate.checked ? qsTr("     Video: deactivated") : qsTr("     Video:")
        }
        Image {
            id: videoIcon
            source: "img/video-x-generic.png"
        }
        
        id: videoCheckboxes
        
        Controls.CheckBox {
            id: videoDeactivate
            text: "Deactivate Video"
        }
        Controls.CheckBox {
            id: video2pass
            enabled: videoDeactivate.checked ? false : true
            text: "2 Pass"
        }
        Controls.CheckBox {
            id: videoMultithreading
            enabled: videoDeactivate.checked ? false : true
            checked: true // A sane default
            text: "Multithreading"
        }
    } // Column for icon and checkboxes
    VideoCodecBitrateSettings {
        id: vCodecBitrateSettings
        visible: parent.opacity != 0
    }
    
} // Row Expanded Video
