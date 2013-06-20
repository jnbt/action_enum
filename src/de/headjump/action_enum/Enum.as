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

  private static function extractVariableOrConstant(cl:Class, name:String, info_target:Object, allow_auto_instantiate:Boolean):void {
    if(allow_auto_instantiate && !cl[name]) {
      cl[name] = new cl();
    }

    if(cl[name] is cl) {
      cl[name].name = name;
      info_target.all.push(cl[name]);
      info_target.amount++;
    }
  }

  public static function init(cl:Class):Object {
    var desc:XML = describeType(cl),
        info:Object = {
          amount: 0,
          all: [],
          name: getQualifiedClassName(cl).split(":").reverse()[0]
        };
    for each (var constant:XML in desc.constant) {
      extractVariableOrConstant(cl, constant.@name, info, false);
    }
    for each (var variable:XML in desc.variable) {
      extractVariableOrConstant(cl, variable.@name, info, true); // variables can be auto-instantiated
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
