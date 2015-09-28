/**
 * RobotDeathEmitter -- RobotDeathEmitter.pde
 */


class RobotDeathEmitter extends Emitter {

  RobotDeathEmitter() {
    super(1.2, 0.3);
  }

  void emit() {
    Particle p;
    for (int i=0; i < 9; i++) {
      // p = new Particle(random(1, 2.2));
      // p = new Particle(2.0);
      p = new Particle(random(1.0, 3.0));
      // p.comps.put("WallBounceComp", new WallBounceComp(p));
      p.m_color = #ffffff;
      if (random(1) < 0.1) p.m_color = #ff0000;
      p.pos.set(pos);
      p.w = (int)random(1, 8);
      p.h = (int)random(1, 8);
      // p.vel.set(random(80, 800), 0);
      p.vel.set(rand_vect(random(80, 800)));
      // p.add_angle(i * PI_8);
      ents.add(p);
    }
  }

}
