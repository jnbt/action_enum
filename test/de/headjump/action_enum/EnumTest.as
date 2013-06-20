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
}
}
