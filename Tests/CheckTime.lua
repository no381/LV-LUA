banner123 = true;

curhour = os.date("%H", os.time());
curminute = os.date("%M", os.time());
hour = 21;
minute = 45;


function checkTime()
  if hour == 7 or hour == 21 then
    if minute >= 0 and minute <= 29 and banner123 == false then
      -- dofile(rootDir() .. "stock/scrollReset.lua");
      log("- Set Screen to Banners 1 through 3 -");
      banner123 = true;
    end
    if minute >= 30 and minute <= 59 and banner123 == true then
      -- dofile(rootDir() .. "stock/scrollBanner.lua");
      log("- Set Screen to Banners 4 through 6 -");
      banner123 = false;
    end
  end
end

checkTime();
log(curhour);
log(curminute);
log(tostring(banner123));
