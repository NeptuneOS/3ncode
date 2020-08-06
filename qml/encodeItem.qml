/*
  ** 3encode version 3.0
  **
  ** by Leszek Lesner
  ** released under the terms of BSD
  **
  ** Copyright (c) 2013, Leszek Lesner
  ** All rights reserved.
  **
  ** Redistribution and use in source and binary forms, with or without modification,
  ** are permitted provided that the following conditions are met:
  **
  ** Redistributions of source code must retain the above copyright notice,
  ** this list of conditions and the following disclaimer.
  ** Redistributions in binary form must reproduce the above copyright notice,
  ** this list of conditions and the following disclaimer in the documentation
  ** and/or other materials provided with the distribution.
  ** Neither the name of the <ORGANIZATION> nor the names of its contributors
  ** may be used to endorse or promote products derived from this software without
  ** specific prior written permission.
  **
  ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
  ** IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
  ** INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  ** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  ** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  ** EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  **/

import QtQuick 2.1
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.0

Item {
    id: root
    property string source: openfText.text
    property string target: savefText.text
    property string videoCodec: "libxvid"
    property string videoBitrate: "777k"
    property string videoResolution: "no change"
    property string videoAspect: "no change"
    property string audioCodec: "libmp3lame"
    property string audioBitrate: "128k"
    property string audioSamplingFreq: "44100"
    property string audioChannel: "2"
    property string audioLanguageChannel: "not set"
    property alias cmdbox: cmdbox
    property string cmd: cmdText.text
    property alias sourceFilename: openfText.text
    property alias targetFilename: savefText.text

    signal encodeClicked(string ffmpegCmd, string outputFile);
    signal openFileClicked();
    signal saveFileClicked(string fileName);

    // Header to open file and choose container
    GridLayout {
        id: sourceGrid
        columns: 2
        rows:1
        //anchors.top: parent.top
        //anchors.topMargin: 15
        width: parent.width - 30
        //anchors.left: parent.left
        //anchors.leftMargin: 15
        // Check Container and set some audio and video default codecs here
        function checkFormatandSetCodecs(format) {
            if (format === "avi") {
                activateVideo()
                videoCodec = "libxvid"
                expandedVideo.videoCodecSelection.text = "libxvid"
                audioCodec ="libmp3lame"
                expandedAudio.audioCodecSelection.text = "libmp3lame"
            }
            else if (format === "mp4" || format === "mkv") {
                activateVideo()
                videoCodec = "libx264"
                expandedVideo.videoCodecSelection.text = "libx264"
                audioCodec = "aac"
                expandedAudio.audioCodecSelection.text = "aac"
            }
            else if (format === "ogv") {
                activateVideo()
                videoCodec = "libtheora"
                expandedVideo.videoCodecSelection.text = "libtheora"
                audioCodec = "libvorbis"
                expandedAudio.audioCodecSelection.text = "libvorbis"
            }
            else if (format === "webm") {
                activateVideo()
                videoCodec = "libvpx"
                expandedVideo.videoCodecSelection.text = "libvpx"
                audioCodec = "libvorbis"  // Maybe someday opus but webm seems not support it right now
                expandedAudio.audioCodecSelection.text = "libvorbis"
            }
            else if (format === "3gp") {
                activateVideo()
                videoCodec = "h263"
                expandedVideo.videoCodecSelection.text = "h263"
                audioCodec = "amr_nb"
                expandedAudio.audioCodecSelection.text = "libopencore_amrnb"
            }
            else if (format === "asf") {
                activateVideo()
                videoCodec = "wmv1"
                expandedVideo.videoCodecSelection.text = "wmv1"
                audioCodec = "wmav1"
                expandedAudio.audioCodecSelection.text = "wmav1"
            }
            else if (format === "wmv") {
                activateVideo()
                videoCodec = "wmv2"
                expandedVideo.videoCodecSelection.text = "wmv2"
                audioCodec = "wmav2"
                expandedAudio.audioCodecSelection.text = "wmav2"
            }
            else if (format === "mov") {
                activateVideo()
                videoCodec = "mpeg4"
                expandedVideo.videoCodecSelection.text = "mpeg4"
                audioCodec = "aac"
                expandedAudio.audioCodecSelection.text = "aac"
            }
            else if (format === "mpeg") {
                activateVideo()
                videoCodec = "mpeg1video"
                expandedVideo.videoCodecSelection.text = "mpeg1video"
                audioCodec = "mp2"
                expandedAudio.audioCodecSelection.text = "mp2"
            }
            else if (format === "flv") {
                activateVideo()
                videoCodec = "flv"
                expandedVideo.videoCodecSelection.text = "flv"
                audioCodec = "libmp3lame"
                expandedAudio.audioCodecSelection.text = "libmp3lame"
            }
            else if (format === "aac") {
                deactivateVideo()
                audioCodec = "aac"
                expandedAudio.audioCodecSelection.text = "aac"
            }
            else if (format === "mp3") {
                deactivateVideo()
                audioCodec = "libmp3lame"
                expandedAudio.audioCodecSelection.text = "libmp3lame"
            }
            else if (format === "ogg") {
                deactivateVideo()
                audioCodec = "libvorbis"
                expandedAudio.audioCodecSelection.text = "libvorbis"
            }
            else if (format === "ac3") {
                deactivateVideo()
                audioCodec = "ac3"
                expandedAudio.audioCodecSelection.text = "ac3"
            }
            else if (format === "flac") {
                deactivateVideo()
                audioCodec = "flac"
                expandedAudio.audioCodecSelection.text = "flac"
            }
            else if (format === "mp2") {
                deactivateVideo()
                audioCodec = "mp2"
                expandedAudio.audioCodecSelection.text = "mp2"
            }
            else if (format === "wav") {
                deactivateVideo()
                audioCodec = "pcm_s16le"
                expandedAudio.audioCodecSelection.text = "pcm_s16le"
            }
            // Set output file location
            if (openfText.text != "") {
                savefText.text = openfText.text + "." + format
            }
        }

        function deactivateVideo() {
            if (summaryVideoRectangle.height == 250) {
                summaryVideoRectangle.height = summaryVideoRectangle.collapsedHeight
                summaryVideo.opacity = 1
                expandedVideo.opacity = 0
            }
            expandedVideo.videoDeactivate.checked = true
            expandedVideo.videoDeactivate.enabled = false
        }

        function activateVideo() {
            expandedVideo.videoDeactivate.checked = false
            expandedVideo.videoDeactivate.enabled = true
        }

        function createFFmpegCommand() {
            var cmd = "ffmpeg -i \"" + openfText.text + "\""

            // Format
            // For now we don't use format here as the detection for file extension works quite good
            //cmd += " -f " + containerSelection.text

            // Audio conversions first
            // example ffmpeg cmd:
            // ffmpeg -i ''  -vn -ab 128k -ar 44100 -b 2000k -f wav -vcodec libxvid -ac 2 -acodec pcm_s16le '.wav'
            if (expandedVideo.videoDeactivate.checked == true) {
                expandedVideo.video2pass.enabled = false
                cmd += " -vn"
            }
            else if (expandedAudio.audioDeactivate.checked) {
                cmd += " -an"
            }
            cmd += " -ab " + audioBitrate
            cmd += " -ar " + audioSamplingFreq
            cmd += " -b " + audioBitrate
            cmd += " -ac " + audioChannel
            cmd += " -acodec " + audioCodec
            if (audioLanguageChannel != "not set") {
                cmd += " -map 0:" + audioLanguageChannel
            }

            //Video conversions second
            //example ffmpeg cmd:
            // ffmpeg -i ''  -ab 128k -ar 44100 -b 2000k -f avi -vcodec libxvid -ac 2 -acodec libmp3lame '.avi'
            cmd += " -b " + videoBitrate
            cmd += " -vcodec " + videoCodec
            if (videoResolution != "no change") {
                cmd += " -s " + videoResolution
            }
            if (videoAspect != "no change") {
                cmd += " -aspect " + videoAspect
            }
            if (expandedVideo.videoMultithreading.checked) {
                cmd += " -threads 0"
            }

            if (expandedVideo.video2pass.checked) {
                cmdpass1 = cmd + " -y -pass 1"
                cmdpass1 += " \"" + savefText.text + "\""
                cmdpass2 = cmd + " -y -pass 2"
                cmdpass2 += " \"" + savefText.text + "\""
                // 2 Pass Output file
                cmd = cmdpass1 + " && " + cmdpass2
            }
            else {
                // Output file
                cmd += " \"" + savefText.text + "\""
            }
            //console.log(cmd) //DEBUG
            return cmd
        }

        TextField {
            id: openfText
            placeholderText: qsTr("Open source file here")
            width: 350
            height: 32
            clearButtonShown: true
            onTextChanged: {
                sourceGrid.checkFormatandSetCodecs(containerSelection.text)
            }
            Layout.row: 0
            Layout.column: 0
            Layout.fillWidth: true
        }

        Controls.Button {
            id: openfBtn
            text: qsTr("Open")
            width: 80
            height: 32
            icon.name: "document-open"
            // Just for testing now // DEBUG
            onClicked: { openFileClicked() }
            Layout.row: 0
            Layout.column: 1
            Layout.fillWidth: true
        }
    }
    
    Item {
        id: containerChooser
        anchors.top: sourceGrid.bottom
        anchors.topMargin: 10
        height: 30
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            id: containerLabel
            text: qsTr("Choose container format:")
            anchors.verticalCenter: containerSelection.verticalCenter
        }
        
        Controls.Button {
            id: containerSelection
            width: containerChooser.width / 1.75
            anchors.left: containerLabel.right
            anchors.leftMargin: 25
            height: 28
            text: "avi"
            icon.name: "go-down"
            onClicked: contMenu.open()
            ContainerList {
                id: contMenu
                parent: containerSelection
                onFormatChanged: {
                    sourceGrid.checkFormatandSetCodecs(format)
                    containerSelection.text = format
                }
            }
        }
    }

    // Video Box
    Rectangle {
        id: summaryVideoRectangle
        color: "white"
        anchors.top: containerChooser.bottom
        anchors.topMargin: 15
        width: parent.width - 30
        //anchors.left: parent.left
        //anchors.leftMargin: 15
        property int collapsedHeight: Math.max((summaryVideoHeader.height + summaryVideoBody.height) * 1.5)
        property int expandedHeight: Math.max(expandedVideo.childrenRect.height * 1.1)
        height: collapsedHeight
        radius: 8

        Behavior on height {
            NumberAnimation { duration: 250 }
        }

        Image {
            source: if (summaryVideo.opacity == 1 && expandedVideo.videoDeactivate.enabled == true) { return "img/down.png" }
                    else if (summaryVideo.opacity == 0 && expandedVideo.videoDeactivate.enabled == true) { return "img/up.png" }
                    else { return "" }

            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
        }

        ColumnLayout {
            id: summaryVideo
            width: parent.width - 15
            height: parent.height - 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }

            Text {
                id: summaryVideoHeader
                font.bold: true
                text: expandedVideo.videoDeactivate.checked ? qsTr("     Video: deactivated") : qsTr("     Video:")
            }
            Text { // codec, resolution, bitrate, aspect ratio
                id: summaryVideoBody
                width: summaryVideoRectangle.width
                text: expandedVideo.videoDeactivate.checked ? "" : "<b>Codec:</b> " + videoCodec + " <b>Bitrate:</b> " + videoBitrate + " <b>Resolution:</b> " +
                                                videoResolution + "<br /><b>Aspect:</b> " + videoAspect
            }
        } // Column Summary Video
        ExpandedVideoItem {
            id: expandedVideo
        }
        MouseArea {
            //            anchors.fill: parent  // This does not work as it blocks every mouseclick on the parent later on
            width: parent.width
            height: parent.height
            hoverEnabled: true

            //            onEntered: {                                              // Nice effect but might get in the way deactivated for now
            //                if (summaryAudioRectangle.height == 250) {
            //                    summaryAudioRectangle.height = 50
            //                    summaryAudio.opacity = 1
            //                    expandedAudio.opacity = 0
            //                }
            //                if (videoDeactivate.enabled == true) {
            //                    parent.height = 250
            //                    summaryVideo.opacity = 0
            //                    expandedVideo.opacity = 1
            //                }
            //            }
            onClicked: {
                if (parent.height == summaryVideoRectangle.collapsedHeight && expandedVideo.videoDeactivate.enabled == true) {
                    if (summaryAudioRectangle.height == summaryAudioRectangle.expandedHeight) {
                        summaryAudioRectangle.height = summaryAudioRectangle.collapsedHeight
                        summaryAudio.opacity = 1
                        expandedAudio.opacity = 0
                    }
                    parent.height = summaryVideoRectangle.expandedHeight
                    summaryVideo.opacity = 0
                    expandedVideo.opacity = 1
                    height = summaryVideoHeader.height * 1.25
                }
                else if (expandedVideo.videoDeactivate.enabled == true)
                {
                    parent.height = summaryVideoRectangle.collapsedHeight
                    summaryVideo.opacity = 1
                    expandedVideo.opacity = 0
                    height = summaryVideoRectangle.collapsedHeight
                }
            }
        } // MouseArea
    } // summaryVideoRectangle

    // Audio Box
    Rectangle {
        id: summaryAudioRectangle
        color: "white"
        anchors.top: summaryVideoRectangle.bottom
        anchors.topMargin: 15
        width: parent.width - 30
        //anchors.left: parent.left
        //anchors.leftMargin: 15
        property int collapsedHeight: Math.max((summaryAudioHeader.height + summaryAudioBody.height) * 1.5)
        property int expandedHeight: Math.max(expandedAudio.childrenRect.height  * 1.1)
        height: collapsedHeight
        radius: 8

        Behavior on height {
            NumberAnimation { duration: 250 }
        }

        Image {
            source: if (summaryAudio.opacity == 1) { return "img/down.png" }
                    else { return "img/up.png" }

            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
        }

        ColumnLayout {
            id: summaryAudio
            anchors.top: parent.top
            anchors.topMargin: 5
            width: parent.width - 15
            height: parent.height - 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }

            Text {
                id: summaryAudioHeader
                font.bold: true
                text: expandedAudio.audioDeactivate.checked ? qsTr("     Audio: deactivated") : qsTr("     Audio:")
            }
            Text { // codec, resolution, bitrate, aspect ratio
                id: summaryAudioBody
                text: expandedAudio.audioDeactivate.checked ? "" : "<b>Codec:</b> " + audioCodec + " <b>Bitrate:</b> " + audioBitrate + " <b>Sampling Freq:</b> " +
                                                audioSamplingFreq + " <br /><b>Channel:</b> " + audioChannel + " <br /><b>Language Channel:</b> " + audioLanguageChannel
            }
        } // Column Summary Audio
        ExpandedAudioItem {
            id: expandedAudio
        }
        MouseArea {
            //            anchors.fill: parent  // This does not work as it blocks every mouseclick on the parent later on
            width: parent.width
            height: parent.height
            hoverEnabled: true

            //            onEntered: {
            //                if (summaryVideoRectangle.height == 250) {
            //                    summaryVideoRectangle.height = 50
            //                    summaryVideo.opacity = 1
            //                    expandedVideo.opacity = 0
            //                }
            //                parent.height = 250
            //                summaryAudio.opacity = 0
            //                expandedAudio.opacity = 1
            //            }
            onClicked: {
                if (parent.height == summaryAudioRectangle.collapsedHeight) {
                    if (summaryVideoRectangle.height == summaryVideoRectangle.expandedHeight) {
                        summaryVideoRectangle.height = summaryVideoRectangle.collapsedHeight
                        summaryVideo.opacity = 1
                        expandedVideo.opacity = 0
                    }
                    parent.height = summaryAudioRectangle.expandedHeight
                    summaryAudio.opacity = 0
                    expandedAudio.opacity = 1
                    height = summaryAudioHeader.height * 1.25
                }
                else
                {
                    parent.height = summaryAudioRectangle.collapsedHeight
                    summaryAudio.opacity = 1
                    expandedAudio.opacity = 0
                    height = summaryAudioRectangle.collapsedHeight
                }
            }
        } // MouseArea
    } // summaryAudioRectangle

    Item {
        id: saveToBox
        anchors.top: summaryAudioRectangle.bottom
        anchors.topMargin: 15
        //anchors.left: parent.left
        //anchors.leftMargin: 15
        height: 40

        TextField {
            id: savefText
            placeholderText: qsTr("Save target file here")
            width: 350
            height: 32
            clearButtonShown: true
        }
        Controls.Button {
            id: savefBtn
            text: qsTr("Save")
            anchors.left: savefText.right
            anchors.leftMargin: 15
            anchors.verticalCenter: savefText.verticalCenter
            width: 80
            height: 32
            icon.name: "document-save"
            // Just for testing now // DEBUG
            onClicked: { saveFileClicked(target);  }
        }
    }
    Item {
        id: cmdbox
        anchors.top: saveToBox.bottom
        anchors.topMargin: 15
        width: parent.width - 30
        //anchors.left: parent.left
        //anchors.leftMargin: 15
        height: 0
        enabled: height != 0
        Behavior on height {
            NumberAnimation { duration: 250 }
        }
        function toggleShow() {
            if (cmdboxRectangle.opacity == 0) {
                cmdboxRectangle.opacity = 1
                cmdLabel.opacity = 1
                cmdText.opacity = 1
                if (summaryVideoRectangle.height == 250) {
                    summaryVideoRectangle.height = 50
                    summaryVideo.opacity = 1
                    expandedVideo.opacity = 0
                }
                else if (summaryAudioRectangle.height == 250) {
                    summaryAudioRectangle.height = 50
                    summaryAudio.opacity = 1
                    expandedAudio.opacity = 0
                }
            }
            else {
                cmdboxRectangle.opacity = 0
                cmdLabel.opacity = 0
                cmdText.opacity = 0
            }
        }

        Rectangle {
            id:cmdboxRectangle
            color: "black"
            anchors.fill: parent
            radius: 8
            opacity: 0
        }
        Text {
            id: cmdLabel
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            color: "green"
            text: "<b>$</b> "
            opacity: 0
            Behavior on opacity {
                NumberAnimation { duration: 500 }
            }
        }
        Controls.TextArea {
            id: cmdText
            anchors.left: cmdLabel.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            placeholderText: qsTr("FFmpeg command here")
            text: sourceGrid.createFFmpegCommand()
            width: parent.width - 32
            height: 64
            opacity: 0
            Behavior on opacity {
                NumberAnimation { duration: 500 }
            }
        }

    }

    Item {
        id:toolbox
        anchors.top: cmdbox.bottom
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 5
        height: 60
        width: parent.width
        Controls.Button {
            id: encodeBtn
            anchors.horizontalCenter: parent.horizontalCenter
            width:140
            height: 48
            icon.source: "file://img/encode-btn.png"
            onClicked: { encodeClicked(sourceGrid.createFFmpegCommand(),savefText.text) }
            Image {
                id: icon
                width: 48
                height: 48
                source: "img/encode-btn.png"
            }
            Text {
                anchors.left: icon.right
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("<b>Encode</b>")
            }
        }

    }


}
