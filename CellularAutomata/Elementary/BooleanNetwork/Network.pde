public class Network {
  private Node[] _nodes;
  private boolean[] _buffer,
                    _rules;
  
  public Network(int size, int connections) {
    
    _nodes = new Node[size];
    _buffer = new boolean[size];
    _rules = new boolean[(1<<connections)];
    
    for(int i=0;i<size;i++) {
      _nodes[i] = new Node(size, i, connections);
      _buffer[i] = _nodes[i].getState();
    }
    
    for(int i=0;i<_rules.length;i++) {
      _rules[i] = random(1)>.5;
    }
  }
  
  public boolean[] updateBuffer() {
    for(int i=0;i<_nodes.length;i++) {
      _nodes[i].setState(_buffer, _rules);
    }
    
    for(int i=0;i<_nodes.length;i++) {
      _buffer[i] = _nodes[i].getState();
    }
    
    return _buffer;
  }
  
  public boolean[] getBuffer() {
    return _buffer;
  }
}
