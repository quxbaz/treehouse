/**
 * AVector -- AVector.pde
 *
 * Just like PVector, except some methods have been overwritten to eliminate
 * unnecessary parameters.
 */

class AVector extends PVector {

  AVector() {
    super(0, 0);
  }

  AVector(AVector vect) {
    super(vect.x, vect.y);
  }

  AVector(PVector vect) {
    super(vect.x, vect.y);
  }

  AVector(float x, float y) {
    super(x, y);
  }

  void set(float x, float y) {
    super.set(x, y, 0);
  }

}
