/**
 * EntityStore -- EntStore.pde
 *
 * Recycles entities.
 */


class EntStore {

  ArrayList ents;

  EntStore() {
    ents = new ArrayList();
  }

  // Get a defunct stored entity or return null if none are available.
  Ent get(String class_name) {
    int len = ents.size();
    for (int i=0; i < len; i++) {
      Ent ent = ((Ent)ents.get(i));
      if (ent.name == class_name && !ent.exists) {
        return ent;
      }
    }
    return null;
  }

  // Add an entity to the store. You should always do this unless you are
  // dealing with very simple objects (like particles).
  Ent add(Ent ent) {
    ents.add(ent);
    return ent;
  }

}
