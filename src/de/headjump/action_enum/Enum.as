package de.headjump.action_enum {
import flash.utils.describeType;

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

// statics ------------
  public static function init(cl:Class):Object {
    var desc:XML = describeType(cl),
        count:int = 0;
    for each (var constant:XML in desc.constant) {
      cl[constant.@name].name = constant.@name;
      count++;
    }

    return {
      expect: function(amount:int):void {
        if(amount !== count) throw new Error("Enum '" + "' expected to have " + amount + " values, had " + count);
      }
    }
  }
}
}
