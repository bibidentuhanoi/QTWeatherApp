import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 1920
    height: 1080
    title: "Weather"
    color: "#000000"
    property alias running: timer.running
    property date date
    property string dateText: "27/11/1991"
    property string ttimeText: "00:00"
    

    FontLoader {
        id: customFontLoader
        source: "./fonts/Minecraft.ttf" // Replace with the actual path to your font file
    }
    Timer {
        id: timer
        interval: 1000 // Set the interval to 1000 milliseconds (1 second)
        running: true
        repeat: true
        onTriggered: {
            var currentTime = new Date();
            var hours = currentTime.getHours();
            var minutes = currentTime.getMinutes();
            var day = padZero(currentTime.getDate());
            var month = padZero(currentTime.getMonth() + 1); // Note: Months are zero-based
            var year = currentTime.getFullYear();
            ttimeText = padZero(hours) + ":" + padZero(minutes);
            dateText =  day + '/' + month + '/' + year;

        }
    }

    function padZero(value) {
        return value < 10 ? "0" + value : value;
    }

    Image {
        id: main_icon

        objectName: "mainIcon"
        source: "./icon/sleet.png"
        fillMode: Image.PreserveAspectFit
        width: parent.width * 0.115625 // Adjust the width based on a percentage
        height: parent.height * 0.238888889 // Adjust the height based on a percentage
        // Responsive anchors and margins
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter

            leftMargin: parent.width * 0.075 // Adjust the left anchor based on a percentage
            verticalCenterOffset: parent.height * -0.214 // Adjust the vertical center offset based on a percentage
        }
    }

    Text {
        id: temp
        objectName: "temp"
        color: "#ffffff"
        property string tempText: "22"
        width: parent.width * 0.234895833
        height: parent.height * 0.549074074
        property real originalFontSize: 280
        property real dynamicFontSize: Math.max((window.height / 1080) * originalFontSize, 1)
        font.pixelSize: temp.dynamicFontSize        
        text: '<span style="font-family:\'Minecraft\'; font-size:' + (Layout.preferredHeight * 0.15) + 'pt;">' + tempText + '</span>'
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: window.height * 0.1852
            leftMargin: window.width * 0.1828
            rightMargin: window.width * 0.6352
            bottomMargin: window.height * 0.5352
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        textFormat: Text.RichText
        font.capitalization: Font.MixedCase
        fontSizeMode: Text.Fit
}

    Image {
        id: celcius
        source: "./icon/celsius.png"
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: window.width * 0.3526
            rightMargin: window.width * 0.5568
            topMargin: window.height * 0.0852
            bottomMargin: window.height * 0.769
        }
        width: 174
        height: 156
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: location
        // Responsive font size properties
        property real originalFontSize: 100 // Adjust the original font size as needed
        property real dynamicFontSize: Math.max(Math.min((window.width / 1920), (window.height / 1080)) * originalFontSize, 1)

        width: parent.width * 0.778
        height: parent.height * 0.1669
        color: "#ffffff"
        font.pixelSize: location.dynamicFontSize
        text: '<span style="font-family:\'Minecraft\'; font-size:' + location.dynamicFontSize + 'pt;">Hwagok-dong</span>'
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: parent.width * 0.0380208333 // Adjust the left anchor based on a percentage
            rightMargin: parent.width * 0.5569 // Adjust the right anchor based on a percentage
            topMargin: parent.height * 0.490740741 // Adjust the top anchor based on a percentage
            bottomMargin: parent.height * 0.34375 // Adjust the bottom anchor based on a percentage
        }
        textFormat: Text.RichText
    }

    Text {
        id: theDate
        // Responsive font size properties
        property real originalFontSize: 100 // Adjust the original font size as needed
        property real dynamicFontSize: Math.max(Math.min((window.width / 1920), (window.height / 1080)) * originalFontSize, 1)
        color: "#ffffff"
        font.pixelSize: theDate.dynamicFontSize
        text: '<span style="font-family:\'Minecraft\'; font-size:' + theDate.dynamicFontSize + 'pt;">' + dateText +'</span>'
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: parent.width * 0.073 // Adjust the left anchor based on a percentage
            rightMargin: parent.width * 0.5569 // Adjust the right anchor based on a percentage
            topMargin: parent.height *0.698755556 // Adjust the top anchor based on a percentage
            bottomMargin: parent.height * 0.130 // Adjust the bottom anchor based on a percentage
        }

        textFormat: Text.RichText
    }
    Column {
        id: time
        width: parent.width * 0.4390625
        height: parent.height * 0.888888889
        spacing: 20
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: parent.width * 0.040625// Adjust the right anchor based on a percentage
            bottomMargin: parent.height * 0.08703703703 // Adjust the bottom anchor based on a percentage
        } 

        Rectangle {
            id: clock
            width: parent.width * 0.4390625
            color: "#ffffff"
            radius: 40
            border.color: "#ffca53"
            border.width: 10
            anchors {
                left: parent.left
                top: parent.top
                right: parent.right
                bottom: parent.bottom
                topMargin: 0
                leftMargin: 0
                bottomMargin: parent.height * 0.593518519 // Adjust the bottom anchor based on a percentage
            } 
            Text {
                id: timeText
                color: "Black"
                property real originalFontSize: 200 // Adjust the original font size as needed
                property real dynamicFontSize: Math.max(Math.min((window.width / 1920), (window.height / 1080)) * originalFontSize, 1)
                text: '<span style="font-family:\'Minecraft\'; font-size:' + timeText.dynamicFontSize + 'pt;">' + ttimeText + '</span>';

                // Responsive anchors and margins
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom

                    leftMargin: parent.width * 0.088 // Adjust the left anchor based on a percentage
                    rightMargin: parent.width * 0.088 // Adjust the right anchor based on a percentage
                    topMargin: parent.height * 0.28 // Adjust the top anchor based on a percentage
                    bottomMargin: parent.height * -0.006 // Adjust the bottom anchor based on a percentage
                }       

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                textFormat: Text.RichText

            }
        }
    }
}
