package de.headjump.action_enum {
public class MyTestEnum extends Enum {
  public static const Val1:MyTestEnum = new MyTestEnum();
  public static var Val2:MyTestEnum; // it's a 'var' because it will be auto-instantiated

  {
    Enum.init(MyTestEnum).expect(2);
  }
}
}
