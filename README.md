action_enum
===========

`action_enum` is a package providing Enums for ActionScript. 

Most naive workarounds (see below, section 'Why?') have downsides. `action_enum` wraps proper ideas for faking Enums found on the web and adds some of its own.


Define Enum
-----------

```actionscript
public class MyEnum extends Enum {
  public static const Val1:MyEnum = new MyEnum();
  public static const Val2:MyEnum = new MyEnum();

  {
    Enum.init(MyEnum).expect(2);    // optional: enforce the amount of values with .expect(...)
  }
}
```

Defines Enum `MyEnum`, ensures there are only 2 static constants, gives each constant a name that is also returned by toString()

Here are two helpful methods:

```actionscript
Enum.all(MyEnum);      // => [MyEnum.Val1, MyEnum.Val2]
Enum.amount(MyEnum);   // => 2
```

### Example usage:

```actionscript
public class EAppState extends Enum {
  public static var Login:EAppState; // if not instantiated, Enum.init(...) will do it
  public static var Register:EAppState;
  public static var Dashboard:EAppState;

  {
    Enum.init(EAppState);
  }
}

// elsewhere in your application:

public function changeAppState(state:EAppState):void {
  //...
}
```

### On auto-instantiation

If one only defines a static value without instantiating it, Enum.init(...) will instantiate it. Please be aware that this doesn't work for constants (because they are constants)! - use `var` instead of `const` when you want auto-instanciation.

So auto-instantiation is a little shorter to write, but a little slower in execution (because constants are faster).


Why?
----

A naive way to fake Enums is using static constants of type `String` or `int / uint` in a dedicated class.

This has the downside that there is no proper *type-checking* for parameters, e.g. `changeState(state:int)` -vs- `changeState(state:EState)`

Also one could easily end up doing copy-paste errors when adding new values, changing the value-name but not the actual value.

```actionscript
public static const STATE1:int = 0;
public static const STATE2:int = 1;
public static const STATE3:int = 1; // Danger! Same value as STATE2 because you messed up
```

Sometimes one also wants to ensure the number of values in an Enum:

```actionscript
public class ETurtle extends Enum {
  public static var Leonardo:ETurtle;
  public static var Raphael:ETurtle;
  public static var Donatello:ETurtle;
  public static var Michelangelo:ETurtle;

  {
    Enum.init(ETurtle).expect(4); // <- Because we know there are 4 of them!
  }
}
```
