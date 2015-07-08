#include "tutorialupdater.h"

TutorialUpdater::TutorialUpdater(QObject *parent) : QObject(parent)
{
    m_net = new QNetworkAccessManager(this);

    m_progress = 0;
    m_active = false;
    m_statusMessage = "Inactive";
    m_updateAvailable = false;

    m_saveDir = m_settings.value("downloader/download-path").toString();

    if (m_saveDir.lastIndexOf('/') != (m_saveDir.length() - 1))
        m_saveDir.append('/');

    m_index = m_saveDir;
    m_index.append("index.xml");

    if (!QFileInfo::exists(m_index))
        emit requestDownload();

    connect(m_net, &QNetworkAccessManager::networkAccessibleChanged, this, &TutorialUpdater::connectedToInternetChanged);
}

// QML INVOKABLE **********************
void TutorialUpdater::updateTutorials()
{

}

void TutorialUpdater::checkForUpdate()
{
    if (!QFileInfo::exists(m_index))
    {
        m_updateAvailable = true;
        emit updateAvailableChanged();
        return;
    }
    else
    {
        bool buf;

        m_active = true;
        m_statusMessage = "Checking for updates...";

        emit activeChanged();
        emit statusChanged();

        buf = m_updateAvailable;
        m_updateAvailable = (checkIndex().size() > 0);

        if (m_updateAvailable != buf)
            emit updateAvailableChanged();

        m_active = false;
        m_statusMessage = "Inactive";

        emit activeChanged();
        emit statusChanged();

        return;
    }
}

// PROPERTY READ **********************
int TutorialUpdater::progress() const
{
    return m_progress;
}

bool TutorialUpdater::active() const
{
    return m_active;
}

QString TutorialUpdater::status() const
{
    return m_statusMessage;
}

bool TutorialUpdater::updateAvailable() const
{
    return m_updateAvailable;
}

bool TutorialUpdater::connectedToInternet()
{
    return (m_net->networkAccessible() == QNetworkAccessManager::Accessible);
}

// PRIVATE FUNCTIONS ******************
QVector<pageInfo> TutorialUpdater::checkIndex()
{
    QXmlStreamReader xmlr;
}
