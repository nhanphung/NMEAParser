function [ time ] = getTime( rawTime )
    rawTime = char(rawTime);
    
    hour = rawTime(1:2);
    minute = rawTime(3:4);
    second = rawTime(5:6);
    
    time = strcat(hour, ':', minute, ':', second);
end

