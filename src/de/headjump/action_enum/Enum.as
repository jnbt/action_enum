package de.headjump.action_enum {
import avmplus.getQualifiedClassName;

import flash.utils.Dictionary;
import flash.utils.describeType;

public class Enum {
  public static const VERSION:Number = 1.0;

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
  private static var _MAP:Dictionary = new Dictionary();

  public static function all(cl:Class):Array {
    if(!_MAP[cl]) throw new Error("Enum " + cl + " not found. Did you call Enum.init(...) on this class?");
    return _MAP[cl].all;
  }

  public static function amount(cl:Class):int {
    if(!_MAP[cl]) throw new Error("Enum " + cl + " not found. Did you call Enum.init(...) on this class?");
    return _MAP[cl].amount;
  }

  public static function init(cl:Class):Object {
    var desc:XML = describeType(cl),
        info:Object = {
          amount: 0,
          all: [],
          name: getQualifiedClassName(cl).split(":").reverse()[0]
        };
    for each (var constant:XML in desc.constant) {
      cl[constant.@name].name = constant.@name;
      info.all.push(cl[constant.@name]);
      info.amount++;
    }

    _MAP[cl] = info;

    return {
      expect: function(amount:int):void {
        if(amount !== info.amount) throw new Error("Enum '" + info.name + "' expected to have " + amount + " values, had " + info.amount);
      }
    }
  }
}
}
