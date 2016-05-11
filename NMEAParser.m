% NMEA Parser for Mosquito Zapping Drone
% University of Houston
% Senior Design Team 2016
%
% Sample input: $GPRMC,043710.000,A,2941.4394,N,09537.1506,W,0.19,167.38,080516,,,A*7A
% Sample output: 04:37:10,05/08/2016,29.69066,-95.61918,0.19

close all; clear; clc;
format longG

% import raw data from a text files
[gpsFileName, gpsPathName]      = uigetfile('*.txt', 'Select GPS data file:');
[voltFileName, voltPathName]    = uigetfile('*.txt', 'Select Voltage data file:');
gpsFileName                     = strrep(gpsFileName, 'TXT', 'txt');
voltFileName                    = strrep(voltFileName, 'TXT', 'txt');
% put raw data into a table
GPS     = readtable([gpsPathName gpsFileName], 'ReadVariableNames', false, 'Format', '%s%s%s%s%s%s%s%s%s%s%s%s%s');
Voltages = readtable([voltPathName voltFileName], 'ReadVariableNames', false);
[gpsRows, gpsCols] = size(GPS);
[voltRows, voltCols] = size(Voltages);

% define number of decimal places for latitude and longitude
numOfDec = 10^5;

% allocate parsed cell array
flightPath = cell(gpsRows, 5);

% parsing useful information
for i = 1:gpsRows
    check = char(GPS.Var1(i));
    if (isempty(strfind(check, '$GPRMC')) == false)
        time = getTime(GPS.Var2(i));
        date = getDate(GPS.Var10(i));
        lat = getLat(GPS.Var4(i), GPS.Var5(i));
        lon = getLon(GPS.Var6(i), GPS.Var7(i));
        speed = getSpeed(GPS.Var8(i));
        flightPath{i,1} = time;
        flightPath{i,2} = date;
        flightPath{i,3} = round(lat*numOfDec)/numOfDec;
        flightPath{i,4} = round(lon*numOfDec)/numOfDec;
        flightPath{i,5} = speed;
    end
end
[flightPathRows, flightPathCols] = size(flightPath);

% TODO get final table of voltage data
changeOne = 0;
changeTwo = 0;
changeThree = 0;
for i = 2:voltRows
    if (Voltages.Var2(i) ~= Voltages.Var2(i - 1))
        changeOne = changeOne + 1;
        netOne(changeOne) = Voltages.Var7(i);
    end
    if (Voltages.Var4(i) ~= Voltages.Var4(i - 1))
        changeTwo = changeTwo + 1;
        netTwo(changeTwo) = Voltages.Var7(i);
    end
    if (Voltages.Var6(i) ~= Voltages.Var6(i - 1))
        changeThree = changeThree + 1;
        netThree(changeThree) = Voltages.Var7(i);
    end
end

netOne = unique(netOne');
netTwo = unique(netTwo');
netThree = unique(netThree');

% TODO get strikes data
strikes = [netOne; netTwo; netThree];
strikes = unique(strikes);
strikes = fixStrikesTime(strikes);
[strikeRows, strikeCols] = size(strikes);

for i = 1 : strikeRows
    for j = 1 : flightPathRows
        if strcmp(strikes(i), flightPath(j,1))
            strikes(i, 2) = flightPath(j, 3);
            strikes(i, 3) = flightPath(j, 4);
        end
    end
end

% convert cell array to a table with appropriate headers
outputFlightPath = array2table(flightPath, 'VariableNames', {'time', 'date', 'latitude', 'longitude', 'speed'});
outputStrikes = array2table(strikes, 'VariableNames', {'time', 'latitude', 'longitude'});
[outputFPFileName, outputFPPath] =  uiputfile(['PARSED_' gpsFileName]);
[outputSFileName, outputSPath] = uiputfile(['PARSED_' voltFileName]);
% write table to another text file
writetable(outputFlightPath, [outputFPPath outputFPFileName]);
writetable(outputStrikes, [outputSPath outputSFileName]);
disp(['Successfully parsed GPS data. Output file is: ' outputFPFileName]);
disp(['Successfully correlated strikes. Output file is: ' outputSFileName]);