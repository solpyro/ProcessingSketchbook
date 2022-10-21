public class Node {
  private boolean _val;
  private int[] _connections;
  
  public Node(int size, int self, int connections) {
    _val = random(1)>.5;
    _connections = new int[connections];
    
    for(int i=0;i<_connections.length;i++) {
      do {
        _connections[i] = round(random(_connections.length-1));
      } while(_connections[i] == self);
    }
  }
  
  public boolean getState() {
    return _val;
  }
  
  public void setState(boolean[] buffer, boolean[] rules) {
    int rule = 0;
    
    for(int i=0;i<_connections.length;i++) {
      rule += int(buffer[_connections[i]])<<i;
    }
    _val = rules[rule];
  }
}
