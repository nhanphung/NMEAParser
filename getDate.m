function [ date ] = getDate( rawDate )
    rawDate = char(rawDate);
    month   = rawDate(3:4);
    day     = rawDate(1:2);
    year    = rawDate(5:6);
    date    = [month '/' day '/' '20' year]  ;
end

