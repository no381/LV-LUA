# LV-LUA
This is a script written in LUA for use with AutoTouch (https://autotouch.net/), configured initially for use with an iPhone 5S in landscape (though the coordinates are written in portrait, don't know why AutoTouch had done that).

It is written such that the main script (usually some derivitive of Boss-______.lua) can be run, which will loop itself through the various select quest, reach target of number of cycles to summon a Boss, then fight boss until screen shows it as defeated. You can configure it using some of the starting variables within the text (scrolling, DST, only a certain period of day, what banner to hit) to better suit the current week or event's offering.

I'll expand this readme with usage directions and a summary of how it works shortly.

## How it works

## Things to Do
- Add Connection Check at certain points
  - (if there's a crappy wifi connection, you'll get a pop-up whining about it, gotta find a way to dismiss that)
- Configure for app crashes
  - Possibly add appRun() to reopen the game or something like that
  - There are two major pinch points when the app crashes: Starting a quest or starting a raid boss fight.
