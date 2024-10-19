void funcFirst(int num1, int num2) {
  int sum = num1 + num2;
  print("first function has been executed");
  print(sum);
}

String InstructorsName() {
  return "Allan Lenkaa";
}

int add(int a, int b) {
  int sum = a + b;
  return sum;
}

// anonymous functions
var printNum = (int num11) {
  print(num11);
};

// arrow functions
void fatArrow() => print("i'm a fat arrow function");
// double calculateInterest(double principal, double rate, double time) {
//   double interest = principal * rate * time / 100;
//   return interest;
// }
double calculateInterest(double principal, double rate, double time) =>
    principal * rate * time / 100;

void main() {
//   funcFirst(20, 30);

//   String name = InstructorsName();
//   int sum = add(1, 1);
//   print("$name, $sum");

//   printNum(34);

// // anonymous functions
//   const fruits = ["Apple", "Mango", "Banana", "Orange"];
//   fruits.forEach((fruit) {
//     print(fruit);
//   });

  // arrow functions
  fatArrow();
  double calc = calculateInterest(10000, 5, 12);
  print(calc);
}
