#include "eastrings.h"


EAStrings::EAStrings()
{

}

void EAStrings::read(const QJsonObject &json)
{
    setTbLoggedOff(json["tbLoggedOff"].toString());

    setMLogin(json["mLogin"].toString());
    setMLoadFKey(json["mLoadFKey"].toString());
    setMnLoadFFile(json["mLoadFFile"].toString());
    setMLoadFFirebase(json["mLoadFFirebase"].toString());
    setMAbout(json["mAbout"].toString());
    setMExit(json["mExit"].toString());

    setLUserId(json["lUserId"].toString());
    setLPassword(json["lPassword"].toString());

    setLkDownlaodFKey(json["lkDownlaodFKey"].toString());
    setLfDownloadUrl(json["lfDownloadUrl"].toString());
    setLfFirebaseUrl(json["lfFirebaseUrl"].toString());

    setAboutText(json["aboutText"].toString());

    setBRegister(json["bRegister"].toString());
    setBLogin(json["bLogin"].toString());
    setBExit(json["bExit"].toString());
    setBLogoff(json["bLogoff"].toString());
    setBDownlaod(json["bDownlaod"].toString());
}

void EAStrings::write(QJsonObject &json)
{
    json["tbLoggedOff"] = tbLoggedOff();

    json["mLogin"] = mLogin();
    json["mLoadFKey"] = mLoadFKey();
    json["mLoadFFile"] = mLoadFFile();
    json["mLoadFFirebase"] = mLoadFFirebase();
    json["mAbout"] = mAbout();
    json["mExit"] = mExit();

    json["lUserId"] = lUserId();
    json["lPassword"] = lPassword();

    json["lkDownlaodFKey"] = lkDownlaodFKey();
    json["lfDownloadUrl"] = lfDownloadUrl();
    json["lfFirebaseUrl"] = lfFirebaseUrl();

    json["aboutText"] = aboutText();

    json["bRegister"] = bRegister();
    json["bLogin"] = bLogin();
    json["bExit"] = bExit();
    json["bLogoff"] = bLogoff();
    json["bDownlaod"] = bDownlaod();
}
