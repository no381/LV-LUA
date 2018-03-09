# LV-LUA
This is a script written in LUA for use with AutoTouch (https://autotouch.net/), configured initially for use with an iPhone 5S in landscape (though the coordinates are written in portrait, don't know why AutoTouch had done that).

It is written such that the main script (usually some derivitive of Boss-______.lua) can be run, which will loop itself through the various select quest, reach target of number of cycles to summon a Boss, then fight boss until screen shows it as defeated. You can configure it using some of the starting variables within the text (scrolling, DST, only a certain period of day, what banner to hit) to better suit the current week or event's offering.

I'll expand this readme with usage directions and a summary of how it works shortly.

## How it works
AutoTouch always seems to detect my screen as portrait on my phone, so that's why the X,Y coordiates are a little strange. You may need to adjust that for your screen. AutoTouch tries to make this easier for you with the adaptResolution and adaptOrientation variables. This would be what would need adjusted the most. I've included a demonstration of how my screen fits to the current version of the script below.

![Image of Screen Size](https://raw.githubusercontent.com/no381/LV-LUA/master/screenshots/screensize.png)

I can't confirm if changing those will work for your device, but hey, this is free to you.

The script loops through these actions:
- goldenHourCheck(); - Checks to see if it's currently Golden Hour and what banners to use
-	GoToBossQuest(); - Goes into EVENTS, and selects the relevant banner
-	beginQuest(); - Starts the quest
-	bossQuestAction(); - Performs the actions within the quest, repeating until confirmation that a boss was summoned
-	beginQuest(); - Starts the Boss
-	deadBossCheck(); - Checks for "SUCCESS" or "DEFEATED" text, repeats fighting boss until "SUCCESS", then finishes out.
-	getTime(); - Just checks the current time to determine if it should loop again.

Snippets of code are loaded from the "Maps" or "Stock" directories, so that you don't have to keep them in the root of your AutoTouch Scripts folder. You may need to switch the linkage in the functions listed below if the map layout should change. I've provided a few past map pieces that worked for me, optional. 

## Variables/Functions You'll Want To Modify
| Function or Variable | Description |
| -------------------- | ----------- |
| **currentBanner** | defines the banner the screen will touch on the Events page |
| **monthlyBanner** | defines the banner the screen will touch for the monthly raid boss (this is usually slot 1 during most times) |
| **scroll** | Should the page be scrolled down? There are usually 3 banners displayed, so this allows you to access the 4th through 6th banners |
| **ghHour1 & ghHour2** | the times for the Golden Hour in your timezone. Currently set to CST in 24 Hour format. Also so you can modify them if this should ever change. |
| **goldenHourOnly** | Should this script only trigger during Golden Hour(s)? Set this to true. |
| **monthlyBossOnly** | Should this script only trigger duirng the 30 minutes of GH that are the acutal boss? Set this to true. |
| **DST** | Does your zone use DST? Set this to true to spring forward an hour without having to change ghHour1 or 2. | 
| **everydayBoss()** | The location of the script for actions the character should do during any quest that runs all day |
| **monthlyBoss()** | The location of the script for actions for the monthly boss. Usually the maps the same, you may not need to change this. |

## Things to Do (Possible Upcoming Features)
- Add Connection Check at certain points
  - (if there's a crappy wifi connection, you'll get a pop-up whining about it, gotta find a way to dismiss that)
- Configure for app crashes
  - Possibly add appRun() to reopen the game or something like that
  - There are two major pinch points when the app crashes: Starting a quest or starting a raid boss fight.
- Consider testing orientation fixes for my phone
