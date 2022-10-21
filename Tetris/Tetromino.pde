class Tetromino {
  int _width;

  public int[][] L, Z, T, O, I;
  
  
  public Tetromino(int w) {
    _width = w;
    
    buildL();
    buildZ();
    buildT();
    buildO();
    buildI();
  }
  public int[][] getShape(char s) {
    switch(s){
      case 'L':
        return L;
      case 'Z':
        return Z;
      case 'T':
        return T;
      case 'O':
        return O;
      case 'I':
        return I;
      default:
        return null;
    }
  }
  public char randomShape() {
    int n = floor((random(5)));
    switch(n){
      case 0:
        return 'L';
      case 1:
        return 'Z';
      case 2:
        return 'T';
      case 3:
        return 'O';
      case 4:
      default:
        return 'I';
    }
  }
  
  void buildL() {
    int[][] _l = {
      {1, _width+1, _width*2+1, 2},
      {_width, _width+1, _width*2+1, _width*2},
      {1, _width+1, _width*2+1, _width*2},
      {_width, _width*2, _width*2+1, _width*2+2}
    };
    L = _l;
  }
  void buildZ() {
    int[][] _z = {
      {0, _width, _width+1, _width*2+1},
      {_width+1, _width+2, _width*2, _width*2+1},
      {0, _width, _width+1, _width*2+1},
      {_width+1, _width+2, _width*2, _width*2+1}
    };
    Z = _z;
  }
  void buildT() {
    int[][] _t = {
      {1, _width, _width+1, _width+2},
      {1, _width+1, _width+2, _width*2+1},
      {_width, _width+1, _width+2, _width*2+1},
      {1, _width, _width+1, _width*2+1}
    };
    T = _t;
  }
  void buildO() {
    int[][] _o = {
      {0, 1, _width, _width+1},
      {0, 1, _width, _width+1},
      {0, 1, _width, _width+1},
      {0, 1, _width, _width+1}
    };
    O = _o;
  }
  void buildI() {
    int[][] _i = {
      {1, _width+1, _width*2+1, _width*3+1},
      {_width, _width+1, _width+2, _width+3},
      {1, _width+1, _width*2+1, _width*3+1},
      {_width, _width+1, _width+2, _width+3}
    };
    I = _i;
  }
}
