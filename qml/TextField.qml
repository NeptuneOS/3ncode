/*
 *   Copyright (C) 2011 by Daker Fernandes Pinheiro <dakerfp@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.1
import org.kde.kirigami 2.4 as Kirigami
import QtQuick.Controls 2.0 as Controls

Controls.TextField {
    id: txtField
    placeholderText: ""
    width: parent.width
    selectByMouse: true
    visible: true
    property var selectStart
    property var selectEnd
    property var curPos
    property bool clearButtonShown: false
    Kirigami.Icon {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: Kirigami.Units.smallSpacing * 2
        visible: clearButtonShown ? txtField.text != "" : false
        source: "edit-clear"
        width: Kirigami.Units.iconSizes.small
        height: width
        MouseArea {
            anchors.fill: parent
            onClicked: txtField.text = ""
        }
    }
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onReleased: { 
            txtField.selectStart = txtField.selectionStart;
            txtField.selectEnd = txtField.selectionEnd;
            txtField.curPos = txtField.cursorPosition;
            contextMenu.popup()
        }
        propagateComposedEvents: true
    }
    Controls.Menu {
        id: contextMenu
        onOpened: {
            txtField.cursorPosition = txtField.curPos;
            txtField.select(txtField.selectStart,txtField.selectEnd);
        }
        Controls.MenuItem {
            text: "Cut"
            icon.name: "edit-cut"
            onTriggered: { 
                txtField.cut()
            }
        }
        
        Controls.MenuItem {
            text: "Copy"
            icon.name: "edit-copy"
            onTriggered: { 
                txtField.copy()
            }
        }
        
        Controls.MenuItem {
            text: "Paste"
            icon.name: "edit-paste"
            onTriggered: { 
                txtField.paste()
            }
        }
    }
}
