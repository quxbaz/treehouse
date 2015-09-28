/**
 * Example of a program using the Treehouse framework.
 */


MyTreehouse th = null;
Hero hero = null;

class MyTreehouse extends Treehouse {

  IntervalTimer spawn_timer;

  void setup() {
    // misc
    spawn_timer = new IntervalTimer(timer, 6000);

    // layers setup
    man.add("base");
    man.add("units");
    man.add("hero");
    man.add("bullets");
    man.add("sfx");

    SCREEN_WIDTH = 720;
    SCREEN_HEIGHT = 480;

    // ents
    hero = new Hero(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);

    // adding
    pushent(hero);
    for (int i=0; i < 6; i++) {
      Robot r = new Robot();
      r.pos.set(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
      pushent(r);
    }
  }

  void add_ent(Ent ent) {
    String layer = ent.layer;
    if (layer == "units") {
      man.get("units").add(ent);
    } else if(layer == "hero") {
      man.get("hero").add(ent);
    } else if(layer == "bullets") {
      man.get("bullets").add(ent);
    } else if(layer == "sfx") {
      man.get("sfx").add(ent);
    } else {
      man.get("base").add(ent);
    }
  }

  void update() {
    super.update();
    int spawn_i = spawn_timer.update();
    for (int i=0; i < spawn_i; i++) {
      Robot r = new Robot();
      r.pos.set(random(SCREEN_WIDTH), random(SCREEN_HEIGHT));
      pushent(r);
    }
  }

}

// show the hero's life points left
void showlife() {
  int offset = 8;
  int box_len = 16;
  int spacing = 3;
  if (hero != null) {
    for (int i=0; i < hero.life; i++) {
      noStroke();
      fill(#ff0000);
      rect(offset + (i * box_len) + (i * spacing), offset, box_len, box_len);
    }
  }
}

void keyPressed() {
  if (!hero.alive || !hero.exists) return;
  switch (key) {
    case 'w': hero.set_dir(DIR_UP); break;
    case 'a': hero.set_dir(DIR_LEFT); break;
    case 's': hero.set_dir(DIR_DOWN); break;
    case 'd': hero.set_dir(DIR_RIGHT); break;
    case 'i': hero.shoot(PI3_2); break;
    case 'j': hero.shoot(PI); break;
    case 'k': hero.shoot(PI_2); break;
    case 'l': hero.shoot(0); break;
    case 'n': hero.kill(); break;
    case 'o': detonate(); break;
    case ' ': detonate(); break;
  }
}

void detonate() {
  int len = colliders_hero_bullets.size();
  for (int i=0; i < len; i++) {
    Bullet b = (Bullet)colliders_hero_bullets.get(i);
    if (b.attached != null) {
      b.detonate();
    }
  }
}

void keyReleased() {
  if (!hero.alive || !hero.exists) return;
  switch (key) {
    case 'w': hero.noset_dir(DIR_UP); break;
    case 'a': hero.noset_dir(DIR_LEFT); break;
    case 's': hero.noset_dir(DIR_DOWN); break;
    case 'd': hero.noset_dir(DIR_RIGHT); break;
  }
}


void setup() {
  th = new MyTreehouse();
}


// The game loop. It really ought be be called game_loop() instead of draw()
// because we do much more than just draw to a screen in this function.
void draw() {
  if (th != null) {
    th.loop();
    showlife();
  }
}
