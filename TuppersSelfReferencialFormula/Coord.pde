public class Coord {
  public int x;
  public int y;
  
  public Coord(int _x, int _y) {
    x = _x;
    y = _y;
  }
  
  public Coord Add(Coord additive) {
    return new Coord(
      this.x + additive.x,
      this.y + additive.y
    );
  }
}
