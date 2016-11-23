#include <QtQml>

#include "ealistmodel.h"
#include "QStringList"

EAListModel::EAListModel()
{
}

void EAListModel::constructModel()
{
    //QQuickView view;
    //QQmlContext *ctxt = view.rootContext();
    QQmlContext *ctxt = qmlContext(this);
    ctxt->setContextProperty(listName(), QVariant::fromValue(propertyList));
}

void EAListModel::read(const QJsonArray &jsonArray)
{
    for (int i = 0; i < jsonArray.size(); ++i) {
        QString property = jsonArray[i].toString();
        propertyList.append(property);
    }
}

void EAListModel::write(QJsonArray &jsonArray) const
{
    for ( int i=0 ; i<propertyList.length() ; i++ )
    {
        jsonArray.append(propertyList[i]);
    }
}

QString EAListModel::listName() const
{
    return m_listName;
}

void EAListModel::setListName(QString listName)
{
    if (m_listName == listName)
        return;

    m_listName = listName;
    emit listNameChanged(listName);
}
