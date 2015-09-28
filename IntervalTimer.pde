/**
 * IntervalTimer -- IntervalTimer.pde
 *
 * Measures fixed intervals of time.
 */


class IntervalTimer {

  Timer timer;
  int interval;
  int elapsed;

  IntervalTimer(Timer timer_, int interval_) {
    timer = timer_;
    interval = interval_;
    elapsed = 0;
  }

  /**
   * This function should be called every frame. It checks whether or not a
   * fixed time interval has been exceeded. If yes, it returns the number of
   * intervals passed (usually just 1 unless the game is running really slow)
   * and resets the running timer.
   */
  int update() {
    elapsed += timer.dt;
    int interval_n = (int)elapsed / interval;
    elapsed %= interval;
    return interval_n;
  }

  void reset(int interval_) {
    interval = interval_;
    elapsed = 0;
  }

}

