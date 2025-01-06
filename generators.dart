void main() {
  test();
}

void test() {
  final num = getNumbers();
  print(num);
  for (final number in getNumbers()) {
    print(number);
  }
}

Iterable<int> getNumbers() sync* {
  yield 1;
  yield 2;
  yield 3;
}
