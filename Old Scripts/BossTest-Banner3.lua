CREATETIME="2017-09-10 05:45:40";

adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

-- [Basic Functions]

-- Tap Spot
function tap(x, y)
	touchDown(0, x, y);
	usleep(16000);
	touchUp(0, x, y);
	usleep(500000);
end

-- Wait for color at spot
function waitcheck(x, y, color)
	local result = getColor(x, y);
	repeat
		usleep(1000000);
		result = getColor(x, y);
	until (result == color);
end

-- Swipe Medal
function swipeMedal()
	touchDown(0, 170, 78);
	usleep(16000);
	touchMove(0, 281, 190);
	usleep(16000);
	touchUp(0, 281, 190);
end

-- Swipe Down for Rewards screen
function swipeDown()
	touchDown(0, 400, 237);
	usleep(16000);
	touchMove(0, 200, 237);
	usleep(16000);
	touchUp(0, 200, 237);
end

-- [Action Functions]

-- -- [Find Boss Banner]
function GoToBossQuest()
	local banner1 = (430);
	local banner2 = (258);
	local banner3 = (86);

	tap(470, 1030);
	waitcheck(445, 92, 533072);
	tap(banner1, 568);
end

-- -- [Start Quest]
function beginQuest()
	waitcheck(231, 644, 11998253);
	tap(225, 770);
	waitcheck(46, 510, 11998253);
	tap(35, 550);
	tap(35, 550);
end

-- -- [Boss Quest Action]

function bossQuestAction();
	waitcheck(52, 1072, 100597);
	-- other shit
end

-- -- [Fight Boss Loop]
function startBoss()
	waitcheck(52, 1072, 100597);
	tap(37, 325);
	waitcheck()
end

-- [Check if Boss is Dead]
function deadBossCheck()
	local check = getColor(382, 238);
	local success = 16755277;
	local defeated = 4662623;
	if check ~= defeated or check ~= success then
		repeat
			usleep(1000000);
			check = getColor(382, 238);
		until check == defeated or check == success;
	elseif check == defeated then
		repeat
			tap (68, 570);
			beginQuest();
			startBoss();
			if check ~= defeated or check ~= success then
				repeat
					usleep(1000000);
					check = getColor(382, 238);
				until (check == defeated) or (check == success);
			else
			end
		until (check == success);
	elseif check == success then
		tap (68, 570);
		waitcheck(486, 227, 14913807);
		tap (68, 570);
		swipeDown();
		waitcheck(486, 227, 14913807);
		tap (68 ,570);
	end
end

-- [OK ACTUALLY RUN SHIT]

while true do
	GoToBossQuest();
	beginQuest();
	--bossQuestAction();
	--startBoss();
	--deadBossCheck();
end
