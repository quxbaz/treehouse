/**
 * Treehouse -- Treehouse.pde
 *
 * Treehouse framework. Subclass this to implement your own game logic.
 *
 * methods to subclass:
 *   setup()
 *   update()
 */


int SCREEN_WIDTH = 400;
int SCREEN_HEIGHT = 400;
Timer g_timer = new Timer();  // game timer
EntStore g_store = new EntStore();  // entity recycler
int g_step = 10;  // How often we want to update the game world (milliseconds).
Stack ent_buffer = new Stack();  // ent are pushed onto this before being added to the screen.
ArrayList colliders_units = new ArrayList();  // units that can collide.
ArrayList colliders_hero_bullets = new ArrayList();  // bullets from the hero.
ArrayList colliders_robot_bullets = new ArrayList();  // bullets from enemies.

void pushent(Ent ent) {
  ent_buffer.push(ent);
  if (ent.collides) {
    if (ent instanceof Bullet) {
      if (((Bullet)ent).is_enemy) {
        colliders_robot_bullets.add(ent);
      }
      else {
        colliders_hero_bullets.add(ent);
      }
    } else {
      colliders_units.add(ent);
    }
  }
}

void remove_dead_ents(ArrayList arr) {
  int len = arr.size();
  for (int i=len-1; i >= 0; i--) {
    Ent ent = (Ent)arr.get(i);
    if (!ent.alive || !ent.exists) {
      arr.remove(ent);
    }
  }
}

class Treehouse {

  // semi-constants
  int update_step = g_step;  // How often we want to update the game world (milliseconds).

  // globals
  boolean init = false;  // If the game has finished initializing
  Timer timer = null;  // Game timer
  FRTimer frtimer = null;  // Framerate timer
  IntervalTimer inttimer = null;  // Framerate timer
  LayerMan man = null;

  Treehouse() {
    // init
    man = new LayerMan();
    man.add("base");
    timer = g_timer;
    frtimer = new FRTimer(timer);
    inttimer = new IntervalTimer(timer, update_step);

    setup();

    // begin
    size(SCREEN_WIDTH, SCREEN_HEIGHT);
    timer.start(millis());
    init = true;
  }

  // Subclass this.
  void setup() {
    ellipseMode(CORNER);
  }

  // Utility actions such as updating the game timer.
  void util() {
    timer.update(millis());
    frtimer.update();
    process_ent_buffer();
  }

  void process_ent_buffer() {
    int len = ent_buffer.size();
    for (int i=0; i < len; i++) {
      Ent ent = (Ent)ent_buffer.pop();
      if (ent != null) {
        add_ent(ent);
      }
    }
  }

  // You should override this in order to manage your own layers.
  void add_ent(Ent ent) {
    man.get("base").add(ent);
  }

  void collide() {
    remove_dead_ents(colliders_units);
    remove_dead_ents(colliders_hero_bullets);
    remove_dead_ents(colliders_robot_bullets);
    collide_enemies_with_bullets();
    collide_hero_with_enemies();
  }

  void collide_hero_with_enemies() {
    int n_enemies = colliders_units.size();
    for (int i=0; i < n_enemies; i++) {
      Ent enemy = (Ent)colliders_units.get(i);
      if (hero != enemy) {
        if (hero.collides(enemy)) {
          hero.on_collide_with(enemy);
          enemy.on_collide_with(hero);
        }
        if (i < n_enemies-1) {
          Ent next = (Ent)colliders_units.get(i+1);
          stroke(0x40ffffff);
          strokeWeight(1);
          line(enemy.mid_x(), enemy.mid_y(), next.mid_x(), next.mid_y());
        }
      }
    }
  }

  void collide_enemies_with_bullets() {
    int n_enemies = colliders_units.size();
    for (int i=0; i < n_enemies; i++) {
      Ent enemy = (Ent)colliders_units.get(i);
      if (enemy.is_enemy) {
        int n_bullets = colliders_hero_bullets.size();
        for (int n=0; n < n_bullets; n++) {
          Bullet bullet = (Bullet)colliders_hero_bullets.get(n);
          if (enemy.collides(bullet)) {
            enemy.on_collide_with(bullet);
            bullet.on_collide_with(enemy);
            // enemy.kill();
            // bullet.destroy();
          }
        }
      }
    }
  }

  void handle_input() {}

  // Updates the game world. Subclass this.
  void update() {
    collide();
    man.update();
  }

  // Renders the graphics.
  void render() {
    background(#ff8000);
    man.render();
    collide();
  }

  // The game loop -- should be called every frame.
  void loop() {
    if (init) {
      util();
      handle_input();
      // Only update the game world every n seconds.
      int update_n = inttimer.update();
      for (int i=0; i < update_n; i++) {
        update();
      }
      render();
    }
  }

}
