adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

local check = getColor(382, 238);
alert(string.format("The color at that position is %d", check));
