/*
  ** Part of 3encode version 3.0
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

Controls.Menu {

    signal codecChanged(string codec);

    id: videoCodecMenu
    Controls.MenuItem {
        text: qsTr("ac3")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("flac")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("mp2")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("aac")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("libmp3lame")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("libopencore_amrnb")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("libvorbis")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("libopus")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("pcm_s16le")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("wmav1")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("wmav2")
        onClicked: codecChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("--")
    }
    Controls.MenuItem {
        text: qsTr("copy")
        onClicked: codecChanged(text)
    }

}
