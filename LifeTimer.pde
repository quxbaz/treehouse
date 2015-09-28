/**
 * LifeTimer -- LifeTimer.pde
 *
 * Used to measures how long an ent has to live.
 */

class LifeTimer {

  Timer timer;
  int elapsed;
  int duration;
  boolean expired;

  LifeTimer(Timer timer_, float duration_) {
    timer = timer_;
    elapsed = 0;
    duration = (int)duration_ * 1000;
    expired = false;
  }

  void update() {
    elapsed += timer.dt;
    expired = elapsed >= duration;
  }

  void reset(float duration_) {
    elapsed = 0;
    duration = (int)duration_ * 1000;
    expired = false;
  }

}
