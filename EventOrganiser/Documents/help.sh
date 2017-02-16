qhelpgenerator eventApp.qhp -o eventApp.qch
assistant -register eventApp.qch
qcollectiongenerator eventApp.qhcp -o eventApp.qhc
assistant -collectionFile eventApp.qhc
