/**
 * LayerManager - LayerMan.pde
 *
 * Stores layers and allows you to get layers by key.
 */
 

class LayerMan {
  
  ArrayList<Layer> layers;
 
  LayerMan() {
    layers = new ArrayList();
  }

  // Update layers.
  void update() {
    int len = layers.size();
    for (int i=0; i < len; i++) {
      ((Layer)layers.get(i)).do_update();
    }
  }
  
  // Render layers.
  void render() {
    int len = layers.size();
    for (int i=0; i < len; i++) {
      ((Layer)layers.get(i)).do_render();
    }
  }

  void add(String key) {
    layers.add(new Layer(key));
  }

  void add(Layer layer, String key) {
    layers.add(layer);
  }

  // Get a layer by key. If you want to add an entitiy to a layer, you'd do
  // this:
  //   layer_man.get('missiles').add(my_ent);
  Layer get(String key) {
    int len = layers.size();
    for (int i=0; i < len; i++) {
      Layer layer = (Layer)layers.get(i);
      if (key == layer.key) return layer;
    }
    return null;
  }
  
}
