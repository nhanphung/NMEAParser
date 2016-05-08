function [ lat ] = getLat( rawLat, direction)
    rawLat = char(rawLat);
    direction = char(direction);

    degree = str2num(rawLat(1:2));
    min = str2num(rawLat(3:end));

    lat = degree + (min / 60);
    if lat == 'S'
        lat = -1*lat;
    end
end
