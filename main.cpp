#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtGlobal>
#include <QSettings>
#include <QStandardPaths>

void initializeSettings();

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setApplicationName("pt-app");

    app.setOrganizationDomain("org");
    app.setOrganizationName("hotteam67");

    initializeSettings();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

void initializeSettings ()
{
    QSettings settings;

    if (settings.value("firstrun",1).toInt() == 1)
    {
        QString saveDir;
        settings.setValue("firstrun",0);

#ifdef Q_OS_ANDROID
        QStringList saveDirs;
        saveDirs = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);

        if (saveDirs.size() < 1)
        {
            int x;

            for (x = 0; x < saveDirs.size(); x++)
            {
                if (saveDirs.at(x).contains("storage"))
                    break;
                else if (saveDirs.at(x).contains("sdcard"))
                    break;
                else if (saveDirs.at(x).contains("mnt"))
                    break;
            }

            saveDir = saveDirs.at(x);
        }
        else
            saveDir = saveDirs.at(0);
#else
        saveDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
#endif

        settings.beginGroup("downloader");
        settings.setValue("download-path",saveDir);
        settings.setValue("upstream","https://raw.githubusercontent.com/hal7df/pauls-tutorials/master/files/index.xml");
        settings.endGroup();
    }
}
