#ifndef TUTORIALUPDATER_H
#define TUTORIALUPDATER_H

#include <QObject>
#include <QSettings>
#include <QXmlStreamReader>
#include <QXmlStreamWriter>
#include <QFileInfo>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QNetworkConfigurationManager>

struct pageInfo {
    int chapter;
    int lesson;
    QString name;
    QString src;
    bool overview;
};

class TutorialUpdater : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double progress READ progress NOTIFY progressChanged) //-1: indeterminate; 0-1: progress
    Q_PROPERTY(bool active READ active NOTIFY activeChanged)
    Q_PROPERTY(QString status READ status NOTIFY statusChanged)
    Q_PROPERTY(bool updateAvailable READ updateAvailable NOTIFY updateAvailableChanged)
    Q_PROPERTY(bool connectedToInternet READ connectedToInternet NOTIFY connectedToInternetChanged)
public:
    explicit TutorialUpdater(QObject *parent = 0);
    
    //QML INVOKABLE *********
    Q_INVOKABLE void updateTutorials();
    Q_INVOKABLE void checkForUpdate();
    
    //PROPERTY READ *********
    int progress() const;
    bool active() const;
    QString status() const;
    bool updateAvailable() const;
    bool connectedToInternet();

signals:
    void requestDownload();

    //PROPERTY NOTIFY *******
    void progressChanged();
    void activeChanged();
    void statusChanged();
    void updateAvailableChanged();
    void connectedToInternetChanged();
    
public slots:
    
private:
    QVector<pageInfo> checkIndex();
    void downloadFile (QString url);
    
    //PROPERTIES ************
    int m_progress;
    bool m_updateAvailable, m_active;

    QString m_saveDir, m_index;
    QString m_statusMessage;
    QSettings m_settings;
    QNetworkAccessManager* m_net;
};

#endif // TUTORIALUPDATER_H
