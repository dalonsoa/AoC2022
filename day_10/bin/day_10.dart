import 'dart:io';

/// Gets the number of steps related to a given order
List<int> getSteps(String line) {
  if (line.startsWith("addx")) {
    return [0, int.parse(line.split(" ")[1])];
  } else {
    return [0];
  }
}

/// Finds the signal stregth at key cycles
List<int> findSignalStregths(List<int> sequence) {
  int registry = 1;
  int cycle = 1;
  List<int> signalStrength = List.empty(growable: true);

  for (int step in sequence) {
    registry += step;
    cycle += 1;
    if ((cycle == 20) | (((cycle - 20) % 40) == 0)) {
      signalStrength.add(cycle * registry);
    }
  }
  return signalStrength;
}

/// Renders the CRT pattern
void renderCRT(List<int> sequence) {
  int registry = 1;
  int cycle = 1;
  int pixel = 0;
  List<String> row = List.empty(growable: true);

  for (int step in sequence) {
    row.add([registry - 1, registry, registry + 1].contains(pixel) ? "#" : ".");

    if ((cycle % 40) == 0) {
      pixel = 0;
      print(row.join());
      row.clear();
    } else {
      pixel++;
    }

    registry += step;
    cycle += 1;
  }
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();
  List<int> sequence = List.empty(growable: true);

  for (String line in lines) {
    sequence.addAll(getSteps(line));
  }

  List<int> signalStrength = findSignalStregths(sequence);
  print(
      "Part 1: ${signalStrength.reduce((value, element) => value + element)}");

  print("Part 2:");
  renderCRT(sequence);
}
