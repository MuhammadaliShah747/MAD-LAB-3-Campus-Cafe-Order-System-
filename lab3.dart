// lab3.dart  -  Campus Cafe Order System
// Name: Muhammad Ali Shah   Roll no: 04072313023

const String rollNo = '04072313023';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  var item2 = Dish();
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);
  item2.price = item2.price - u;
  print('Step 1:  <${item1.name}> Rs <${item1.price}>');
  print('Step 1:  <${item2.name}> Rs <${item2.price}>');
}

void step2() {
  print('--- Step 2 ---');

  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);
  print('Step 2: <${a.name}> Rs <${a.price}>');
  print('Step 2: Test Special Rs <${b.price}>');
}

void step3() {
  print('--- Step 3 ---');
  //3.3
  var freebie = MenuItem.free('Water');
  var i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: <${freebie.name}> Rs <${freebie.price}>');
  print('Step 3: <${parsed.name}> Rs <${parsed.price}>');
  print('Step 3: floor=<${priceFloor}>, free price=<${freebie.price}>');
  //the floor is 80 but the free() produced 0 because in the free() constructor we arent checking for the price floor, we are  just setting thr price to 0
}

void step4() {
  print('--- Step 4 ---');
  //4.2
  var log1 = OrderLog();
  var log2 = OrderLog();

  for (var i = 1; i <= u + 2; i++) {
    var x = 'order #${100 * t + i}\n';

    if (i % 2 == 0) {
      log2.entries.add(x);
    } else {
      log1.entries.add(x);
    }
  }

  print('Step 4: same object? <${log1 == log2}>');
  print('Step 4: entries = <${log1.entries.length}>');
  print('Step 4: last = <${log2.entries.last}>');
}

void step5() {
  print('--- Step 5 ---');
  //5.3

  print('--- Step 5 ---');

  // Call mainOrder() as required by Task 5.3
  var line = mainOrder();

  // Print the first two required lines
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  // Assertion test block
  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
  //Initializer lists execute before the object is created and before its fields are assigned in memory. so , fields like total do not exist
  //when 'tax' is being initialized, sowe have to use the constructor parameters instead.
}

void step6() {
  print('--- Step 6 ---');
}

void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}

//task 1
//1.1

class Dish {
  late String name;
  late int price;
}

//2.1
class MenuItem {
  String name; // we cant have price declared as final as we are updating it in the constructor if its less then the pricefloor
  int price;

  MenuItem(this.name, this.price) {
    if (price < priceFloor) {
      this.price = priceFloor;
    }
  }

  //3.1
  MenuItem.free(this.name) : price = 0;
  //3.2
  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);
}

//4.1
class OrderLog {
  static OrderLog? _instance;
  //They start with an underscore to make them private
  //without it, outside code can create new instances or updatee _instance
  final List<String> entries = [];
  OrderLog._internal();

  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }

  void add(String msg) => entries.add(msg);
}

//task 5.1
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;
  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = (item.price * qty * taxPercent) ~/ 100,
      assert(qty > 0, 'qty must be positive');
  int get_grand() {
    return (total + tax);
  }

  bool get_isBigOrder() {
    if (get_grand() > bigOrderLimit) {
      return true;
    } else {
      return false;
    }
  }
}

OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}
