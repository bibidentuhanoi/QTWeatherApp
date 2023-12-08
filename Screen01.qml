import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 1920 * 0.6
    height: 1080 * 0.6
    title: "Weather"
    color: "#000000"
    property alias running: timer.running
    property date date
    property string ttimeText: "00:00"
    property string hourText: "22:00"
    property real originalFontSizeHourly: 48 // Adjust the original font size as needed
    property real dynamicFontSizeHour: Math.max(Math.min((window.width / 1920), (window.height / 1080)) * originalFontSizeHourly, 1)
    property real originalFontSizeTemp: 82 // Adjust the original font size as needed
    property real dynamicFontSizeTemp: Math.max(Math.min((window.width / 1920), (window.height / 1080)) * originalFontSizeTemp, 1)
    property real originalFontSizeDailyTemp: 65 // Adjust the original font size as needed
    property real dynamicFontSizeDailyTemp: Math.max(Math.min((window.width / 1920), (window.height / 1080)) * originalFontSizeDailyTemp, 1)


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
            ttimeText = padZero(hours) + ":" + padZero(minutes);


        }
    }

    function padZero(value) {
        return value < 10 ? "0" + value : value;
    }

    Image {
        id: main_icon
        objectName: "mainIcon"
        width: window.width * 0.115625
        height: window.height * 0.238888889
        anchors.left: parent.left
        anchors.top: parent.top
        source: "./icon/sleet.png"
        anchors.leftMargin: window.width * 0.0203125
        anchors.topMargin: window.height * 0.0916666667
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: temp
        objectName: "temp"
        width: window.width * 0.194270833
        height: window.height * 0.353703704
        color: "#ffffff"
        property real originalFontSize: 270
        property string tempText: "22"
        property real dynamicFontSize: Math.max((window.height / 1080) * originalFontSize, 1)
        font.pixelSize: temp.dynamicFontSize        
        text: '<span style="font-family:\'Minecraft\'; font-size:' + (Layout.preferredHeight * 0.15) + 'pt;">' + tempText + '</span>'
        fontSizeMode: Text.Fit
        anchors.left: parent.left
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        anchors.leftMargin: window.width * 0.151041667
        anchors.topMargin: window.height * 0.0342592593
        textFormat: Text.RichText
        font.capitalization: Font.MixedCase
        minimumPixelSize: 200
    }

    Image {
        id: celcius
        y: 68
        width: window.width * 0.090625
        height: window.height * 0.144444444
        anchors.left: parent.left
        source: "./icon/celsius.png"
        anchors.leftMargin: window.width * 0.3484375
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: clock
        x: 1067
        width: window.width * 0.380729167
        height: window.height * 0.338888889
        opacity: 1
        color: "#ffffff"
        radius: 40
        border.color: "#ffca53"
        border.width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: window.height * 0.0635416667
        anchors.topMargin: window.height * 0.025
        clip: false
        Layout.fillHeight: false
        Layout.fillWidth: true

        Text {
            id: theTime
            property real originalFontSize: 200 // Adjust the original font size as needed
            property real dynamicFontSize: Math.max(Math.min((window.width / 1920), (window.height / 1080)) * originalFontSize, 1)
            font.pixelSize: theTime.dynamicFontSize
            text: '<span style="font-family:\'Minecraft\'; font-size:' + theTime.dynamicFontSize + 'pt;">' + ttimeText +'</span>'                                 
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: parent.height * 0.173076923
            anchors.rightMargin: 0
            anchors.leftMargin: 8
            anchors.bottomMargin: 0
            textFormat: Text.RichText
        }
    }


    ColumnLayout {
        id: moreData
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: window.height * 0.374074074
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        spacing: 10

        GridLayout {
            id: theHourly
            width: 100
            height: 100
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            rowSpacing: 8
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            rows: 2
            columns: 6

            Rectangle {
                id: hourly_1
                objectName: "hourly_1"
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                Layout.fillHeight: true
                Layout.fillWidth: true

                Text {
                    property string hourText: "22:00"
                    id: hourlyText
                    objectName: "hourlyText"
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon
                    objectName: "hourlyIcon"
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    anchors.leftMargin: parent.width * 0.0782608696
                    anchors.topMargin: parent.height * 0.35
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: hourlyTemp
                    property string hourTemp: "22"
                    objectName: "hourlyTemp"
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    anchors.rightMargin: parent.width * 0.0913043478
                    anchors.topMargin: parent.height * 0.285
                }
            }

            Rectangle {
                id: hourly_2
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_2"
                Text {
                    id: hourlyText1
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon1
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp1
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_3
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_3"
                Text {
                    id: hourlyText2
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon2
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp2
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_4
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_4"
                Text {
                    id: hourlyText3
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon3
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp3
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_5
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_5"
                Text {
                    id: hourlyText4
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon4
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp4
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_6
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_6"
                Text {
                    id: hourlyText5
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon5
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp5
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_7
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_7"
                Text {
                    id: hourlyText6
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon6
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp6
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_8
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_8"
                Text {
                    id: hourlyText7
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon7
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp7
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_9
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_9"
                Text {
                    id: hourlyText8
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon8
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp8
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_10
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_10"
                Text {
                    id: hourlyText9
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon9
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp9
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_11
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_11"
                Text {
                    id: hourlyText10
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon10
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp10
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: hourly_12
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "hourly_12"
                Text {
                    id: hourlyText11
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(hourText)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    objectName: "hourlyText"
                    property string hourText: "22:00"
                    anchors.topMargin: parent.height * 0.04
                }

                Image {
                    id: hourlyIcon11
                    width: parent.width * 0.434782609
                    height: parent.height * 0.5
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "hourlyIcon"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.35
                    anchors.leftMargin: parent.width * 0.0782608696
                }

                Text {
                    id: hourlyTemp11
                    x: 111
                    width: parent.width * 0.434782609
                    height: parent.height * 0.635
                    text: qsTr(hourTemp)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    objectName: "hourlyTemp"
                    property string hourTemp: "22"
                    anchors.topMargin: parent.height * 0.285
                    anchors.rightMargin: parent.width * 0.0913043478
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        GridLayout {
            id: theDaily
            width: 100
            height: 100
            Layout.margins: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Rectangle {
                id: daily_1
                objectName: "daily_1"
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                Text {
                    id: dailyText_1
                    objectName: "dailyText"
                    x: 0
                    property string weekDay: "Mon"
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(weekDay)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: 0
                }

                Image {
                    id: dailyIcon_1
                    objectName: "dailyIcon_1"
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    anchors.leftMargin: parent.width * 0.10638297872
                    anchors.topMargin: parent.height * 0.22
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: dailyTemp_1
                    objectName: "dailyTemp_1"
                    property string tempText: "22°"
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Rectangle {
                    id: theBorder
                    y: 56
                    width: parent.width * 0.01329787234
                    height: parent.height * 0.68932038835
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: parent.width * 0.49468085106
                    anchors.bottomMargin: parent.height * 0.03883495145
                }

                Image {
                    id: dailyIcon_2
                    objectName: "dailyIcon_2"
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.right: parent.right
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    anchors.topMargin: parent.height * 0.22
                    anchors.rightMargin: parent.width * 0.13031914893
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: dailyTemp_2
                    objectName: "dailyTemp_2"
                    property string tempText: "24°"
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: parent.width * 0.13031914893
                    anchors.topMargin: parent.height * 0.66019417475
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: daily_2
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "daily_2"
                Text {
                    id: dailyText_2
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(weekDay)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string weekDay: "Mon"
                    objectName: "dailyText"
                    anchors.topMargin: 0
                }

                Image {
                    id: dailyIcon_3
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_1"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Text {
                    id: dailyTemp_3
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "22°"
                    objectName: "dailyTemp_1"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Rectangle {
                    id: theBorder1
                    y: 56
                    width: parent.width * 0.01329787234
                    height: parent.height * 0.68932038835
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: parent.width * 0.49468085106
                    anchors.bottomMargin: parent.height * 0.03883495145
                }

                Image {
                    id: dailyIcon_4
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.right: parent.right
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_2"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.rightMargin: parent.width * 0.13031914893
                }

                Text {
                    id: dailyTemp_4
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "24°"
                    objectName: "dailyTemp_2"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.rightMargin: parent.width * 0.13031914893
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: daily_3
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "daily_3"
                Text {
                    id: dailyText_3
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(weekDay)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string weekDay: "Mon"
                    objectName: "dailyText"
                    anchors.topMargin: 0
                }

                Image {
                    id: dailyIcon_5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_1"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Text {
                    id: dailyTemp_5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "22°"
                    objectName: "dailyTemp_1"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Rectangle {
                    id: theBorder2
                    y: 56
                    width: parent.width * 0.01329787234
                    height: parent.height * 0.68932038835
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: parent.width * 0.49468085106
                    anchors.bottomMargin: parent.height * 0.03883495145
                }

                Image {
                    id: dailyIcon_6
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.right: parent.right
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_2"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.rightMargin: parent.width * 0.13031914893
                }

                Text {
                    id: dailyTemp_6
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "24°"
                    objectName: "dailyTemp_2"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.rightMargin: parent.width * 0.13031914893
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: daily_4
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "daily_4"
                Text {
                    id: dailyText_4
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(weekDay)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string weekDay: "Mon"
                    objectName: "dailyText"
                    anchors.topMargin: 0
                }

                Image {
                    id: dailyIcon_7
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_1"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Text {
                    id: dailyTemp_7
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "22°"
                    objectName: "dailyTemp_1"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Rectangle {
                    id: theBorder3
                    y: 56
                    width: parent.width * 0.01329787234
                    height: parent.height * 0.68932038835
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: parent.width * 0.49468085106
                    anchors.bottomMargin: parent.height * 0.03883495145
                }

                Image {
                    id: dailyIcon_8
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.right: parent.right
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_2"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.rightMargin: parent.width * 0.13031914893
                }

                Text {
                    id: dailyTemp_8
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "24°"
                    objectName: "dailyTemp_2"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.rightMargin: parent.width * 0.13031914893
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: daily_5
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "daily_5"
                Text {
                    id: dailyText_5
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(weekDay)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string weekDay: "Mon"
                    objectName: "dailyText"
                    anchors.topMargin: 0
                }

                Image {
                    id: dailyIcon_9
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_1"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Text {
                    id: dailyTemp_9
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "22°"
                    objectName: "dailyTemp_1"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Rectangle {
                    id: theBorder4
                    y: 56
                    width: parent.width * 0.01329787234
                    height: parent.height * 0.68932038835
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: parent.width * 0.49468085106
                    anchors.bottomMargin: parent.height * 0.03883495145
                }

                Image {
                    id: dailyIcon_10
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.right: parent.right
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_2"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.rightMargin: parent.width * 0.13031914893
                }

                Text {
                    id: dailyTemp_10
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "24°"
                    objectName: "dailyTemp_2"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.rightMargin: parent.width * 0.13031914893
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: daily_6
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "daily_6"
                Text {
                    id: dailyText_6
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(weekDay)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string weekDay: "Mon"
                    objectName: "dailyText"
                    anchors.topMargin: 0
                }

                Image {
                    id: dailyIcon_11
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_1"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Text {
                    id: dailyTemp_11
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "22°"
                    objectName: "dailyTemp_1"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Rectangle {
                    id: theBorder5
                    y: 56
                    width: parent.width * 0.01329787234
                    height: parent.height * 0.68932038835
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: parent.width * 0.49468085106
                    anchors.bottomMargin: parent.height * 0.03883495145
                }

                Image {
                    id: dailyIcon_12
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.right: parent.right
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_2"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.rightMargin: parent.width * 0.13031914893
                }

                Text {
                    id: dailyTemp_12
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "24°"
                    objectName: "dailyTemp_2"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.rightMargin: parent.width * 0.13031914893
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Rectangle {
                id: daily_7
                width: 230
                height: 200
                opacity: 0.7
                color: "#ffffff"
                radius: 10
                objectName: "daily_7"
                Text {
                    id: dailyText_7
                    x: 0
                    width: parent.width
                    height: parent.height * 0.245
                    text: qsTr(weekDay)
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeHour
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string weekDay: "Mon"
                    objectName: "dailyText"
                    anchors.topMargin: 0
                }

                Image {
                    id: dailyIcon_13
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.left: parent.left
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_1"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Text {
                    id: dailyTemp_13
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "22°"
                    objectName: "dailyTemp_1"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.leftMargin: parent.width * 0.10638297872
                }

                Rectangle {
                    id: theBorder6
                    y: 56
                    width: parent.width * 0.01329787234
                    height: parent.height * 0.68932038835
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: parent.width * 0.49468085106
                    anchors.bottomMargin: parent.height * 0.03883495145
                }

                Image {
                    id: dailyIcon_14
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.4708737864
                    anchors.right: parent.right
                    anchors.top: parent.top
                    source: "./icon/snowflake.png"
                    objectName: "dailyIcon_2"
                    fillMode: Image.PreserveAspectFit
                    anchors.topMargin: parent.height * 0.22
                    anchors.rightMargin: parent.width * 0.13031914893
                }

                Text {
                    id: dailyTemp_14
                    x: 237
                    y: 5
                    width: parent.width * 0.23936170212
                    height: parent.height * 0.300970874
                    text: qsTr(tempText)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: dynamicFontSizeDailyTemp
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    property string tempText: "24°"
                    objectName: "dailyTemp_2"
                    anchors.topMargin: parent.height * 0.66019417475
                    anchors.rightMargin: parent.width * 0.13031914893
                }
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
