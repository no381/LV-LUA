function connectionContinue(color)
  waitCheckColor(x, y, 0);
  local screen = getColor(x,y);
  while screen == 0
    usleep(32000);
    tap(x,y);
    usleep(16000);
    screen = getColor(x,y);
  until screen != 0;
end
