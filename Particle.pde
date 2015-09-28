/**
 * Particle -- Particle.pde
 *
 * A particle object created by an emitter.
 *
 * TODO:
 * Add visual components to this class. e.g., ExpandComp, FlashComp, etc.
 */


// class Particle extends Ent {
class Particle extends Ent {

  LifeTimer lifetimer;

  Particle(float lifetime) {
    is_bounded =  true;
    name = "Particle";
    layer = "sfx";
    lifetimer = new LifeTimer(g_timer, lifetime);
    m_color = #ffffff;
  }

  void update() {
    add_angle(PI_16 * g_timer.dts);
    lifetimer.update();
    if (lifetimer.expired) {
      destroy();
    } else {
      super.update();
    }
  }

  void render() {
    noStroke();
    fill(m_color);
    rect(pos.x, pos.y, w, h);
  }

  void reset(float lifetime) {
    super.reset();
    lifetimer.reset(lifetime);
  }

}
