%Clears memory and screen
clear all;
clc;

%stops scientific notation
format short g;

%Loads Maersk Equity data
path="D:\Google Drive\Ekstern lektor\Monte carlo - Seminar\Youtube\2022 Spring (YT)\Lectures\Lecture 2 - SDE and variance reduction\Equity_Data.xlsx";
EquityData = readtable(path,'Range','A1:B3061');

%Plots 1 years worth of data
subplot(1,3,1); plot(1:length(EquityData.MAERSKBDCEquity),EquityData.MAERSKBDCEquity)
title('Maersk B stock price 2001-2013') 

%Plots model for future

%Example parameters
paths = 20;
y = fGeometricBrownianMotion(1,364,0.04,0.3,46360,paths);

subplot(1,3,2); plot(y)
title('20 simulated paths')

subplot(1,3,3); plot(EquityData.MAERSKBDCEquity(1:365))
title('Realized 2001 stock price')


