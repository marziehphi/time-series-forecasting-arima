# Time Series Forecasting-SARIMA

## Introduction
This project aim is familiarising us with time series modeling. The benefit of having a time series is predicting the future and restoring missing values.
There are steps to prepare the time series for using in statistical process. First, defining the time series is stationary or not, having missing values or outliers by looking at a plot of the time series data and auto-correlation and partial autocorrelation plots.
Ones the time series has stationary behavior, the next step is to find the model for the stationary time series.
In this project, we are looking at Seasonal Autoregressive moving average model briefly SARIMA. For finding the SARIMA model that suits to the stationary time series, we need to take a look at ACF and PACF plot and their corresponding coefficients to determine the parameter of the SARIMA model that fits the best. On the other hand, the challenge of time series analysis is to find the best fitting model with least coefficients.
The next step is training the model and estimate the model to verify its the best fitted model. As last step of validation it has to be analyzed that the residuals of the model are white noise. Finally, we determine the best model that can predict the future.

## Dataset and Challenges
The data are chosen from the Time series data library, which represented the number of births per month in New York City from January 1946 to December 1959.The data units of measurements are time and the number of births. The time range starts from January 1946 until December 1959.The number of births in total is 168 items. This data is available in the file http://robjhyndman.com/tsdldata/data/nybirths.dat We can read the data into R, and store it as a time series object.

The problem is fascinating in two specific reasons: First without knowing the size and the composition of the local population, how can local authorities decide how much and what type of essential services to provide? Second: controlling the population by forecasting the number of births in the future. The most challenging part related to number of birth because it could be some absent families or the birth of the child that was not reported.

![plot](assets/data.png)

## Identification

The ACF shows exponential decay.The above ACF is decreasing, very slowly, and remains well above the significance range (dotted blue lines). This is indicative of a non-stationary series.

![plot](assets/ACF.png)

The time series has both seasonality with period 12 and trend. To ensure that there is no hidden periodicity, we need to take a look at the periodogram.

The plot of the periodogram shows a sequence of peaks that stand out from the background noise. In the plot, the lowest frequency peak happens at a frequency of just less than 0.1.  Because period and frequency are reciprocals of each other, a period of 12 corresponds to a rate of 1/12 (or 0.083) and an annual component implies a peak in the periodogram at 0.083. The next question is what about the other peaks at higher frequencies. The periodogram is calculated by modeling the time series as the sum of cosine and sine functions. Periodic components that have the shape of a sine or cosine function (sinusoidal) show up in the periodogram as single peaks. The periodic components that are not sinusoidal show up as a series of equally spaced peaks of different heights, with the lowest frequency peak in the sequence occurring at the frequency of the periodic component. The four higher frequency peaks in the spectral density indicate that the annual periodic component is not sinusoidal. You have now accounted for all of the discernible structure in the spectral density plot and conclude that the time series contains a single periodic component with a period of 12 months.

![plot](assets/periodogram.png)

## Eliminate the seasonality and trend

The easy method is to differentiate the time series.
From the first plot we can still observe non stationary after once differencing, but after second differencing we get the excellent result.

![plot](assets/Deseasonality_1.png)
![plot](assets/Deseasonality_2.png)

## Estimation and Verification

At first, we separate the data set into two subsets. One part is for the estimation of the model and the other one is for validation of the prediction of the model. The train data contains the time series except for the last 24 values. The test data only includes the last 24 observations.The data sets shown in following plots.

![plot](assets/train.png)
![plot](assets/test.png)

we estimate the model with first guess, but also compare it with the other models. the important part of estimation is to choose a model that has a low AIC value, but also has not too many coefficients. The residuals have to be white noise with normal distribution.

| Model | AIC | Coefficients | Log Likelihood | Variance |
|-|-|-|-|-|
| (2, 0, 0)(0, 1, 1) | 292.41 | ar1 and a12 not sign | -142.20 | 0.4008 |
| (3, 0, 3)(0, 1, 1) | 289.42 | only ar2 and ma3 sign | -136.71 | 0.3721 |
| (1, 0, 3)(0, 1, 1) | 286.8 | ar1 not sign | -137.40 | 0.3766 |
| (0, 1, 3)(0, 1, 1) | 284.94 | all significant | -137.47 | 0.3296 |

After comparing those factors which demonstrate in the table. We can observe a SARIMA(0, 1, 3)(0, 1, 1) model fits best for the underlying data since the model has the best AIC value, and significant coefficients and small variance.

To analysis the residuals of the model, the best way is looking at the ACF and the p-values for Ljung-Box statistic. The residuals seem to be stationary, and
even the ACF does not show any trend or seasonality. At least, p-values for Ljung-Box statistic is in excellent condition. As a result, they behave as white noise. As well as the residuals based on the histogram and the qq-plot give reason to suppose normally distributed residuals.( W = 0.98517 and P-value = 0.1239)

ALso, raw and a smoothed periodogram of residuals are shown. 

![plot](assets/residual_acf_pacf.jpeg)
![plot](assets/qq-plot.png)
![plot](assets/Spectral.png)


## Prediction
The final step of this time series analysis process is the prediction of the 24 observation from the test data set. The aim is to get the best forecast for future values. Then compared with the real data. In the figure, we can see the train and test subsets as (blue lines) and the predicted values for the years 1958 and 1959 as (red line with points), and the confidence interval of all predicted values as (striped red lines).
According to the predicted values and the confidence interval, we can say, we reach to the best-fitted model for the data sets. Except for two observations which are close to the outer confidence band. the real observation predicted good or even excellent for some observation.

![plot](assets/prediction.jpeg)


## Conclusion

The model that fits the best for this time series is a SARIMA <img src="https://render.githubusercontent.com/render/math?math=\(0, 1, 3)(0, 1, 1)_{12}" alt="">  model with the following coefficients.


<img src="https://render.githubusercontent.com/render/math?math=\theta_{1} = -0.0651" alt=""> with standard error 0.0931

<img src="https://render.githubusercontent.com/render/math?math=\theta_{2} = -0.1849" alt=""> with standard error 0.0816

<img src="https://render.githubusercontent.com/render/math?math=\theta_{3} = -0.1556" alt=""> with standard error 0.0956

<img src="https://render.githubusercontent.com/render/math?math=\theta_{4} = -0.9656" alt=""> with standard error 0.4127


The residuals are normally distributed with expectation <img src="https://render.githubusercontent.com/render/math?math=\\mu = 0" alt=""> and variance <img src="https://render.githubusercontent.com/render/math?math=\\sigma^{2} = 0.3348774" alt="">.

A comparison of AIC values of different models shown in  Estimation and verification Table. Based on the result, the model with enough coefficients, best AIC, and small variance choose as the preferred model. we also plot the AIC values of different models. Another positive aspect of the model is, the normal distribution behavior of the residuals.

