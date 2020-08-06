import QtQuick 2.1
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.0

GridLayout { // Column for Codec, Bitrate, Resolution & Aspect Ratio
    Layout.row: 1
    columns: 3
    rows: 6
    
    property alias videoCodecSelection: videoCodecSelection
    property alias videoBitrateSelection: videoBitrateSelection
    property alias videoResolutionSelection: videoResolutionSelection

        Text {
            id: videoCodecLabel
            text: qsTr("Codec:")
            width: 55
            Layout.row: 0
            Layout.column: 0
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
            Layout.row: 0
            Layout.column: 1
        }
    
        Text {
            id: videoBitrateLabel
            text: qsTr("Bitrate:")
            width: 55
            Layout.row: 1
            Layout.column: 0
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
                        videoBitrateCustom.opacity = 0
                        
                    }
                    else {
                        videoBitrateSelection.text = bitrate
                        videoBitrateCustom.opacity = 1
                        videoBitrateCustom.width = videoBitrateSelection.width * 1.25
                        videoBitrateCustom.forceActiveFocus()
                        videoBitrateCustom.focus = true
                    }
                }
                
            } // VideoBitrateList
            Layout.row: 1
            Layout.column: 1
        } // Button videoBitrateSelection


        
        TextField {
            id: videoBitrateCustom
            width: 5
            opacity: 0
            focus: true
            onAccepted: {
                if (text != "") { 
                    if (text.substr(-1) !== "k") {
                        text += "k"
                    }
                }
                videoBitrate = text
                console.log(videoBitrate)
                //videoBitrateCustomHint.text = qsTr("Bitrate " +  videoBitrate + " set")
            }
            Behavior on width {
                NumberAnimation { duration: 400 }
            }
            Layout.row: 1
            Layout.column: 2
            Layout.maximumWidth: videoBitrateSelection.width * 1.25
        } // TextField videoBitrateCustom

    
        Text {
            id: videoResolutionLabel
            text: qsTr("Resolution:")
            width: 55
            Layout.row: 3
            Layout.column: 0
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
                        videoResolutionCustom.opacity = 0
                        
                    }
                    else {
                        videoResolutionSelection.text = resolution
                        videoResolutionCustom.opacity = 1
                        videoResolutionCustom.width = videoBitrateSelection.width * 1.25
                        videoResolutionCustom.forceActiveFocus()
                        videoResolutionCustom.focus = true
                    }
                }
                
            } // VideoResolutionList
            Layout.row: 3
            Layout.column: 1
            
        } // Button videoResolutionSelection

        TextField {
            id: videoResolutionCustom
            width: 5
            opacity: 0
            focus: true
            onAccepted: {
                videoResolution = videoResolutionCustom.text
                console.log(videoResolution)
            }
            Behavior on width {
                NumberAnimation { duration: 400 }
            }
            Layout.row: 3
            Layout.column: 2
            Layout.maximumWidth: videoBitrateSelection.width * 1.25
        } // TextField videoBitrateCustom

        Text {
            id: aspectLabel
            text: qsTr("Aspect:")
            width: 55
            Layout.row: 4
            Layout.column: 0
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
            Layout.row: 4
            Layout.column: 1
        } // Button aspectSelection
    
    
} // Column for Codec, Bitrate, ... 
