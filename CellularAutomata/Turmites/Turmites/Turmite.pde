final int DIR_E = 0,
          DIR_S = 1,
          DIR_W = 2,
          DIR_N = 3;

public class Turmite {
  Action[][] _rule; //[state[color,color],state[color,color]]
  public int _x,
             _y;
  int _dir,
      _state;
  color[] _colors;
  
  public Turmite(int x, int y, String rule, color[] colors) {
    _x = x;
    _y = y;
    _dir = DIR_E;
    _colors = colors;
    
    _rule = Decoder.decode(rule, _colors.length);
  }
  
  public void update(PGraphics field) {
    int fieldState = readCell(field);
    
    Action todo = _rule[_state][fieldState];
    
    writeCell(field, todo._output);
    turn(todo._turn);
    _state = todo._state;
    
    move(field);
  }
    
  int readCell(PGraphics field){
    color c = field.get(_x,_y);
    
    for(int i=0;i<_colors.length;i++)
      if(_colors[i]==c)
        return i;
    
    return -1;
  }
  void writeCell(PGraphics field, int c){
    field.set(_x,_y,_colors[c]);
  }
  void turn(int dir){
    _dir += dir;
    _dir %= 4;
  }
  void move(PGraphics field){
    switch(_dir) {
      case DIR_N:
        _y--;
        break;
      case DIR_S:
        _y++;
        break;
      case DIR_W:
        _x--;
        break;
      case DIR_E:
        _x++;
        break;
    }
    
    if(_x<0)
      _x = field.width-1;
    if(_x>=field.width)
      _x = 0;
      
    if(_y<0)
      _y = field.height-1;
    if(_y>=field.height)
      _y = 0;
  }
}
