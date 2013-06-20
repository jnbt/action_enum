package de.headjump.action_enum {

import org.flexunit.asserts.assertStrictlyEquals;
import org.flexunit.asserts.assertTrue;

public class EnumTest {
  public function EnumTest() {
  }

  [Test]
  public function testInitNames():void {
    assertStrictlyEquals(MyTestEnum.Val1.name, "Val1");
    assertStrictlyEquals(MyTestEnum.Val2.name, "Val2");
  }


  [Test]
  public function testDoesntThrowOnReinit():void {
    MyTestEnum.Val1; // to make sure class is used

    Enum.init(MyTestEnum);
    Enum.init(MyTestEnum);
  }

  [Test]
  public function testInitExpectThrowsOnWrongConstAmount():void {
    var failed:Boolean = false;
    try {
      Enum.init(MyTestEnum).expect(3);
    } catch(e:Error) {
      failed = true;
    }

    assertTrue(failed);
  }

  [Test]
  public function testEnumAll():void {
    assertTrue(Enum.all(MyTestEnum).indexOf(MyTestEnum.Val1) !== -1);
    assertTrue(Enum.all(MyTestEnum).indexOf(MyTestEnum.Val2) !== -1);
    assertStrictlyEquals(Enum.all(MyTestEnum).length, 2);
  }

  [Test]
  public function testEnumAllFailsOnUninitedClass():void {
    var failed:Boolean = false;
    try {
      Enum.all(String);
    } catch(e:Error) {
      failed = true;
    }

    assertTrue(failed);
  }

  [Test]
  public function testEnumAmount():void {
    assertStrictlyEquals(Enum.amount(MyTestEnum), 2);
  }
}
}
