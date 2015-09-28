/**
 * Unit -- Unit.pde
 *
 * An entity with hit points - can be damaged and killed.
 */


class Unit extends Ent {

  int life;

  Unit() {
    super();
    layer = "units";
    life = 1;
  }

  Unit(float x, float y) {
    super(x, y);
  }

  Unit(PVector pos_) {
    super(pos_);
  }

  void set_life(int life_) {
    life = max(life_, 0);
    if (life == 0) kill();
  }

  void add_life(int life_) {
    life = max(life + life_, 0);
    if (life == 0) kill();
  }

  void damage(int dmg) {
    life = max(life - dmg, 0);
    on_damage(dmg);
    if (life == 0) kill();
  }

  void on_damage(int dmg) {}

}
