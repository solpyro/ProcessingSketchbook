public static class Decoder {
  static Action[][] decode(String rule, int colors) {
    // dimentions of the rule is (colors X states)
    // where each rule is 1 hex number
    // and states is inferred
    
    // AB01 ->
    // 1 01 0  1 01 1
    // 0 00 0  0 00 1
    
    String[] stateRules = tokenize(rule, colors);
    
    Action[][] actions = new Action[stateRules.length][colors];
    
    for(int i=0;i<stateRules.length;i++) {
      for(int j=0;j<stateRules[i].length();j++)
        actions[i][j] = decodeAction(stateRules[i].charAt(j));
    }
    
    return actions;
  }
  
  static String[] tokenize(String s, int n) {
    if(s.length()%n!=0) {
      println("ERROR: Rule '"+s+"' does not cover all possible turmite states ("+n+"n)");
      return null;
    }
    
    String[] tokens = new String[s.length()/n];
    
    for(int i=0;i<tokens.length;i++)
      tokens[i] = s.substring(i*n,(i+1)*n);
    
    return tokens;
  }
  
  static Action decodeAction(char rule) {
    int r = unhex(str(rule));
    
    //      O T  S
    // A -> 1 01 0 
    // B -> 1 01 1
    // 0 -> 0 00 0
    // 1 -> 0 00 1
    
    int o = r >> 3;
    int t = (r >> 1) & 3;
    int s = r & 1;
    return new Action(o,t,s);     
  }
}
