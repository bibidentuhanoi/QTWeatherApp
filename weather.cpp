#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QDebug>
#include <QObject>
#include <QTimer>
#include <QJsonArray>
class WeatherCondition {
public:
    int minCode;
    int maxCode;
    QString iconName;

    // Constructor
    WeatherCondition(int min, int max, const QString& icon)
        : minCode(min), maxCode(max), iconName(icon) {}

    // Function to check if a given code falls within the range of this condition
    bool isInRange(int code) const {
        return (code >= minCode && code <= maxCode);
    }
};

// Function to get the weather condition based on a given code
WeatherCondition getWeatherCondition(int code,const  QString time) {
    // Define weather conditions with ranges and icon names
    WeatherCondition conditions[] = {
        {100, 131, "sun"},
        {140, 170, "cloud"},
        {181, 181, "sun"},
        {200, 231, "wind"},
        {240, 281, "wind"},
        {300, 329, "rain"},
        {340, 371, "snowflake"},
        {400, 425, "snowflake"},
        {426, 430, "snowflake"},
        {450, 450, "snowflake"},
        {500, 565, "storm"},
        {568, 583, "cloud"},
        {600, 600, "cloud"},
        {800, 884, "storm"},
        {881, 883, "storm"},
        {950, 984, "snowflake"},
        {999, 999, "sun"},
    };

    for (const auto& condition : conditions) {
        if (condition.isInRange(code)) {
            if (time == QLatin1String("N") && condition.iconName == "sun") {
                // Modify the condition if it's night time and the icon is "sun"
                return WeatherCondition(condition.minCode, condition.maxCode, "half-moon");
            } else {
                return condition;
            }
        }
    }

    // Default condition if no match is found
    return WeatherCondition(0, 0, "unknown");
}


QJsonArray get_every_something_element(const QJsonArray& data,int num, int limit) {
    QJsonArray selected_data;

    for (int i = 0; i < data.size(); i += num) {
        selected_data.append(data.at(i));
        if (selected_data.size() == limit) {
        break;
        }    
    }

    return selected_data;
}

QString getWeekdayFromTimestamp(const QString& timestamp) {
    // Find the position of the 'T' character in the timestamp
    int tIndex = timestamp.indexOf('T');

    if (tIndex != -1) {
        // Extract the substring before the 'T' character
        QString datePart = timestamp.left(tIndex);
        QDateTime dateTime = QDateTime::fromString(datePart, "yyyy/MM/dd");
        return  dateTime.toString("dddd");
    } else {
        return "Invalid timestamp";
    }
}




int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QNetworkAccessManager manager;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("./Screen01.qml")));
    auto updateWeather = [&]() {
        // Fetch data from the first API
        QNetworkReply *reply1 = manager.get(QNetworkRequest(QUrl("https://www.kr-weathernews.com/mv3/if/today_v2.fcgi?region=1150010300")));
        QEventLoop loop1;
        QObject::connect(reply1, &QNetworkReply::finished, &loop1, &QEventLoop::quit);
        loop1.exec();
        QByteArray data1 = reply1->readAll();
        QJsonDocument doc1 = QJsonDocument::fromJson(data1);
        QJsonObject obj1 = doc1.object();
        
        // Extract necessary data from the first API response
        QJsonValue temp = obj1.value("current").toObject().value("temp");
        QJsonValue weatherCode = obj1.value("current").toObject().value("wx");
        QJsonValue dayOrNight = obj1.value("current").toObject().value("dayOrNight");
        QJsonValue hourly = obj1.value("hourly");
        QJsonArray selectedData = get_every_something_element(hourly.toArray(),1, 12);

        WeatherCondition currentCondition = getWeatherCondition(weatherCode.toString().toInt(), dayOrNight.toString());



        // Update the UI with the combined data from both APIs
        QObject *textObject = engine.rootObjects().first()->findChild<QObject*>("temp");
        if (textObject) {
            textObject->setProperty("tempText", temp.toString());
        }

        QObject *mainIcon = engine.rootObjects().first()->findChild<QObject*>("mainIcon");
        if (mainIcon) {
            mainIcon->setProperty("source", "file:icon/" + currentCondition.iconName + ".png");
        }

        // After processing selectedData
        for (int i = 0; i < selectedData.size(); ++i) {
            QJsonObject entry = selectedData.at(i).toObject();
            QString dayObjectName = QStringLiteral("hourly_%1").arg(i + 1);
            QObject *dayObject = engine.rootObjects().first()->findChild<QObject*>(dayObjectName);
            if (dayObject) {
                QString tempObjectName = QString("hourlyTemp").arg(dayObjectName);
                QObject *tempObject = dayObject->findChild<QObject*>(tempObjectName);
                if (tempObject) {
                    tempObject->setProperty("hourTemp", entry.value("temp").toString() + "°");
                }

                QString iconObjectName = QString("hourlyIcon").arg(dayObjectName);
                QObject *iconObject = dayObject->findChild<QObject*>(iconObjectName);
                if (iconObject) {
                    QString iconSource = "file:icon/" + getWeatherCondition(entry.value("wx").toString().toInt(), entry.value("dayOrNight").toString()).iconName + ".png";
                    iconObject->setProperty("source", iconSource);
                }

                QString timeObjectName = QString("hourlyText").arg(dayObjectName);
                QObject *timeObject = dayObject->findChild<QObject*>(timeObjectName);
                if (timeObject) {
                    timeObject->setProperty("hourText", entry.value("hour").toString() + ":00");
                }
            }
        }
                // Fetch data from the second API
        QNetworkReply *reply2 = manager.get(QNetworkRequest(QUrl("https://www.kr-weathernews.com/mv3/if/main_v4.fcgi?loc=1150010300&language=en")));
        QEventLoop loop2;
        QObject::connect(reply2, &QNetworkReply::finished, &loop2, &QEventLoop::quit);
        loop2.exec();
        QByteArray data2 = reply2->readAll();
        QJsonDocument doc2 = QJsonDocument::fromJson(data2);
        QJsonObject obj2 = doc2.object();
        QJsonValue daily = obj2.value("daily");
        QJsonArray selectedData2 = get_every_something_element(daily.toArray(),1,8);


        for (int i = 0; i < selectedData2.size(); ++i) {
            QJsonObject entry = selectedData2.at(i).toObject();
            QString dayObjectName = QStringLiteral("daily_%1").arg(i + 1);
            QObject *dayObject = engine.rootObjects().first()->findChild<QObject*>(dayObjectName);
            if (dayObject) {
                QString tempObjectName_1 = QString("dailyTemp_1").arg(dayObjectName);
                QObject *tempObject_1 = dayObject->findChild<QObject*>(tempObjectName_1);
                if (tempObject_1) {
                    tempObject_1->setProperty("tempText", QString::number(entry.value("tmax").toDouble()) + "°");
                }
                QString tempObjectName_2 = QString("dailyTemp_2").arg(dayObjectName);
                QObject *tempObject_2 = dayObject->findChild<QObject*>(tempObjectName_2);
                if (tempObject_2) {
                    tempObject_2->setProperty("tempText", QString::number(entry.value("tmin").toDouble()) + "°");
                }

                QString iconObjectName_1 = QString("dailyIcon_1").arg(dayObjectName);
                QObject *iconObject_1 = dayObject->findChild<QObject*>(iconObjectName_1);
                if (iconObject_1) {
                    QString iconSource = "file:icon/" + getWeatherCondition(entry.value("wx_am").toString().toInt(), "D").iconName + ".png";
                    iconObject_1->setProperty("source", iconSource);
                }
                QString iconObjectName_2 = QString("dailyIcon_2").arg(dayObjectName);
                QObject *iconObject_2 = dayObject->findChild<QObject*>(iconObjectName_2);
                if (iconObject_2) {
                    QString iconSource = "file:icon/" + getWeatherCondition(entry.value("wx_pm").toString().toInt(), "N").iconName + ".png";
                    iconObject_2->setProperty("source", iconSource);
                }

                QString weekdayObjectName = QString("dailyText").arg(dayObjectName);
                QObject *weekdayObject = dayObject->findChild<QObject*>(weekdayObjectName);
                if (weekdayObject) {
                    qDebug() << entry.value("TimeLocal").toString();
                    QString weekday = getWeekdayFromTimestamp(entry.value("TimeLocal").toString());
                    weekdayObject->setProperty("weekDay", weekday);
                }
                QString timeObjectName = QString("dailyText").arg(dayObjectName);
                QObject *timeObject = dayObject->findChild<QObject*>(timeObjectName);
                if (timeObject) {
                    timeObject->setProperty("dailyText", entry.value("day").toString());
                }
            }
        }

        // Release the network replies to avoid memory leaks
        reply1->deleteLater();
        reply2->deleteLater();
    };


    // Run the updateWeather function immediately
    updateWeather();

    // Set up a timer to run updateWeather every 30 minutes
    QTimer timer;
    QObject::connect(&timer, &QTimer::timeout, updateWeather);
    timer.start(30 * 60 * 1000);


    return app.exec();
}
