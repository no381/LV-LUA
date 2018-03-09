CREATETIME="2017-09-10 05:45:40";

adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

-- [Basic Functions]
banner1 = (430);
banner2 = (258);
banner3 = (86);

-- Set Initial Banner to Use
currentBanner = banner1;
monthlyBanner = banner1;
useBanner = currentBanner;
scroll = false;
goldenHourOnly = false;
monthlyBossOnly = false;
ghHour1 = 7;
ghHour2 = 21;
DST = false;

bosscount = 0;
deathcount = 0;

bannerSwitch = false;
goldenHour = false;
monthlyBossTime = false;

-- [Import from Other Code]
function everydayBoss()
	dofile(rootDir() .. "maps/EnchantedDominion-CastlePillars-eggs.lua");
end

-- [Import Montly Boss Pattern]
function monthlyBoss()
	dofile(rootDir() .. "maps/monthy-boss-coliseum-eggs.lua");
end

-- Return Current Time as Number
function getTime()
	timeHour = tonumber(os.date("%H", os.time()));
	timeMinute = tonumber(os.date("%M", os.time()));
end

function DSTadjust()
	if DST == true then
		ghHour1 = ghHour1 + 1;
		ghHour1 = ghHour1 + 1;
	end
end

-- Tap Spot
function tap(x, y)
	touchDown(0, x, y);
	usleep(16000);
	touchUp(0, x, y);
	usleep(500000);
end

-- Wait for color at spot
function waitCheckColor(x, y, color)
	local result = getColor(x, y);
	repeat
		usleep(500000);
		result = getColor(x, y);
	until (result == color);
	usleep(math.random(16000,500000))
end

-- Wait for Certain Time

function waitCheckTime(x, y)
	getTime();
	if timeHour ~= x and timeHour ~= y then
		repeat
			getTime();
			usleep(1000000);
		until timeHour == x or timeHour == y
	end
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

-- -- [Golden Hour Check]

function goldenHourCheck()
	getTime();
	if timeHour == ghHour1 or timeHour == ghHour2 then
		goldenHour = true; -- It's that magic twice of day time!
		if timeMinute >= 0 and timeMinute <= 29 then
			useBanner = monthlyBanner; -- Set the banner for GoToBossQuest
			monthlyBossTime = true; -- Yes, it's the first 30 minutes of GH
		elseif timeMinute >= 30 and timeMinute <= 59 then
			useBanner = currentBanner; -- Set the banner for GoToBossQuest
			monthlyBossTime = false; -- It's not the first half hour anymore
    end
	elseif timeHour ~= ghHour1 and timeHour ~= ghHour2 then
		goldenHour = false;
		monthlyBossTime = false; -- It's not the right hour.
	end
end

-- log("- Begin fighting Monthly Boss -");
-- log("- Resume Fighting Non-Montly Boss -");

function scrollBannerPageCheck()
	getTime();
	if timeHour == ghHour1 or timeHour == ghHour2 then
		if timeMinute >= 0 and timeMinute <= 29
		and scroll == true and bannerSwitch == false then
			-- if scroll param is set to true, scroll page
			dofile(rootDir() .. "stock/scrollReset.lua");
			log("- Set Screen to Banners 1 through 3 -");
			usleep(math.random(500000,1000000));
			bannerSwitch = true; -- Yes, the screen moved.
		elseif timeMinute >= 30 and timeMinute <= 59
		and scroll == true and bannerSwitch == true then
			-- if scroll param is set to true, scroll page
			dofile(rootDir() .. "stock/scrollBanner.lua");
			log("- Set Screen to Banners 4 through 6 -");
			usleep(math.random(500000,1000000));
			bannerSwitch = false; -- The screen is back to the position
		end
	elseif timeHour ~= ghHour1 and timeHour ~= ghHour2 then
		goldenHour = false;
		monthlyBossTime = false; -- It's not the right hour.
	end
end



-- -- [Find Boss Banner]
function GoToBossQuest()
	waitCheckColor(470, 1030, 16772608); -- Confirm presence of Event button
	tap(470, 1030); -- Tap Event
	waitCheckColor(445, 92, 533072); -- Confirm page is loaded via blue BG
	-- Check current for if it's Golden Hour and set banner usage
	scrollBannerPageCheck();
	-- Check if page need scrolled
	tap(useBanner, 568); -- hit relevant banner
end

-- -- [Start Quest]
function beginQuest()
	waitCheckColor(231, 644, 11998253); -- check for start quest button loaded
	tap(225, 770); -- hit Start Quest
	waitCheckColor(46, 510, 11998253); -- check for deck confirm button
	tap(35, 550); -- confirm deck
	tap(35, 550); -- confirm partner medal
end

-- -- [End Quest]
function endQuest()
	waitCheckColor(486, 227, 14913807); -- check for orange of RESULTS screen
	usleep(math.random(100000,700000));
	tap (68, 570); -- tap center of page
	waitCheckColor(96, 540, 6829587);
	tap (68, 570); -- tap screen for Rewards
	usleep(math.random(1000000,2000000));
	swipeDown(); -- speed up Rewards
	waitCheckColor(68, 520, 11998253); -- check for red OK button
	tap (68, 570); -- tap red button
end

-- -- [Boss Quest Action]
-- -- -- [Contains everydayBoss and endQuest]

function bossQuestAction();
	waitCheckColor(29, 1059, 6815743); -- Check to see if quest started
	-- This uses the attack triangle to verify.
	if monthlyBossTime == true then
		-- If it's those first 30 minutes, use this quest code
		monthlyBoss();
	end
	if monthlyBossTime == false then
		-- Doesn't matter if its GH if the boss runs all day.
		everydayBoss();
	end
		endQuest(); -- Check if the quest has ended
	-- [ CHECK FOR SUMMON ]
	local check = getColor(382, 238);
	local success = 16752201; -- ENCOUNTER text
	local fail = 16777215; -- pure white?
	if (check ~= success) and (check ~= fail) then
		-- If you don't see either color
		repeat
			usleep(500000);
			check = getColor(382, 238);
			-- keep checking
		until (check == success or check == fail);
	end
	if (check == fail) then -- No boss? repeat.
		repeat
			beginQuest();
			waitCheckColor(29, 1059, 6815743); -- check for strength triangle
			everydayBoss();
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
	waitCheckColor(382, 238, success); -- check for encounter
	usleep(math.random(500000,1000000));
	tap (68, 570);
	usleep(math.random(16000,500000))
	tap (68, 570); -- tap screen to continue
end

-- -- [Depreciated Code]
-- -- -- [startBoss was for hitting Auto]
function startBoss()
	waitCheckColor(29, 1059, 6815743); -- check for strength triangle
	tap(37, 325);
end

-- -- [End Boss]
function endBoss()
	-- Screen will say CLEAR at top
	tap (68, 570);
	usleep(16000);
	tap (68, 570);
	waitCheckColor(486, 227, 14913807); -- check for orange of results screen
	usleep(500000);
	tap (68, 570);
	waitCheckColor(486, 227, 14913807); -- waiting for the dang lux count
	tap (68 ,570);
	usleep(math.random(16000,500000))
	tap (68, 570);
	bosscount = bosscount + 1;
	log(string.format("Dead Boss Total:%d", bosscount));
	waitCheckColor(55, 510, 11998253); -- check for red button
	usleep(math.random(500000,1500000));
	tap(68, 570); -- confirm the boss contribution results
end

-- [Check if Boss is Dead]
function deadBossCheck()
	local check = getColor(382, 238);
	local success = 16755277; -- SUCCESS splash screen color
	local defeated = 4662623; -- DEFEATED text on results screen
	if (check ~= defeated and check ~= success) then
		-- keep checking til color matches one of the options
		repeat
			usleep(1000000);
			check = getColor(382, 238);
		until (check == defeated or check == success);
	end
	if (check == defeated) then
		repeat -- until you see the success text
			deathcount = deathcount + 1;
			log(string.format("whoops, I died lol. Death Count: %d", deathcount));
			usleep(math.random(64000, 500000)); -- wait a little
			tap (68, 570); -- tap to make the lux finish faster
			waitCheckColor(134, 536, 3414853); -- check for "until next level"
			usleep(32000);
			tap (68, 570);
			beginQuest(); -- checks if the quest page loads and starts again
			--startBoss();
			if (check ~= defeated or check ~= success) then
				repeat
					usleep(1000000);
					check = getColor(382, 238);
				until (check == defeated or check == success);
			end
		until (check == success);
		-- keep doing this
	end
	if (check == success) then
		-- if you see the SUCCESS text....
		endBoss(); -- finish the boss with all its results screens
	else
	end
end


function Action()
	goldenHourCheck();
	GoToBossQuest();
	beginQuest();
	bossQuestAction();
	beginQuest();
	deadBossCheck();
	getTime();
end

-- [OK ACTUALLY RUN SHIT]
log("---- Start new round ----");

if goldenHourOnly == true then
	waitCheckTime(ghHour1, ghHour2);
	while timeHour == ghHour1 or timeHour == ghHour2 do
		Action();
		goldenHourCheck();
	end
elseif monthlyBossOnly == true then
	repeat
		goldenHourCheck();
		usleep(1000000);
	until monthlyBossTime == true
	while monthlyBossTime == true do
		Action();
		goldenHourCheck();
	end
else
	while true do
		Action();
	end
end
