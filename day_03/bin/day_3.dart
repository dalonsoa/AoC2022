import 'dart:io';

/// Gets the priority of a letter
int getPriority(String letter) {
  int aCode = "a".codeUnitAt(0);
  int ACode = "A".codeUnitAt(0);
  int code = 0;

  if (letter.length != 1) {
    throw Exception("To get a priority we need extactly one character.");
  }

  code = letter.codeUnitAt(0);
  if (code < aCode) {
    code = code - ACode + 27;
  } else {
    code = code - aCode + 1;
  }
  return code;
}

/// Get the total priority of the repeated items in both compartments
int getTotalPriority(List<String> lines) {
  int totalPriority = 0;
  for (String line in lines) {
    String left = line.substring(0, line.length ~/ 2);
    String right = line.substring(line.length ~/ 2);

    for (int i = 0; i < left.length; i++) {
      if (right.contains(left[i])) {
        totalPriority += getPriority(left[i]);
        break;
      }
    }
  }
  return totalPriority;
}

/// Get the priority of the badge items
int getPriorityOfBadges(List<String> lines) {
  int totalPriority = 0;

  for (int i = 0; i < lines.length; i = i + 3) {
    Set<String> unique = Set.from(lines[i].split(""));

    for (String item in unique) {
      if (lines[i + 1].contains(item) & lines[i + 2].contains(item)) {
        totalPriority += getPriority(item);
        break;
      }
    }
  }
  return totalPriority;
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();

  print("Part 1: ${getTotalPriority(lines)}");
  print("Part 2: ${getPriorityOfBadges(lines)}");
}
