/**
 * math -- math.pde
 *
 * A bunch of useful math functions.
 */


// CONSTANTS

// caching some commonly used values
final float PI2 = PI * 2;
final float PI3_2 = PI * 1.5;
final float PI_2 = PI / 2;
final float PI_4 = PI / 4;
final float PI_8 = PI / 8;
final float PI_16 = PI / 16;
final float PI_32 = PI / 32;
final float PI_64 = PI / 64;
final float PI_128 = PI / 128;

// Converts an angle to vector.
AVector ang_to_vect(float ang, float mag) {
  AVector vect = new AVector(cos(ang), sin(ang));
  vect.x *= mag;
  vect.y *= mag;
  return vect;
}

AVector ang_to_vect(float ang) {
  return ang_to_vect(ang, 1);
}

float vect_to_ang(AVector vect) {
  float angle = 42;
  if (vect.x != 0 && vect.y != 0) {
    angle = atan(abs(vect.y) / abs(vect.x));
    if (vect.x < 0 && vect.y > 0) angle = PI - angle;
    else if (vect.x < 0 && vect.y < 0) angle += PI;
    else if (vect.x > 0 && vect.y < 0) angle = PI2 - angle;
  }
  // Handle divide by 0 errors.
  else if (vect.x > 0 && vect.y == 0) angle = 0;
  else if (vect.x == 0 && vect.y > 0) angle = PI_2;
  else if (vect.x < 0 && vect.y == 0) angle = PI;
  else if (vect.x == 0 && vect.y < 0) angle = PI3_2;
  else {
    // println("WARNING: Vector magnitude is 0");
  }
  return angle;
}

// Gets a random angle from 0 - 2pi
float rand_ang() {
  return random(PI2);
}

// Returns a random vector.
AVector rand_vect(float mag) {
  return ang_to_vect(rand_ang(), mag);
}

AVector rand_vect() {
  return rand_vect(1);
}

