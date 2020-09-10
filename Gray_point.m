function [x,y] = Gray_point(grayImg)
M = median(grayImg);
[globaMinIndexes,y] = find(grayImg == M);
x = median(globaMinIndexes);
y = median(y);
end

