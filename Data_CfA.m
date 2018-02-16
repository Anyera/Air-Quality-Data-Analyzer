clear
clc
%%%%Reading in the csv files for Data
Temp_Humidity_files=dir('dht22*.csv');
Air_Files=dir('201*.csv');
DHT22_data = [];
SDS_Data = [];
for count = 1:length(Air_Files);
    FileName = Air_Files(count).name;
    SDSData = dlmread(FileName,';',1,6);
    SDS_Data =[SDS_Data;SDSData];
end    

for count = 1:length(Temp_Humidity_files);
    FileName = Temp_Humidity_files(count).name;
    TempData = dlmread(FileName,';',1,6);
    DHT22_data=[DHT22_data;TempData];
end 

A=length(DHT22_data);
%%%%%Temperature and Humidity
     disp("Temperature")
     minimum_Temperature = min(DHT22_data(:,1))
     maximum_Temperature =max(DHT22_data(:,1))
     Average_Temperature = mean(DHT22_data(:,1))
     Std_Dev_Temperature = std(DHT22_data(:,1))
     disp("Humidity")    
     minimum_Humidity = min(DHT22_data(:,2))
     maximum_Humidity = max(DHT22_data(:,2))
     Average_humidity = mean(DHT22_data(:,2))
     Std_Dev_Humidity = std(DHT22_data(:,2))
     
%%%%%%Correaltion between Temperature and Humidity     
     Corr_Temp_Humidity = corr(DHT22_data(:,1),DHT22_data(:,2))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
if length(SDS_Data)<length(DHT22_data)== 1
   DHT22_data = DHT22_data(1:length(SDS_Data),:);
elseif  length(SDS_Data)>length(DHT22_data)==1
   SDS_Data = SDS_Data(1:length(DHT22_data),:);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Sorting low conspicuous values for the readings    
if (min(SDS_Data(:,1))<=1.5) or (min(SDS_Data(:,4))<=0.5);
    data_lowPM = SDS_Data(SDS_Data(:,1) <=1.5, :);
    data_normal = SDS_Data(SDS_Data(:,1)>1.5,:);
%%%%%Finding correlations between observed measurements     
    disp("Data Statistics")
    Corr_all_SDS_Data = corr(SDS_Data(:,1),SDS_Data(:,4))
    Corr_P1_P2_Normal_SDS_Data= corr(data_normal(:,1),data_normal(:,4))
    CorrP1_P2_LowPM = corr(data_lowPM(:,1),data_lowPM(:,4))
    Corr_Temp_P1 = corr(SDS_Data(:,1),DHT22_data(:,1))
    Corr_Temp_P2 = corr(SDS_Data(:,4),DHT22_data(:,1))
    Corr_Humidity_P1 = corr(SDS_Data(:,1),DHT22_data(:,2))
    Corr_Humidity_P2 = corr(SDS_Data(:,4),DHT22_data(:,2))
%%%%%General statistics; minima, maxima, means, Standard Deviations      
    disp("P1")
    minimum_P1 = min(SDS_Data(:,1))
    maximum_P1 = max(SDS_Data(:,1))
    mean_P1 = mean(SDS_Data(:,1))
    Std_Dev_P1 = std(SDS_Data(:,1))
    disp("P2")
    minimum_P2 = min(SDS_Data(:,4))
    maximum_P2 = max(SDS_Data(:,4))
    mean_P2 = mean(SDS_Data(:,4))
    Std_Dev_P2 = std(SDS_Data(:,4))
else
    disp("Data Statistics");
%%%%%Finding correlations between observed measurements       
    Corr_P1_P2 = corr(SDS_Data(:,1),SDS_Data(:,4))
    Corr_Temp_P1 = corr(SDS_Data(:,1),DHT22_data(:,1))
    Corr_Temp_P2 = corr(SDS_Data(:,4),DHT22_data(:,1))
    Corr_Humidity_P1 = corr(SDS_Data(:,1),DHT22_data(:,2))
    Corr_Humidity_P2 = corr(SDS_Data(:,4),DHT22_data(:,2))
%%%%%General statistics; minima, maxima, means, Standard Deviations         
    minimum_P1 = min(SDS_Data(:,1))
    maximum_P1 = max(SDS_Data(:,1)) 
    mean_P1 = mean(SDS_Data(:,1))
    Std_Dev_P1 = std(SDS_Data(:,1))
    disp("P2")
    minimum_P2 = min(SDS_Data(:,4))
    maximum_P2 = max(SDS_Data(:,4))
    mean_P2 = mean(SDS_Data(:,4))
    Std_Dev_P2 = std(SDS_Data(:,4)) 
end 
    
%%%%% Plotting the graphs for Data observed
 plot(DHT22_data(:,1),"r;Temperature;",DHT22_data(:,2),"b;Humidity;")
  ylabel('Temperature in Degrees Celcius and Humidity as %')
  xlabel('Entry Number')
%  hold   
%  plot(SDS_Data(:,1),"k;P1 Concentration Values;",SDS_Data(:,4),"r;P2 Concentration Values;");
%  xlabel('Entry Number');
%  ylabel('PM Concentration in Micrograms per cubic metre');
