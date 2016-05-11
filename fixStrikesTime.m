function [ fixedStrikes ] = fixStrikesTime( rawStrikes )
    [rows , cols] = size(rawStrikes);
    for i = 1:rows
        strikeTime = datevec(rawStrikes{i});
        if (strikeTime(4) < 10)
            hh = strcat('0', num2str(strikeTime(4)));
        else
            hh = num2str(strikeTime(4));
        end
        if (strikeTime(5) < 10)
            mm = strcat('0', num2str(strikeTime(5)));
        else
            mm = num2str(strikeTime(5));
        end
        if (strikeTime(6) < 10)
            ss = strcat('0', num2str(strikeTime(6)));
        else
            ss = num2str(strikeTime(6));
        end
        fixedStrikes{i} = [hh ':' mm ':' ss];
    end
    fixedStrikes = fixedStrikes';
end

