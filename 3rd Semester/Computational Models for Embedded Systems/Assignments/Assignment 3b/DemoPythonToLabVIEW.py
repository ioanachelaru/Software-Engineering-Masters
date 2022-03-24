from random import seed
from random import randint

import numpy as np
from sklearn.cluster import KMeans
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split

def PredictInACluster(numberForPrediction,predictiaPresupusa):
    # seed random number generator
    seed(1)
    # generate some integers
    listN = []
    for _ in range(100):
        numE = []
        numE.insert(0,randint(0, 10))
        listN.insert(0,numE)
    print(listN)

    X = np.array(listN)
    # print('Numerele X=',X)

    kmeans = KMeans(n_clusters=2)
    kmeans.fit(X)
    print("kmeans cluster centers =")
    print(kmeans.cluster_centers_)
    print("kmeans labels=")
    print(kmeans.labels_)
    y = kmeans.labels_
    #print("y clusters=")
    #print(y)

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=0)
    #print('X train')
    #print(X_train)

    logreg = LogisticRegression()
    logreg.fit(X_train, y_train)

    y_predTRAIN = logreg.predict(X_train)
    print('Accuracy of logistic regression classifier on TRAIN set: {:.2f}'.format(logreg.score(X_train, y_train)))
    y_predTEST = logreg.predict(X_test)
    print('Accuracy of logistic regression classifier on TEST set: {:.2f}'.format(logreg.score(X_test, y_test)))
    # print('accuracy TRAIN cu metrics=',metrics.accuracy_score(y_train, y_predTRAIN))
    # print('accuracy TEST cu metrics=',metrics.accuracy_score(y_test, y_predTEST))

    Nr_test=[[numberForPrediction]]
    Nr_y_test=[predictiaPresupusa]
    print('Accuracy of logistic regression classifier on TEST set for ',numberForPrediction,' and 1: {:.2f}'.format(logreg.score(Nr_test, Nr_y_test)))
    predictionAccuracyNumber = logreg.score(Nr_test, Nr_y_test);

    return predictionAccuracyNumber


print('REZULTAT 2 cu clasa 0 are acuratetea=',PredictInACluster(2,0))
#print('REZULTAT 9 cu clasa 1 are acuratetea=',PredictInACluster(9,1))
#print('REZULTAT 5 cu clasa 0 are acuratetea=',PredictInACluster(5,0))


