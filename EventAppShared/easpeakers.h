#ifndef EASPEAKERS_H
#define EASPEAKERS_H
#include <QJsonObject>
#include <QQuickItem>
#include <QStringList>

class EAListModel;
class EASpeakers : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString delegateList READ delegateList WRITE setDelegateList NOTIFY delegateListChanged)
    Q_PROPERTY(EAListModel* listModal READ listModal WRITE setListModal NOTIFY listModalChanged)

    QString m_delegateList;
    EAListModel* m_listModal;

public:
    EASpeakers();

    void read(const QJsonObject &json);
    void readCSV(const QString filename);
    void write(QJsonObject &json) const;

    QString delegateList() const;
    EAListModel* listModal() const;

signals:

    void delegateListChanged(QString delegateList);

    void listModalChanged(EAListModel* listModal);

public slots:
    void setDelegateList(QString delegateList);
    void setListModal(EAListModel* listModal);

private:
    void addSpeakerFields(QStringList fields);
    void addSpeaker(QStringList speakerData);


};

#endif // EASPEAKERS_H
