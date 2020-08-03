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

Rectangle {
    id: listRectangle
    anchors.fill: parent
    color: parent.color
    property alias textArea: textArea

    function readTxt(filepath) {
        var doc = new XMLHttpRequest();
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                textArea.text = doc.responseText;
                //console.log(doc.responseText) //DEBUG
            } else
                textArea.text = "Is null"
        }
        doc.open("GET", Qt.resolvedUrl(filepath))
        doc.send();
    }

    Controls.TextArea {
        id: textArea
        wrapMode: TextEdit.Wrap
//        anchors.fill: parent
        readOnly: true
        width: parent.width - 10
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height - (backButton.height + 20)
    }
//    Flickable {
//        id: textAreaScroll
//        contentWidth: textArea.width
//        contentHeight: textArea.height
//        flickableDirection: Flickable.VerticalFlick
//        anchors.fill: parent
//        Text {
//            id: textArea
//            wrapMode: TextEdit.Wrap
//            width: listRectangle.width
//        }
//    }

    Controls.Button {
        id: backButton
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 15
        width:32
        height:32
        onClicked: listRectangle.visible = false

        Image {
            anchors.centerIn: parent
            source: "img/left.png"
            smooth: true
        }
    }
}
