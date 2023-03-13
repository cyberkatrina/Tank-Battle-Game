class bullet {
  float x, y, angle, power;
  float dx, dy, ddx;
  float ddy = 5;
  int r_l;
  bullet(float _x, float _y, float _angle, float _power, int _r_l) {
    x = _x;
    y = _y;
    r_l = _r_l;
    angle = _angle;
    power = _power;

    dx = power*cos(radians(angle));
    dy = power*sin(radians(angle));
    if (r_l > 0) {
      x -=10;
      y+=10;
      dx *= -1;
    } else {
      y-=5;
    }
  }

  void move() {
    stroke(255);
    strokeWeight(10);
    point(x+68, y+59);
    dy += ddy;
    y += dy;
    x += dx;
    dy*=0.9;
    dx *=0.95;
  }
}
