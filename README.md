# Time Series Forecasting-ARIMA

## Introduction
This project aim is familiarising us with time series modeling. The benefit of having a time series is predicting the future and restoring missing values.
There are steps to prepare the time series for using in statistical process. First, defining the time series is stationary or not, having missing values or outliers by looking at a plot of the time series data and auto-correlation and partial autocorrelation plots.
Ones the time series has stationary behavior, the next step is to find the model for the stationary time series.
In this project, we are looking at Autoregressive moving average model briefly ARIMA. For finding the ARIMA model that suits to the stationary time series, we need to take a look at ACF and PACF plot and their corresponding coefficients to determine the parameter of the ARIMA model that fits the best. On the other hand, the challenge of time series analysis is to find the best fitting model with least coefficients.
The next step is training the model and estimate the model to verify its the best fitted model. As last step of validation it has to be analyzed that the residuals of the model are white noise. Finally, we determine the best model that can predict the future.

## Dataset and Challenges
The data are chosen from the Time series data library, which represented the number of births per month in New York City from January 1946 to December 1959.The data units of measurements are time and the number of births. The time range starts from January 1946 until December 1959.The number of births in total is 168 items. This data is available in the file http://robjhyndman.com/tsdldata/data/nybirths.dat We can read the data into R, and store it as a time series object.

The problem is fascinating in two specific reasons: First without knowing the size and the composition of the local population, how can local authorities decide how much and what type of essential services to provide? Second: controlling the population by forecasting the number of births in the future. The most challenging part related to number of birth because it could be some absent families or the birth of the child not reported.

![Getting Started](image/time_series.jpg)



# Dataset and Challenges
The dataset could be found in kaggle: https://www.kaggle.com/mlg-ulb/creditcardfraud.
The dataset consists of +200k rows with 20+ features that have gone trough a PCA pipeline. Only time and amount variable contain non transformed features. The dataset is highly imbalanced, there is a lot of normal data in comparison with abnormal data. For instance, 90 percent of data points are included for one class and 10 percent for the other. It caused performance measures (aka standard optimiza-
tion criteria) not to be as effective.



## Notebook

- A Neural Network (NN) classifier built that can predict the class column of the transactions,
- Next part, we droped the class column of the dataset and trained three unsupervised machine learning model that assign the lable of anomalous.
- provided the performance metrics that is considered appropriate.
- Compared and dicussed two supervised and unsupervised approaches.

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/marziehphi/credit-card-fraud-detection/blob/master/notes/anomaly_detection_using_ml.ipynb)
