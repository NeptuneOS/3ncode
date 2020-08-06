  import QtQuick 2.1
  import org.kde.kirigami 2.4 as Kirigami
  import QtQuick.Controls 2.0 as Controls
  import QtQuick.Layouts 1.0
  
  RowLayout {
      id: expandedAudio
      anchors.top: parent.top
      anchors.topMargin: 5
      anchors.leftMargin: 10
      anchors.right: parent.right
      anchors.rightMargin: 10
      width: parent.width - 15
      height: parent.height - 15
      anchors.verticalCenter: parent.verticalCenter
      opacity: 0
      spacing: 15
      property alias audioDeactivate: audioDeactivate
      property alias audioCodecSelection: aCodecBitrateSettings.audioCodecSelection
      property alias audioBitrateSelection: aCodecBitrateSettings.audioBitrateSelection
      property alias audioChannelSelection: aCodecBitrateSettings.audioChannelSelection
      property alias audioSamplingFreqSelection: aCodecBitrateSettings.audioSamplingFreqSelection
      property alias audioLanguageChannelSelection: aCodecBitrateSettings.audioLanguageChannelSelection
      
      Behavior on opacity {
          NumberAnimation { duration: 300 }
      }
      
      ColumnLayout {
          Layout.row: 0
          width: parent.width / 2
          Text {
              id: expandedAudioHeader
              font.bold: true
              text: audioDeactivate.checked ? qsTr("     Audio: deactivated") : qsTr("     Audio:")
          }
          Image {
              id: audioIcon
              source: "img/audio-x-generic.png"
          }
              id: audioCheckboxes
              
              Controls.CheckBox {
                  id: audioDeactivate
                  text: "Deactivate Audio"
              }
      } // Column for icon and checkboxes
      AudioCodecBitrateSettings {
          id: aCodecBitrateSettings
      }
      
  } // Row Expanded Audio
