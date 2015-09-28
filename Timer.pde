/**
 * Timer -- Timer.pde
 *
 * Measure time between any interval; between frames for example.
 */


class Timer {

  int elapsed;  // The time passed since starting this timer in milliseconds.
  int dt;  // The time elapsed since the previous update.
  float dts;  // dt converted to seconds

  Timer() {
    elapsed = 0;
    dt = 0;
    dts = 0;
  }

  void start(int time) {
    elapsed = time;
  }

  // Updates timer info and returns dt.
  int update(int time) {
    dt = time - elapsed;
    elapsed = time;
    dts = ((float)dt) / 1000.0;
    return dt;
  }

}
