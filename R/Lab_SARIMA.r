
# Name: Marzieh_Farahani
# Project_Title: Time series Forecasting SARIMA
# Date: 10-5-2021

###################################
#           Time series 
###################################

# Remove all Variables and Graphics First
getwd()
rm(list=ls())       
graphics.off()

---------------------------------------------
# Read the data
births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")

#############
# Identification
#############

# Tranformation the data into an Time series_object

td <- ts(births, frequency=12, start=c(1946,1))

# Plot of the Time series

X11()
plot.ts(td, xlab= "Time", ylab= " ", 
        main= "the number of births per month in New York city", col= "blue")
x11()
acf(td, lag.max = 50)

#########################
# Periodicoty Test
########################

# Test if there is no hidden periodicity (ASk about the null and periodic??)

# Raw time series without defining frequency
X11()
TS <- ts(births, start=c(1946,1))  
par(mfcol= c(1, 1))
spec.pgram(TS, spans = c(3, 3), log = "no")
spec.pgram(TS, spans = c(5, 5))
x11()
par(mfcol= c(1, 1))
spec.pgram(TS, spans = c(3, 3), log="no")
(frmax <- locator(1))
(fr<-frmax $births)
(tper = 1/fr)

##############################
# Differencing the time series 
#############################
X11()
par(mfcol=c(3,1))

y<-log(td)
plot(y, xlab = "Year", ylab= "log-y", main = "The log-births data")

# Visible trend, seasonal component.
# try 12 differencing

dy12 = diff(y, lag = 12)
plot(dy12, xlab = "Year", ylab= "dy12", main = "The diff12-log-births data")

# Take look at ACF
acf(dy12, lag.max = 50)

X11()
par(mfrow=c(3,1))

#-------------------------------------------
###### Still no stationarity
#-------------------------------------------

# More differencing
ddy12 = diff(dy12)  
plot(ddy12, xlab = "Year", ylab= "ddy12", main = "The dd12-log-births data")

acf(ddy12, lag.max = 50)

pacf(ddy12, lag.max = 50)

ar(ddy12)

##############
# Estimation
##############

#split the data

(train<-ts(td[1:(length(td)-24)], start = c(1946, 1), frequency = 12))
(test<-ts(td[(length(td)-23):length(td)], start = c(1958, 1), frequency = 12))
window()
plot(train, xlab="Time", ylab="", main="Train Data set")
plot(test, xlab="Time", ylab="", main="Test Data set")

# Estimation the model 
# first guess
(try<- arima(train, order = c(1, 0, 3), seasonal = list(order=c(0, 1, 1))))
# Call:
#arima(x = train, order = c(1, 0, 3), seasonal = list(order = c(0, 1, 1)))

#Coefficients:
#       ar1      ma1      ma2      ma3     sma1
#      0.9955  -0.0693  -0.1888  -0.1573  -1.0000
#s.e.  0.0139   0.0920   0.0810   0.0937   0.1083

#sigma^2 estimated as 0.3766:  log likelihood = -137.4,  aic = 286.8
#---------------------------------------------------------------------
(try1<- arima(train, order = c(2, 0, 0), seasonal = list(order=c(0, 1, 1))))
#Call:
#  arima(x = train, order = c(2, 0, 0), seasonal = list(order = c(0, 1, 1)))

#Coefficients:
#         ar1     ar2     sma1
#       0.9457  0.0263  -0.9999
# s.e.  0.0889  0.0896   0.1412

#sigma^2 estimated as 0.4008:  log likelihood = -142.2,  aic = 292.41
#----------------------------------------------------------------------
(try2<- arima(train, order = c(3, 0, 3), seasonal = list(order=c(0, 1, 1))))
#Call:
# arima(x = train, order = c(3, 0, 3), seasonal = list(order = c(0, 1, 1)))

#Coefficients:
#         ar1      ar2     ar3     ma1     ma2      ma3     sma1
#       0.8207  -0.0960  0.2678  0.0881  0.0419  -0.2328  -1.0000
# s.e.  0.4774   0.6437  0.2955  0.4689  0.3025   0.1296   0.1103

#sigma^2 estimated as 0.3721:  log likelihood = -136.71,  aic = 289.42
#---------------------------------------------------------------------
(try3<- arima(train, order = c(0, 1, 3), seasonal = list(order=c(0, 1, 1))))
#Call:
#  arima(x = train, order = c(0, 1, 3), seasonal = list(order = c(0, 1, 1)))

#Coefficients:
#         ma1      ma2      ma3     sma1
#       -0.0651  -0.1849  -0.1556  -0.9656
# s.e.   0.0931   0.0816   0.0946   0.4127

#sigma^2 estimated as 0.3296:  log likelihood = -137.47,  aic = 284.94

##################
#Estimate the model with best AIC
##################

(ts3.fit<-arima(train, order = c(0, 1, 3), seasonal = list(order=c(0, 1, 1))))

# Tests, the residuals are white noise or even normally distributed

x11()
tsdiag(ts3.fit)
ts3.res<-ts3.fit$residuals
var(ts3.res)
par(mfcol=c(2,1))
hist(ts3.res, col = "gray")
qqnorm(ts3.res)
qqline(ts3.res)

#shapiro test
shapiro.test(ts3.res)

--------------------------------
#data:  ts3.res
#W = 0.98517, p-value = 0.1239
-------------------------------
  
# control spectral analysis 
X11()
cpgram(ts3.res, main="Cumulative periodogram of the residuals")
par(mfcol=c(2,1))
spec.pgram(ddy12, spans=c(3,3), log="no", main="Births")
spec.pgram(ts3.res, spans=c(5,5), log="no", main="Residuals: Births data")

####################################
#prediction of the whole time series
####################################

(ts.pred<-predict(ts3.fit,n.ahead = 24))
x11()
plot(train, xlim=c(1946,1959),col="blue", 
     ylab="Mean births",
     main="The time series with the left out values,
     predicted values and their 95% confidense bounds",
     xlab="Time [Years]")
lines(test, col="blue",type="o")
lines(ts.pred$pred, col="red", type="o")
lines(ts.pred$pred+2*ts.pred$se, col="red", lty=3)
lines(ts.pred$pred-2*ts.pred$se, col="red", lty=3)


