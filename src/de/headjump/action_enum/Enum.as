package de.headjump.action_enum {
public class Enum {
  private var _name:String;

  public function Enum() {
    _name = "";
  }

  public function toString():String {
    return _name;
  }

// getter, setter
  public function set name(val:String):void { _name = val; }
  public function get name():String { return _name; }
}
}
