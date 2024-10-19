var name = "macherechedze";
String fname = "john";
int page = 1;
double height = 5.9;
num age = 18;
bool ini = true;
List<String> names = ["Zuko", "Kyoshi", "Aang"];
List names_ages = ["Zuko", 21, "Kyoshi", 18, "Aang", 100];
Map<String, int> ages = {'Alice': 30, 'Bob': 56, "Charlie": 45};
String runesString = "Runes in Dart: \u{1F600} \u{1F64B} \u{1F680}";


void main() {
  for (int i = 0; i < 1; i++) {
    print(
        "$fname $name is ${age}yrs old and his height is $height which is $ini");
    print("Ages of students $ages");
    print(runesString);
  }
}
// this is a single line comment in dart
/* this is a multi line comment in dart */