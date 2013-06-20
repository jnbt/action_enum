action_enum
===========

*Fake enums for actionscript*

Actionscript (which I love) doesn't have native Enums. Most naive workarounds (see below, section 'Why?') have some downsides. So I collected the best ideas I found on the web and added some of my own.


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
  public static var Login:EAppState; // if you don't instantiate it, Enum.init(...) will do it by calling 'new AppState();'
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

If you only define a static value without instanciating it Enum.init(...) will instanciate it for you. Please be aware that this doesn't work for constants! (because they are constants) - You have to use `var` instead of `const` when you want auto-instanciation.

So auto-instantiation is a little shorter to write, but a little slower in execution (because constants are faster). Also you could change an Enum value that is a variable (not a constant) after creation somewhere, because a variable is not locked (don't do this, ok?).


Why?
----

A naive (and good-enough for lots of cases) way to fake Enums is using static constants of type `String` or `int / uint` in a dedicated class.

This has the downside that don't have proper *type-checking* for parameters, e.g. `changeState(state:int)` -vs- `changeState(state:EState)`

Also you could easily end up doing copy-page errors when adding new values, changing the value-name but not the actual value.

E.g:

```actionscript
public static const STATE1:int = 0;
public static const STATE2:int = 1;
public static const STATE3:int = 1; // Danger! Same value as STATE2 because you messed up
```

Sometimes I also want to ensure the number of values in an Enum to make sure I didn't miss anything.

E.g:

```actionscript
public class ETurtle extends Enum {
  public static var Leonardo:ETurtle;
  public static var Raphael:ETurtle;
  public static var Donatello:ETurtle;
  public static var Michelangelo:ETurtle;

  {
    Enum.init(ETurtle).expect(4);      // <- Because I know there are 4 of them!
  }
}
```
