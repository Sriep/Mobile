/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <QtCore/QByteArray>
#include <QtCore/QDir>
#include <QtCore/QLibraryInfo>
#include <QtCore/QProcess>
#include <QDebug>
#include <QDir>

#include <QtWidgets/QMessageBox>

#include "assistant.h"

Assistant::Assistant()
    : proc(0)
{
}

Assistant::~Assistant()
{
    if (proc && proc->state() == QProcess::Running) {
        proc->terminate();
        proc->waitForFinished(3000);
    }
    delete proc;
}

void Assistant::showDocumentation(const QString &page)
{
    if (!initAssistant())
        return;

    QByteArray ba("SetSource ");
    ba.append("qthelp://easyeventapps.com.eventorganiser/doc/"
              + page.toLocal8Bit()
              + '\n');
    proc->write(ba);
    qDebug() << "help page: " << ba;
    /*ba.append("../EventOrganiser/Documents/html/"
    ba.append("E:/Mobile/Mobile/EventOrganiser/Documents/html/"
              + page.toLocal8Bit()
              + '\n');
    proc->write(ba);
    qDebug() << "help page: " << ba;
    qDebug() << "current dir" << QDir::currentPath();
*/
    //proc->write(ba + page.toLocal8Bit() + '\n');
    //current dir "E:/Mobile/Mobile/build-EventOrganiser-Desktop_Qt_5_8_0_MSVC2015_64bit-Debug"
}

bool Assistant::initAssistant()
{
    if (!proc)
        proc = new QProcess();

    if (proc->state() != QProcess::Running)
    {
        QString app = QLibraryInfo::location(QLibraryInfo::BinariesPath)
                    + QDir::separator();
#if !defined(Q_OS_MAC)
        app += QLatin1String("assistant");
#else
        app += QLatin1String("Assistant.app/Contents/MacOS/Assistant");
#endif
        QString cwd = QDir::currentPath();

        QStringList args;
        args << QLatin1String("-collectionFile")
            //<< QLatin1String("../EventOrganiser/Documents/eventApp.qhc")
            << QLatin1String("eventApp.qhc")
            << QLatin1String("-enableRemoteControl");
        //:/Documents/eventApp.qhc
        //qrc:/Documents/eventApp.qhc
        //:/images/cut.png or the URL qrc:///images/cut.png
        // cp ../EventOrganiser/Documents/eventApp.qhc evetApp.qhc

        proc->start(app, args);

        if (!proc->waitForStarted())
        {
            QMessageBox::critical(0, QObject::tr("Event organiser"),
                QObject::tr("Unable to launch Qt Assistant (%1)").arg(app));
            return false;
        }
    }
    return true;
}

void Assistant::startAssistant(QString startFile)
{
    showDocumentation(startFile);//"index.html");
}





























