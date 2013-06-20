action_enum
===========

*Fake enums for actionscript*

Actionscript (which I love) doesn't have native Enums. Most naive workarounds (see below, section 'Why?') have some downsides. So I collected the best ideas I found in the web and added some of my own sugar.


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
public class AppState extends Enum {
  public static const Login:AppState; // if you don't initialize it, Enum.init(...) will create a new instance
  public static const Register:AppState;
  public static const Dashboard:AppState;

  {
    Enum.init(AppState);
  }
}

// elsewhere in your application:

public function changeAppState(state:AppState):void {
  //...
}
```


Why?
----

A naive (and good-enough for lots of cases) way to fake Enums is using static constants of type `String` or `int / uint` in a dedicated class.

This has the downside that don't have proper *type-checking* for parameters, e.g. `changeState(state:int)` -vs- `changeState(state:EState)`

Also you could easily end up doing copy-page errors when adding new values, changing the value-name but not the actual value.

E.g:

```actionscript
public static const STATE1:int = 0;
public static const STATE2:int = 1;
public static const STATE3:int = 1;    // Danger! Same value as STATE2 because you messed up while copy-pasting
```

Sometimes I also want to ensure the number of values in an Enum to make sure I didn't miss anything.

E.g:

```actionscript
public class Turtle extends Enum {
  public static const Leonardo:Turtle;
  public static const Raphael:Turtle;
  public static const Donatello:Turtle;
  public static const Michelangelo:Turtle;

  {
    Enum.init(Turtle).expect(4);      // <- Because I know there are 4 of them!
  }
}
```
