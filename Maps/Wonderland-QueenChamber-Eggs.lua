CREATETIME="2018-02-23 11:28:31";

adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

-- Wait for color at spot
function waitCheckColor(x, y, color)
	local result = getColor(x, y);
	repeat
		usleep(500000);
		result = getColor(x, y);
	until (result == color);
	usleep(math.random(16000,500000))
end

function betweenEggs()
	usleep(500000);
	battleCheck = getColor(498, 1084);
	if battleCheck == 16773149 then
		usleep(6000000);
	end
end

touchDown(6, 314.50, 894.61);
usleep(249722.88);
touchMove(6, 312.47, 901.70);
usleep(16583.62);
touchMove(6, 310.44, 901.70);
usleep(16779.54);
touchMove(6, 307.39, 901.70);
usleep(16693.08);
touchMove(6, 303.33, 901.70);
usleep(16565.04);
touchMove(6, 299.27, 900.67);
usleep(16755.00);
touchMove(6, 293.16, 898.65);
usleep(16702.62);
touchMove(6, 286.05, 894.61);
usleep(16566.25);
touchMove(6, 278.95, 889.53);
usleep(16666.54);
touchMove(6, 273.87, 885.49);
usleep(16718.12);
touchMove(6, 270.82, 883.46);
usleep(16479.67);
touchUp(6, 266.75, 879.41);
usleep(16479.67);

if
usleep(7517861.08);

touchDown(7, 85.91, 998.96);
usleep(400331.21);
touchMove(7, 82.85, 999.96);
usleep(32969.29);
touchMove(7, 82.85, 998.96);
usleep(16728.04);
touchMove(7, 82.85, 997.93);
usleep(16591.62);
touchMove(7, 82.85, 996.93);
usleep(16637.79);
touchMove(7, 82.85, 995.91);
usleep(16649.17);
touchMove(7, 82.85, 994.90);
usleep(233098.92);
touchMove(7, 82.85, 993.90);
usleep(16758.12);
touchUp(7, 87.94, 985.78);
usleep(1583599.62);

touchDown(9, 278.95, 233.02);
usleep(183425.29);
touchUp(9, 278.95, 233.02);
usleep(7217425.92);

touchDown(2, 463.86, 903.72);
usleep(316462.67);
touchUp(2, 463.86, 903.72);
