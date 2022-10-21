  final int TURN_N = 0,
          TURN_R = 1,
          TURN_U = 2,
          TURN_L = 3;

public static class Action {
  public int _output,
             _turn,
             _state;
      
  public Action(int output, int turn, int state) {
    _output = output;
    _turn = turn;
    _state = state;
  }
}
