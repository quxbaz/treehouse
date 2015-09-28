/**
 * Robot -- Robot.pde
 *
 * An enemy unit.
 */


class Robot extends Unit {

  IntervalTimer pulser;
  LifeTimer damage_timer;
  ArrayList attached_bullets;

  Robot() {
    super(0, 0);
    name = "Robot";
    collides = true;
    w = 16;
    h = 16;
    speed = 10 + random(28);
    pulser = new IntervalTimer(g_timer, 80);
    damage_timer = new LifeTimer(g_timer, 0);
    life = 5;
    attached_bullets = new ArrayList();
  }

  void render() {
    noStroke();
    if (!damage_timer.expired) fill(#ff0000);
    else fill(#ffffff);
    rect(pos.x, pos.y, w, h);
    damage_timer.update();
    if (pulser.update() > 0) {
      if (w == 24) {
        w = 16; h = 16;
        pos.x += 4; pos.y += 4;
      } else {
        w = 24; h = 24;
        pos.x -= 4; pos.y -= 4;
      }
    }
  }

  void on_collide_with(Ent ent) {
    if (ent instanceof Bullet) {
      Bullet b = (Bullet)ent;
      if (is_enemy != b.is_enemy) {
        // damage(b.damage);
        damage_timer.reset(0.3);
        // for (int i=0; i < 1; i++) {
          // Particle p = new Particle(2.0);
          // p.w = 2 + (int)random(12);
          // p.h = 2 + (int)random(12);
          // p.pos.set(mid_x(), mid_y());
          // p.vel.set(rand_vect(400 + random(200)));
          // pushent(p);
        // }
      }
    } else if (ent instanceof Hero) {
      kill();
    }
    
  }

  void on_damage(int dmg) {
    damage_timer.reset(0.3);
  }

  void kill() {
    super.kill();
    RobotDeathEmitter emitter = new RobotDeathEmitter();
    emitter.pos.set(mid_x(), mid_y());
    pushent(emitter);
    emitter.start();
    destroy();
  }

  void update() {
    super.update();
    AVector diff = new AVector(PVector.sub(hero.pos, pos));
    vel.set(diff);
    set_speed(speed);
  }

}
