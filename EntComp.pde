/**
 * EntityComponent -- EntComp.pde
 *
 * Attaches to an Entity to provide some special functionality.
 */


// NOW
class EntComp {

  Ent ent;  // the ent this component is attached to.
  String name;  // the class name as a string.

  EntComp(Ent ent_) {
    ent = ent_;
    name = "EntComp";
  }

  void attach(Ent ent_) {
    ent = ent_;
  }

  void dettach() {
    ent = null;
  }

  void update() {}

}
