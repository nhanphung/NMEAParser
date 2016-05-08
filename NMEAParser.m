close all; clear; clc;
format longG

[fileName, pathName] = uigetfile('*.txt', 'Select GPS data file:');
fileName = strrep(fileName, 'TXT', 'txt');
GPS = readtable([pathName fileName], 'ReadVariableNames', false, 'Format', '%s%s%s%s%s%s%s%s%s%s%s%s%s');
[rows, cols] = size(GPS);

numOfDec = 10^5;

T = cell(rows, 5);

for i = 1:rows
    time = getTime(GPS.Var2(i));
    date = getDate(GPS.Var10(i));
    lat = getLat(GPS.Var4(i), GPS.Var5(i));
    lon = getLon(GPS.Var6(i), GPS.Var7(i));
    speed = getSpeed(GPS.Var8(i));
    T{i,1} = time;
    T{i,2} = date;
    T{i,3} = round(lat*numOfDec)/numOfDec;
    T{i,4} = round(lon*numOfDec)/numOfDec;
    T{i,5} = speed;
end

outputFile = array2table(T, 'VariableNames', {'time', 'date', 'latitude', 'longitude', 'speed'});
outputFileName = ['PARSED_' fileName];
writetable(outputFile, outputFileName);
disp('Successfully parsed GPS data');