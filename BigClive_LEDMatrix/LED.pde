interface LED {
  float x();
  float y();
  boolean glow();
  color glowColour();
  color bulbColour();
  
  void update(int dt);
}
