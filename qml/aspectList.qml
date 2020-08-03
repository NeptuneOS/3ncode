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

    signal aspectChanged(string aspect);

    id: resolutionMenu
    Controls.MenuItem {
        text: qsTr("1:1")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("3:2")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("4:3")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("5:4")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("5:6")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("11:6")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("16:9")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("16:10")
        onClicked: aspectChanged(text)
    }
    Controls.MenuItem {
        text: qsTr("no change")
        onClicked: aspectChanged(text)
    }
}
