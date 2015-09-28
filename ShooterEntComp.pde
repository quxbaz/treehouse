/**
 * ShooterEntComp -- ShooterEntComp.pde
 *
 * Component that allows an entity to shoot.
 */


// NOW
class ShooterEntComp extends EntComp {

  ShooterEntComp(Ent ent_) {
    super(ent_);
    name = "ShooterEntComp";
  }

  void shoot(float angle) {
    Bullet b = new Bullet(angle);
    b.pos.set(ent.mid_x(), ent.mid_y());
    b.pos.x -= b.w / 2;
    b.pos.y -= b.h / 2;
    b.add_angle(random(-0.1, 0.1));
    b.is_enemy = ent.is_enemy;
    pushent(b);
  }

}
