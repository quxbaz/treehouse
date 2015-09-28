/**
 * Entity -- Ent.pde
 *
 * Pretty much anything that has position or moves will be derived from this
 * class.
 */


class Ent {

  AVector pos;
  int w;  // width
  int h;  // height
  float speed;  // pixels per sec
  AVector vel;
  AVector acc;  // acceleration
  boolean alive;  // 
  boolean exists;  //
  String name;  // the class name as a string.
  String layer;  // the layer this entity should belong to.
  HashMap comps;  // components
  Boolean is_bounded;  // if true, this entity will be destroyed on venturing outside the screen.
  Boolean collides; // must be true if the entity has some behavior defined for a collision event.
  boolean is_enemy;  // if this entity is an enemy. default true.
  int m_color = #ffffff;

  void init() {
    pos = new AVector(0, 0);
    w = 0;
    h = 0;
    speed = 0;
    vel = new AVector(0, 0);
    acc = new AVector(0, 0);
    alive = true;
    exists = true;
    name = "Ent";
    layer = "base";
    comps = new HashMap();
    is_bounded = false;
    collides = false;
    is_enemy = true;
  }
  
  Ent() {
    init();
  }

  Ent(float x, float y) {
    init();
    pos = new AVector(x, y);
  }

  Ent(PVector pos_) {
    init();
    pos = new AVector(pos_.x, pos_.y);
  }

  void move(float dts) {
    accel(dts);
    displace(dts);
  }

  void accel(float dts) {
    vel.x += acc.x * dts;
    vel.y += acc.y * dts;
  }

  void displace(float dts) {
    pos.x += vel.x * dts;
    pos.y += vel.y * dts;
  }

  float right() {
    return pos.x + w;
  }

  float bottom() {
    return pos.y + h;
  }

  float mid_x() {
    return pos.x + w / 2;
  }

  float mid_y() {
    return pos.y + h / 2;
  }

  float get_speed() {
    return vel.mag();
  }

  void set_speed(float speed) {
    float mag = vel.mag();
    vel.normalize();
    vel.x *= speed;
    vel.y *= speed;
  }

  void add_speed(float speed) {
    set_speed(get_speed() + speed);
  }

  // Gets the current angle in radians.
  float get_angle() {
    return vect_to_ang(vel);
  }

  // Changes the angle while maintaining the current magnitude.
  // angle is in radians
  void set_angle(float angle) {
    AVector vect = ang_to_vect(angle, vel.mag());
    vel.set(vect.x, vect.y);
  }

  // Adds a value to the current angle.
  // angle is in radians
  void add_angle(float angle) {
    set_angle(get_angle() + angle);
    // println(get_angle());
  }

  // Return trues if this entity collides with another entity.
  boolean collides(Ent ent) {
    return alive && exists && collides && ent.collides
      && this.right() > ent.pos.x && this.pos.x < ent.right()
      && this.bottom() > ent.pos.y && this.pos.y < ent.bottom();
  }

  // Executes when this ent collides with another ent.
  // Override this.
  void on_collide_with(Ent ent) {}

  void update_comps() {
    if (comps.containsKey("WallBounceComp")) {
      ((EntComp)comps.get("WallBounceComp")).update();
    }
  }
  
  void do_render() {
    if (exists) render();
  }

  // Never call this directly, call do_render() instead.
  void render() {}

  void do_update() {
    if (alive && exists) update();
  }

  // Never call this directly, call do_update() instead.
  void update() {
    move(g_step / 1000.0);
    update_comps();
    if (is_bounded && !comps.containsKey("WallBounceComp")) {
      if (pos.x + w < 0 || pos.y + h < 0 || pos.x > SCREEN_WIDTH || pos.y > SCREEN_HEIGHT) {
        destroy();
      }
    }
  }

  void kill() {
    alive = false;
  }

  void destroy() {
    alive = false;
    exists = false;
  }

  void reset() {
    pos.set(0, 0);
    vel.set(0, 0);
    acc.set(0, 0);
    alive = true;
    exists = true;
  }
  
}
