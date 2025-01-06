void main() {
  // final loc = Location("New York");
  // loc.findLocation();
  test();
}

void test() async {
  // Future
  // final result = await futureForLocation("Michigan");
  // print(result);

  // Stream
  await for (final value in getLocName()) {
    print(value);
  }
}

class Location {
  final locationName;

  Location(this.locationName);
}

extension FindLocation on Location {
  void findLocation() {
    print("finding best location");
  }
}

Future<String> futureForLocation(String locName) {
  return Future.delayed(
      Duration(seconds: 3), () => "Finding route for " + locName);
}

Stream<String> getLocName() {
  return Stream.periodic(Duration(seconds: 3), (value) => "Dakota");
}
