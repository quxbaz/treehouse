/**
 * FrameRateTimer -- FRTimer.pde
 *
 * Measures frame rate.
 */


class FRTimer {

  Timer timer;
  int elapsed;
  int frame;
  int elapsed_frames;
  int fps;

  FRTimer(Timer timer_) {
    timer = timer_;
    elapsed = 0;
    frame = 0;
    fps = 0;
  }

  // Returns the frames per second. Updates about once a second.
  int update() {
    frame++;
    elapsed_frames++;
    elapsed += timer.dt;
    if (elapsed >= 1000) {
      elapsed %= 1000;
      fps = frame;
      frame = 0;
    }
    return fps;
  }

}
