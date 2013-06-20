action_enum
===========

*Fake enums for actionscript*

Define Enum
-----------

```actionscript
public class MyEnum extends Enum {
  public static const Val1:MyTestEnum = new MyTestEnum();
  public static const Val2:MyTestEnum = new MyTestEnum();

  {
    Enum.init(MyTestEnum).expect(2);
  }
}
```

Defines Enum MyEnum, ensures there are only 2 static constants, gives each constant a name that is also returned by toString()

```actionscript
Enum.all(MyEnum);      // => [MyEnum.Val1, MyEnum.Val2]
Enum.amount(MyEnum);   // => 2
```
