import QtQuick 2.1
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.0

RowLayout {
    id: expandedVideo
    anchors.top: parent.top
    anchors.topMargin: 5
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
    
    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
    
    ColumnLayout {
        spacing: 5
        
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
    ColumnLayout { // Column for Codec, Bitrate, Resolution & Aspect Ratio
        spacing: 5
        
        RowLayout {
            Text {
                id: videoCodecLabel
                text: qsTr("Codec:")
                width: 55
            }
            
            Controls.Button {
                id: videoCodecSelection
                width: 100
                height: 24
                text: "libxvid"
                icon.name: "go-down"
                onClicked: videoCodecMenu.open()
                enabled: videoDeactivate.checked ? false : true
                VideoCodecList {
                    id: videoCodecMenu
                    parent: videoCodecSelection
                    onCodecChanged: {
                        videoCodecSelection.text = codec
                        videoCodec = codec
                    }
                }
            }
        }
        RowLayout {
            Text {
                id: videoBitrateLabel
                text: qsTr("Bitrate:")
                width: 55
            }
            Controls.Button {
                id: videoBitrateSelection
                width: 100
                height: 24
                text: "777k"
                icon.name: "go-down"
                onClicked: videoBitrateMenu.open()
                enabled: videoDeactivate.checked ? false : true
                VideoBitrateList {
                    id: videoBitrateMenu
                    parent: videoBitrateSelection
                    onBitrateChanged: {
                        if (bitrate != "custom") {
                            videoBitrateSelection.text = bitrate
                            videoBitrate = bitrate
                            videoBitrateCustom.width = 5
                            videoBitrateCustomHint.opacity = 0
                            videoBitrateCustom.opacity = 0
                            
                        }
                        else {
                            videoBitrateSelection.text = bitrate
                            videoBitrateCustom.opacity = 1
                            videoBitrateCustom.width = 100
                            videoBitrateCustomHint.text =  qsTr("Set bitrate")
                            videoBitrateCustomHint.opacity = 1
                            videoBitrateCustom.forceActiveFocus()
                            videoBitrateCustom.focus = true
                        }
                    }
                    
                } // VideoBitrateList
                
            } // Button videoBitrateSelection
        }
        RowLayout {
            
            TextField {
                id: videoBitrateCustom
                width: 5
                opacity: 0
                focus: true
                onAccepted: {
                    videoBitrate = text
                    console.log(videoBitrate)
                    videoBitrateCustomHint.text = qsTr("Bitrate " +  videoBitrate + " set")
                }
                Behavior on width {
                    NumberAnimation { duration: 400 }
                }
                Controls.Button {
                    id: videoBitrateCustomHint
                    opacity: 0
                    Behavior on opacity {
                        NumberAnimation { duration : 800 }
                    }
                    text: qsTr("Set bitrate")
                    onClicked: {
                        if (videoBitrateCustom.text.substr(-1) === "k") {
                            
                        }
                        else {
                            videoBitrateCustom.text = videoBitrateCustom.text + "k"
                        }
                        videoBitrate = videoBitrateCustom.text
                        text = qsTr("Bitrate " +  videoBitrate + " set")
                    }
                }
            } // TextField videoBitrateCustom
        }
        
        RowLayout {
            Text {
                id: videoResolutionLabel
                text: qsTr("Resolution:")
                width: 55
            }
            Controls.Button {
                id: videoResolutionSelection
                width: 100
                height: 24
                text: "no change"
                icon.name: "go-down"
                onClicked: videoResolutionMenu.open()
                enabled: videoDeactivate.checked ? false : true
                ResolutionList {
                    id: videoResolutionMenu
                    parent: videoResolutionSelection
                    onResolutionChanged: {
                        if (resolution != "custom") {
                            videoResolutionSelection.text = resolution
                            videoResolution = resolution
                            videoResolutionCustom.width = 5
                            videoResolutionCustomHint.opacity = 0
                            videoResolutionCustom.opacity = 0
                            
                        }
                        else {
                            videoResolutionSelection.text = resolution
                            videoResolutionCustom.opacity = 1
                            videoResolutionCustom.width = 100
                            videoResolutionCustomHint.text =  qsTr("Set resolution")
                            videoResolutionCustomHint.opacity = 1
                            videoResolutionCustom.forceActiveFocus()
                            videoResolutionCustom.focus = true
                        }
                    }
                    
                } // VideoResolutionList
                
            } // Button videoResolutionSelection
        }
        RowLayout {
            TextField {
                id: videoResolutionCustom
                width: 5
                opacity: 0
                focus: true
                onAccepted: {
                    videoResolution = videoResolutionCustom.text
                    console.log(videoResolution)
                    videoResolutionCustomHint.text = qsTr("Resolution " +  videoResolution + " set")
                }
                Behavior on width {
                    NumberAnimation { duration: 400 }
                }
                Controls.Button {
                    id: videoResolutionCustomHint
                    opacity: 0
                    Behavior on opacity {
                        NumberAnimation { duration : 800 }
                    }
                    text: qsTr("Set resolution")
                    onClicked: {
                        videoResolution = videoResolutionCustom.text
                        text = qsTr("Resolution " +  videoResolution + " set")
                    }
                }
            } // TextField videoBitrateCustom
        }
        RowLayout {
            Text {
                id: aspectLabel
                text: qsTr("Aspect:")
                width: 55
            }
            Controls.Button {
                id: aspectSelection
                width: 100
                height: 24
                text: "no change"
                icon.name: "go-down"
                onClicked: aspectMenu.open()
                enabled: videoDeactivate.checked ? false : true
                AspectList {
                    id: aspectMenu
                    parent: aspectSelection
                    onAspectChanged: {
                        aspectSelection.text = aspect
                        videoAspect = aspect
                    }
                    
                } // aspectList
                
            } // Button aspectSelection
        }
        
        
    } // Column for Codec, Bitrate, ...
    
} // Row Expanded Video
