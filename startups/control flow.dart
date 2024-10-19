const doesOneEqualTwo = (1 == 2);
const global = 'Hello, world';
const score = 83;
String message = "";

void main() {
  print(doesOneEqualTwo);
  var command = '';
  var trafficLight = "green";

  if (trafficLight == 'red') {
    command = 'Stop';
  } else if (trafficLight == 'yellow') {
    command = 'Slow down';
  } else if (trafficLight == 'green') {
    command = 'Go';
  } else {
    command = 'INVALID COLOR!';
  }
  print(command);

  // scope
  const local = 'Hello, main';
  if (2 > 1) {
    const insideIf = 'Hello, anybody?';
    print(global);
    print(local);
    print(insideIf);
  }
  print(global);
  print(local);

// print(insideIf); // Not allowed!

// The Ternary Operator
if (score >= 60) {
message = 'You passed';
} else {
message = 'You failed';
}
message = (score >= 60) ? 'You passed' :'You failed';
}
