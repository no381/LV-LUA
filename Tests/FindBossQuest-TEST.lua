CREATETIME="2017-09-10 05:45:40";

adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

-- Tap Spot
function tap(x, y)
	touchDown(0, x, y);
	usleep(16000);
	touchUp(0, x, y);
	usleep(16000);
end

-- Wait for color at spot
function waitcheck(x, y, color)
	local result = getColor(x, y);
	repeat
		usleep(1000000);
		result = getColor(x, y);
	until (result == color);
end

-- Find Banner
function findBanner()
	local currentBanner = "RaidBossScript/banner-sm.bmp";
	local banner1 = findImage(currentBanner, 0, 1, nil, {361, 248, 10, 10});
	local banner2 = findImage(currentBanner, 0, 1, nil, {189, 248, 10, 10});
	local banner3 = findImage(currentBanner, 0, 0.8, nil, {17, 248, 10, 10});

	for i,v in pairs(banner1) do
		-- first banner
		return 1;
	end

	for i,v in pairs(banner2) do
		-- second banner
		return 2;
	end

	for i,v in pairs(banner3) do
		return 3;
	end

	--------

	-- banner not found
	return 0;
end

-- -- [Find Boss Banner]
function findBossQuest()
	tap(470, 1030);
	waitcheck(445, 92, 533072);
	-- usleep(7000000);
	local Banner = findBanner();
	if Banner == 1 then
		tap(430, 568);
	elseif Banner == 2 then
		tap(258, 568);
	elseif Banner == 3 then
		tap(86, 568);
	end
end

-- -- [Start Quest]
function beginQuest()
	waitcheck(231, 644, 11998253);
	tap(225, 770);
	waitcheck(46, 510, 11998253);
	tap(35, 550);
	tap(35, 550);
end
-----

findBossQuest();
beginQuest();
