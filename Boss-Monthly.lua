CREATETIME="2017-09-10 05:45:40";

adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

-- [Basic Functions]

bosscount = 0;
deathcount = 0;

banner1 = (430);
banner2 = (258);
banner3 = (86);
debugcycleCount = 0;
currentBanner = banner1;
currentTime = ((os.date("%H")*60*60)+(os.date("%M")*60)+(os.date("%S")));

--if (currentTime >= 79200 and currentTime <= 81000) or (currentTime >= 28800 and currentTime <= 36000) then
--  currentBanner = banner3;
--end

-- [Import from Other Code]
function luaImport()
	dofile(rootDir() .. "maps/monthy-boss-coliseum-eggs.lua");
end

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
	usleep(math.random(300000,1500000))
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


	waitcheck(470, 1030, 16772608);
	tap(470, 1030);
	waitcheck(445, 92, 533072);
	tap(currentBanner, 568);
end

-- -- [Start Quest]
function beginQuest()
	waitcheck(231, 644, 11998253);
	tap(225, 770);
	waitcheck(46, 510, 11998253);
	tap(35, 550);
	tap(35, 550);
end

-- -- [End Quest]
function endQuest()
	waitcheck(486, 227, 14913807); -- screen orange
	usleep(math.random(500000,2000000));
	tap (68, 570);
	usleep(math.random(500000,2000000));
	tap (68, 570); -- tap screen for Rewards
	usleep(math.random(1000000,2000000));
	swipeDown(); -- speed up Rewards
	waitcheck(486, 227, 14913807); -- check for red button
	usleep(math.random(500000,2000000));
	tap (68 ,570); -- tap red button
end

-- -- [Boss Quest Action]

function bossQuestAction();
	waitcheck(29, 1059, 6815743);
	-- other shit
	luaImport(); -- bring code from self run
	-- Check if the quest has ended
	endQuest();
	-- [ CHECK FOR SUMMON ]
	local check = getColor(382, 238);
	local success = 16752201;
	local fail = 16777215;
	if (check ~= success) and (check ~= fail) then
		repeat
			usleep(1000000);
			check = getColor(382, 238);
		until (check == success or check == fail);
	end
	if (check == fail) then
		repeat
			beginQuest();
			waitcheck(29, 1059, 6815743);
			luaImport();
			endQuest();
			usleep(math.random(1000000, 2000000));
			check = getColor(382, 238);
			if (check ~= success) and (check ~= fail) then
				repeat
					usleep(1000000);
					check = getColor(382, 238);
				until (check == success or check == fail);
			end
		until (check == success);
	end
	waitcheck(382, 238, success); -- check for encounter
	usleep(math.random(500000,2000000));
	tap (68, 570);
	usleep(math.random(16000,500000))
	tap (68, 570); -- tap screen to continue
end

-- -- [Fight Boss Loop]
function startBoss()
	waitcheck(29, 1059, 6815743);
	tap(37, 325);
end

-- -- [End Boss]
function endBoss()
	--alert(string.format("Boss is dead %d", check));
	tap (68, 570);
	usleep(16000);
	tap (68, 570);
	waitcheck(486, 227, 14913807);
	usleep(2000000);
	tap (68, 570);
	waitcheck(486, 227, 14913807);
	tap (68 ,570);
	usleep(math.random(16000,500000))
	tap (68, 570);
	bosscount = bosscount + 1;
	log(string.format("Dead Boss Total:%d", bosscount));
	waitcheck(55, 510, 11998253);
	usleep(math.random(500000,1500000));
	tap(68, 570);
end

-- [Check if Boss is Dead]
function deadBossCheck()
	local check = getColor(382, 238);
	local success = 16755277;
	local defeated = 4662623;
	if (check ~= defeated and check ~= success) then
		repeat
			usleep(1000000);
			check = getColor(382, 238);
		until (check == defeated or check == success);
	end
	if (check == defeated) then
		repeat
			deathcount = deathcount + 1;
			log(string.format("whoops, I died lol. Death Count: %d", deathcount));
			usleep(math.random(500000, 1000000));
			tap (68, 570);
			usleep(math.random(500000, 1000000));
			tap (68, 570);
			beginQuest();
			--startBoss();
			if (check ~= defeated or check ~= success) then
				repeat
					usleep(1000000);
					check = getColor(382, 238);
				until (check == defeated or check == success);
			end
		until (check == success);
	end
	if (check == success) then
		endBoss();
	else
	end
end

-- [OK ACTUALLY RUN SHIT]
log(string.format("---- Start new round ----", bosscount));
while true do
	GoToBossQuest();
	beginQuest();
	bossQuestAction();
	beginQuest();
	--startBoss();
	deadBossCheck();
	--endBoss();
end
