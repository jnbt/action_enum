package de.headjump.action_enum {
public class MyTestEnum extends Enum {
  public static const Val1:MyTestEnum = new MyTestEnum();
  public static const Val2:MyTestEnum = new MyTestEnum();

  {
    Enum.init(MyTestEnum).expect(2);
  }
}
}
