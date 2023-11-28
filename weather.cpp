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
        {100, 130, "sun"},
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
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QNetworkAccessManager manager;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("./Screen01.qml")));
    auto updateWeather = [&]() {
        // Your existing code for fetching and updating weather information
        QNetworkReply *reply = manager.get(QNetworkRequest(QUrl("https://www.kr-weathernews.com/mv3/if/today_v2.fcgi?region=1150010300")));
        QEventLoop loop;
        QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
        loop.exec();
        QByteArray data = reply->readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        QJsonObject obj = doc.object();
        QJsonValue temp = obj.value("current").toObject().value("temp");
        QJsonValue wspd = obj.value("current").toObject().value("wspd");
        QJsonValue rhum = obj.value("current").toObject().value("rhum");
        QJsonValue prec = obj.value("current").toObject().value("prec");
        QJsonValue weatherCode = obj.value("current").toObject().value("wx");
        QJsonValue dayOrNight = obj.value("current").toObject().value("dayOrNight");
        WeatherCondition currentCondition = getWeatherCondition(weatherCode.toString().toInt(),dayOrNight.toString());
        qWarning() << currentCondition.iconName;

        // Update the UI with the new weather information
        QObject *textObject = engine.rootObjects().first()->findChild<QObject*>("temp");
        if (textObject) {
            textObject->setProperty("tempText", temp.toString());
        }

        QObject *mainIcon = engine.rootObjects().first()->findChild<QObject*>("mainIcon");
        if (mainIcon) {
            mainIcon->setProperty("source", "file://home/barryallen/weather/icon/" + currentCondition.iconName + ".png");
        }
        
    };

    // Run the updateWeather function immediately
    updateWeather();

    // Set up a timer to run updateWeather every 30 minutes
    QTimer timer;
    QObject::connect(&timer, &QTimer::timeout, updateWeather);
    timer.start(30 * 60 * 1000);


    return app.exec();
}
