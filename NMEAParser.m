% NMEA Parser for Mosquito Zapping Drone
% University of Houston
% Senior Design Team 2016
%
% Sample input: $GPRMC,043710.000,A,2941.4394,N,09537.1506,W,0.19,167.38,080516,,,A*7A
% Sample output: 04:37:10,05/08/2016,29.69066,-95.61918,0.19

close all; clear; clc;
format longG

% import raw data from a text file
[fileName, pathName] = uigetfile('*.txt', 'Select GPS data file:');
fileName = strrep(fileName, 'TXT', 'txt');
% put raw data into a table
GPS = readtable([pathName fileName], 'ReadVariableNames', false, 'Format', '%s%s%s%s%s%s%s%s%s%s%s%s%s');
[rows, cols] = size(GPS);

% define number of decimal places for latitude and longitude
numOfDec = 10^5;

% allocate parsed cell array
T = cell(rows, 5);

% parsing useful information
for i = 1:rows
    check = char(GPS.Var1(i));
    if (isempty(strfind(check, '$GPRMC')) == false)
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
end

% convert cell array to a table with appropriate headers
outputFile = array2table(T, 'VariableNames', {'time', 'date', 'latitude', 'longitude', 'speed'});
[outputFileName, outputPath] =  uiputfile(['PARSED_' fileName]);
% write table to another text file
writetable(outputFile, [outputPath outputFileName]);
disp(['Successfully parsed GPS data. Output file is: ' outputFileName]);