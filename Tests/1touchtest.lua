CREATETIME="2017-09-10 05:45:40";

adaptResolution(640, 1136);
adaptOrientation(ORIENTATION_TYPE.PORTRAIT);

function moveTouchY(x,y,z)
  touchDown(1, x, y);
  usleep(100000);
  for i = 0, 1000, z do
    y = y + z;
    touchMove(1, x, y);
    usleep(8000);
  end
  touchUp(1, x, y);
  usleep(100000);
end

moveTouchY(320, 20, 25);
