import 'dart:io';

/// Check for total overlap of sections
bool checkTotal(List<int> pairs) {
  return ((pairs[0] <= pairs[2] && pairs[1] >= pairs[3]) ||
      (pairs[0] >= pairs[2] && pairs[1] <= pairs[3]));
}

/// Check for partial overlap of sections
bool checkPartial(List<int> pairs) {
  return checkTotal(pairs) ||
      ((pairs[1] >= pairs[2] && pairs[1] <= pairs[3]) ||
          (pairs[0] >= pairs[2] && pairs[0] <= pairs[3]));
}

/// Process line from "2-4,6-8" to [2, 4, 6, 8]
List<int> processLine(String line) {
  return line
      .split(",")
      .map((e) => e.split("-"))
      .expand((x) => x)
      .map((e) => int.parse(e))
      .toList();
}

int fullyContained(List<String> lines) {
  int counter = 0;
  for (String line in lines) {
    if (checkTotal(processLine(line))) {
      counter++;
    }
  }
  return counter;
}

int partiallyContained(List<String> lines) {
  int counter = 0;
  for (String line in lines) {
    if (checkPartial(processLine(line))) {
      counter++;
    }
  }
  return counter;
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();
  int matches = 0;

  matches = fullyContained(lines);
  print("Part 1: $matches");

  matches = partiallyContained(lines);
  print("Part 2: $matches");
}
