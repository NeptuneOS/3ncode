  import QtQuick 2.1
  import org.kde.kirigami 2.4 as Kirigami
  import QtQuick.Controls 2.0 as Controls
  import QtQuick.Layouts 1.0
  
  GridLayout { // Column for Codec, Bitrate, Resolution & Aspect Ratio
      Layout.row: 1
      columns: 3
      rows: 6
      
      property alias audioCodecSelection: audioCodecSelection
      property alias audioBitrateSelection: audioBitrateSelection
      property alias audioChannelSelection: audioChannelSelection
      property alias audioSamplingFreqSelection: audioSamplingFreqSelection
      property alias audioLanguageChannelSelection: audioLanguageChannelSelection
      
      Text {
          id: audioCodecLabel
          text: qsTr("Codec:")
          width: 55
          Layout.row: 0
          Layout.column: 0
      }
      
      Controls.Button {
          id: audioCodecSelection
          width: 100
          height: 24
          text: "libmp3lame"
          icon.name: "go-down"
          onClicked: audioCodecMenu.open()
          enabled: audioDeactivate.checked ? false : true
          AudioCodecList {
              id: audioCodecMenu
              parent: audioCodecSelection
              onCodecChanged: {
                  audioCodecSelection.text = codec
                  audioCodec = codec
              }
          }
          Layout.row: 0
          Layout.column: 1
      }
      
      Text {
          id: audioBitrateLabel
          text: qsTr("Bitrate:")
          width: 55
          Layout.row: 1
          Layout.column: 0
      }
      Controls.Button {
          id: audioBitrateSelection
          width: 100
          height: 24
          text: "128k"
          icon.name: "go-down"
          onClicked: audioBitrateMenu.open()
          enabled: audioDeactivate.checked ? false : true
          AudioBitrateList {
              id: audioBitrateMenu
              parent: audioBitrateSelection
              onBitrateChanged: {
                  if (bitrate != "custom") {
                      audioBitrateSelection.text = bitrate
                      audioBitrate = bitrate
                      audioBitrateCustom.width = 5
                      audioBitrateCustom.opacity = 0
                      
                  }
                  else {
                      audioBitrateSelection.text = bitrate
                      audioBitrateCustom.opacity = 1
                      audioBitrateCustom.width = audioBitrateSelection.width * 1.25
                      audioBitrateCustom.forceActiveFocus()
                      audioBitrateCustom.focus = true
                  }
              }
              
          } // AudioBitrateList
          Layout.row: 1
          Layout.column: 1
      } // Button audioBitrateSelection
      
      TextField {
          id: audioBitrateCustom
          width: 5
          opacity: 0
          focus: true
          onAccepted: {
              if (text != "") { 
                  if (text.substr(-1) !== "k") {
                      text += "k"
                  }
              }
              audioBitrate = text
              console.log(audioBitrate)
              
          }
          Behavior on width {
              NumberAnimation { duration: 400 }
          }
          Layout.row: 1
          Layout.column: 2
          Layout.maximumWidth: audioBitrateSelection.width * 1.25
      } // TextField audioBitrateCustom
      
      Text {
          id: audioSamplingFreqLabel
          text: qsTr("Sampl. Freq (Hz):")
          width: 55
          Layout.row: 3
          Layout.column: 0
      }
      Controls.Button {
          id: audioSamplingFreqSelection
          width: 100
          height: 24
          text: "44100"
          icon.name: "go-down"
          onClicked: audioSamplingFreqMenu.open()
          enabled: audioDeactivate.checked ? false : true
          SamplingList {
              id: audioSamplingFreqMenu
              parent: audioSamplingFreqSelection
              onSamplingChanged: {
                  audioSamplingFreqSelection.text = sampling
                  audioSamplingFreq = sampling
              }
              
          } // audioSamplingFreqList
          Layout.row: 3
          Layout.column: 1
      } // Button audioSamplingFreqSelection
      
      Text {
          id: audioChannelLabel
          text: qsTr("Channel:")
          width: 55
          Layout.row: 4
          Layout.column: 0
      }
      Controls.Button {
          id: audioChannelSelection
          width: 100
          height: 24
          text: "2"
          icon.name: "go-down"
          onClicked:audioChannelMenu.open()
          enabled: audioDeactivate.checked ? false : true
          AudioChannelList {
              id: audioChannelMenu
              parent: audioChannelSelection
              onChannelChanged: {
                  if (channel !== qsTr("custom")) {
                      audioChannelSelection.text = channel
                      audioChannel = channel
                      audioChannelCustom.width = 5
                      audioChannelCustom.opacity = 0
                      
                  }
                  else {
                      audioChannelSelection.text = channel
                      audioChannelCustom.opacity = 1
                      audioChannelCustom.width = 100
                      audioChannelCustom.forceActiveFocus()
                      audioChannelCustom.focus = true
                  }
              }
              
          } // audioChannelList
          Layout.row: 4
          Layout.column: 1
      } // Button audioChannelSelection
      
      TextField {
          id: audioChannelCustom
          width: 5
          opacity: 0
          focus: true
          onAccepted: {
              audioChannel = audioChannelCustom.text
              console.log(audioChannel)
          }
          Behavior on width {
              NumberAnimation { duration: 400 }
          }
          Layout.row: 4
          Layout.column: 2
          Layout.maximumWidth: audioBitrateSelection.width * 1.25
      } // TextField audioChannelCustom
      
      Text {
          id: audioLanguageChannelLabel
          text: qsTr("Language:")
          width: 55
          Layout.row: 5
          Layout.column: 0
      }
      Controls.Button {
          id: audioLanguageChannelSelection
          width: 100
          height: 24
          text: "not set"
          icon.name: "go-down"
          onClicked:audioLanguageChannelMenu.open()
          enabled: audioDeactivate.checked ? false : true
          AudioLanguageChannelList {
              id: audioLanguageChannelMenu
              parent: audioLanguageChannelSelection
              onChannelChanged: {
                  if (channel !== qsTr("custom")) {
                      audioLanguageChannelSelection.text = channel
                      audioLanguageChannel = channel
                      audioLanguageChannelCustom.width = 5
                      audioLanguageChannelCustom.opacity = 0
                      
                  }
                  else {
                      audioLanguageChannelSelection.text = channel
                      audioLanguageChannelCustom.opacity = 1
                      audioLanguageChannelCustom.width = 100
                      audioLanguageChannelCustom.forceActiveFocus()
                      audioLanguageChannelCustom.focus = true
                  }
              }
              
          } // audioChannelList
          Layout.row: 5
          Layout.column: 1
      } // Button audioLanguageChannelSelection
      
      TextField {
          id: audioLanguageChannelCustom
          width: 5
          opacity: 0
          focus: true
          onAccepted: {
              audioLanguageChannel = audioLanguageChannelCustom.text
              console.log(audioLanguageChannel)
          }
          Behavior on width {
              NumberAnimation { duration: 400 }
          }
          Layout.row: 5
          Layout.column: 2
      } // TextField audioLanguageChannelCustom
      
      //                    } // Button aspectSelection
      //                }
      
      
  } // Column for Codec, Bitrate, ...
