void main() {
  test();
}

void test() {
  final people = Pair("John", "Mary");
  final ages = Pair(20, 23);
  final mix = Pair("Lithium", 200);
  print("$people, $ages, $mix");
}

class Pair<A, B> {
  final A value1;
  final B value2;

  Pair(this.value1, this.value2);
}
