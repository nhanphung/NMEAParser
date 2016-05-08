function [ lon ] = getLon( rawLon, direction )
    rawLon = char(rawLon);
    direction = char(direction);

    degree = str2num(rawLon(1:3));
    min = str2num(rawLon(4:end));

    lon = degree + (min / 60);
    if direction == 'W'
        lon = lon * -1;
    end
end
