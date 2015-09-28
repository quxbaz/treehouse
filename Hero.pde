/**
 * Hero -- Hero.pde
 *
 * The playable character.
 */

final int DIR_NONE = -1;
final int DIR_UP = 0;
final int DIR_DOWN = 1;
final int DIR_LEFT = 2;
final int DIR_RIGHT = 3;

class Hero extends Unit { 

  float speed;
  AVector facing;  // The direction hero is facing.
  ShooterEntComp gun;

  // visuals
  // int colors[] = {#ff0000, #ffffff, #00ff00, #ffff00, #00ffff};
  // int colors[] = {#ff0000, #ffff00, #00ff00, #00ffff, #2888ff, #ffffff};
  // int colors[] = {#ff0000, #ffffff};
  // int colors[] = {#ff0000};
  int colors[] = {#ff0000, #ff0000};
  int colors_len = colors.length;
  int n_color = 0;
  IntervalTimer colors_timer;
  // trailing shadow
  int shadows_len = 18;
  AVector shadows[];  // trailing shadows
  int n_shadow = 0;
  IntervalTimer shadows_timer;;

  Hero(float x, float y) {
    super(x, y);
    name = "Hero";
    layer = "hero";
    collides = true;
    is_enemy = false;
    speed = 120;
    facing = new AVector(0, 0);
    gun = new ShooterEntComp(this);
    comps.put("gun", gun);
    w = 16;
    h = 16;
    // visuals
    colors_timer = new IntervalTimer(g_timer, 80);
    shadows_timer = new IntervalTimer(g_timer, 40);
    shadows = new AVector[shadows_len];
    for (int i=0; i < shadows_len; i++) {
      shadows[i] = new AVector(pos);
    }
    life = 10;
  }

  void set_dir(int dir) {
    switch (dir) {
      case DIR_NONE:
        vel.set(0, 0);
        facing.set(0, 0);
        break;
      case DIR_UP:
        vel.y = -speed;
        facing.set(0, -1);
        break;
      case DIR_DOWN:
        vel.y = speed;
        facing.set(0, 1);
        break;
      case DIR_LEFT:
        vel.x = -speed;
        facing.set(-1, 0);
        break;
      case DIR_RIGHT:
        vel.x = speed;
        facing.set(1, 0);
        break;
    }
  }

  void noset_dir(int dir) {
    switch (dir) {
      case DIR_NONE: vel.set(0, 0); break;
      case DIR_UP: vel.y = 0; break;
      case DIR_DOWN: vel.y = 0; break;
      case DIR_LEFT: vel.x = 0; break;
      case DIR_RIGHT: vel.x = 0; break;
    }
  }

  void shoot(float angle) {
    gun.shoot(angle);
  }

  void on_collide_with(Ent ent) {
    if (ent instanceof Robot) {
      damage(1);
    }
  }

  void kill() {
    super.kill();
    RobotDeathEmitter e;
    for (int i=0; i < 32; i++) {
      e = new RobotDeathEmitter();
      e.pos.set(mid_x() + random(-120, 120), mid_y() + random(-120, 120));
      e.start();
      pushent(e);
    }
    destroy();
  }


  void update() {
    super.update();
  }

  void render() {
    super.render();
    if (colors_timer.update() > 0) {
      n_color = (n_color + 1) % colors_len;
      if (n_color % 2 == 0) {
        w = 24; h = 24;
        pos.x -= 4; pos.y -= 4;
      } else {
        w = 16; h = 16;
        pos.x += 4; pos.y += 4;
      }
    }
    if (shadows_timer.update() > 0) {
      n_shadow = (n_shadow + 1) % shadows_len;
      shadows[n_shadow].set(pos);
    }
    // for (int i=0; i < shadows_len-1; i++) {
      // if (random(1) > 0.5) stroke(#ff0000);
      // else stroke(#ffffff);
      // stroke(#ff0000);
      // strokeWeight(1);
      // noFill();
      // line(shadows[i].x, shadows[i].y, shadows[i+1].x, shadows[i+1].y);
      // line(shadows[i].x+w, shadows[i].y, shadows[i+1].x+w, shadows[i+1].y);
      // line(shadows[i].x, shadows[i].y+h, shadows[i+1].x, shadows[i+1].y+h);
      // line(shadows[i].x+w, shadows[i].y+h, shadows[i+1].x+w, shadows[i+1].y+h);

      // shadows[i].x += random(-20, 20) * g_timer.dts;
      // shadows[i].y += random(-20, 20) * g_timer.dts;

      // fill(#ffcccc);
      // rect(shadows[i].x, shadows[i].y, w, h);
    // }
    noStroke();
    fill(colors[n_color]);
    rect(pos.x, pos.y, w, h);
  }

}
