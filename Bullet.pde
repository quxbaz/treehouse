/**
 * Bullet -- Bullet.pde
 */


class Bullet extends Ent {

  IntervalTimer flash_timer;
  int damage = 1;  // how much damage this bullet inflicts
  Ent attached = null;
  Ent last_attached = null;
  Boolean was_attached = false;
  float dx = 0;
  float dy = 0;
  Ent follow;

  Bullet(float angle) {
    super(0, 0);
    is_bounded = true;
    name = "Bullet";
    layer = "bullets";
    collides = true;
    w = 4 + (int)random(10);
    h = 4 + (int)random(10);
    vel.set(320, 0);
    set_angle(angle);
    flash_timer = new IntervalTimer(g_timer, 80);
    // comps.put("WallBounceComp", new WallBounceComp(this));
    m_color = #ff0000;
    follow = get_random_unit();
  }

  Ent get_random_unit() {
    int len = colliders_units.size();
    Ent ent = null;
    for (;;) {
      ent = ((Ent)colliders_units.get((int)random(len)));
      if (ent == hero) {
        if (len == 1) {
          return null;
        }
      } else {
        return ent;
      }
    }
    // return ent;
    // if (follow == hero && len > 1) {
      // while (ent != hero) {
        // ent = ((Ent)colliders_units.get((int)random(len)));
      // }
    // } else if (len <= 1) {
      // ent = null;
    // }
    // return ent;
  }

  void on_collide_with(Ent ent) {
    // if (is_enemy != ent.is_enemy) kill();
    if (attached == null) attach(ent);
  }

  void attach(Ent ent) {
    if (ent != last_attached) {
      attached = ent;
      was_attached = true;
      collides = false;
      dx = ent.pos.x - pos.x;
      dy = ent.pos.y - pos.y;
    }
  }

  void move(float dts) {
    if (attached != null) {
      pos.x = attached.pos.x - dx;
      pos.y = attached.pos.y - dy;
    } else {
      super.move(dts);
    }
  }

  void detonate() {
    if (attached != null) {
      ((Unit)attached).damage(1);
      for (int i=0; i < 4; i++) {
        Particle p = new Particle(2);
        p.w = 4 + (int)random(11);
        p.h = 4 + (int)random(11);
        p.m_color = #ffffff;
        p.pos.set(pos);
        p.vel.set(rand_vect(random(200, 800)));
        pushent(p);

        if (i < 1) {
          Bullet b = new Bullet(rand_ang());
          b.is_enemy = is_enemy;
          b.pos.set(pos);
          b.vel.set(rand_vect(random(200, 800)));
          b.last_attached = attached;
          pushent(b);
        }
      }
    }
    kill();
  }

  void kill() {
    super.kill();
    destroy();
  }

  void render() {
    noStroke();
    if (flash_timer.update() > 0) {
      // m_color = m_color == #ffffff ? #ff0000 : #ffffff;
    }
    fill(m_color);
    rect(pos.x, pos.y, w, h);
    follow = null;
    if (follow != null) {
      AVector diff = new AVector(PVector.sub(follow.pos, pos));
      vel.set(diff);
      set_speed(400);
    }
  }

  void update() {
    super.update();
    // the unit this bullet was attached to died
    if ((attached == null || !attached.alive || !attached.exists) && was_attached) detonate();
    if (follow == null || !follow.alive || !follow.exists) follow = get_random_unit();
  }

}
