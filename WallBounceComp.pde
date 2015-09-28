/**
 * WallBounceComp -- WallBounceComp.pde
 *
 * Allows an entity to bounce off walls.
 */


class WallBounceComp extends EntComp {

  WallBounceComp(Ent ent_) {
    super(ent_);
    name = "WallBounceComp";
  }

  void update() {
    AVector pos = ent.pos;
    AVector vel = ent.vel;
    if ((pos.x <= 0 && vel.x < 0) || (pos.x + ent.w >= SCREEN_WIDTH)) {
      vel.x *= -1;
    }
    if ((pos.y <= 0 && vel.y < 0) || (pos.y + ent.w >= SCREEN_HEIGHT)) {
      vel.y *= -1;
    }
  }

}
