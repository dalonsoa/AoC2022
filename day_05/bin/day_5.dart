import 'dart:io';
import 'dart:collection';

/// Gets the header with the initial configuration of crates
List<String> getHeader(List<String> lines) {
  int headerEnd = 0;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].isEmpty) {
      headerEnd = i - 2;
      break;
    }
  }

  return lines.sublist(0, headerEnd + 1);
}

/// Create the crates structure.
///
/// The output contains a list of queues, with the first element the crate on
/// top.
List<Queue<String>> getCrates(List<String> header) {
  List<Queue<String>> crates = List.empty(growable: true);
  int colNum = header.last.split(" ").length;

  for (int i = 0; i < colNum; i++) {
    crates.add(Queue.from([]));
  }

  for (String line in header) {
    for (int i = 0; i < colNum; i++) {
      if (line[4 * i] == "[") {
        crates[i].add(line[4 * i + 1]);
      }
    }
  }
  return crates;
}

/// Execute reorganisation
List<Queue<String>> crateMover9000(
    List<Queue<String>> crates, List<String> instructions) {
  for (String line in instructions) {
    List<String> step = line.split(" ");
    int num = int.parse(step[1]);
    int from = int.parse(step[3]) - 1;
    int to = int.parse(step[5]) - 1;

    for (int i = 0; i < num; i++) {
      crates[to].addFirst(crates[from].removeFirst());
    }
  }

  return crates;
}

/// Execute reorganisation preserving the order of the crates
List<Queue<String>> crateMover9001(
    List<Queue<String>> crates, List<String> instructions) {
  List<String> crane = List.empty(growable: true);

  for (String line in instructions) {
    List<String> step = line.split(" ");
    int num = int.parse(step[1]);
    int from = int.parse(step[3]) - 1;
    int to = int.parse(step[5]) - 1;

    for (int i = 0; i < num; i++) {
      crane.add(crates[from].removeFirst());
    }

    for (String crate in crane.reversed) {
      crates[to].addFirst(crate);
    }

    crane.clear();
  }

  return crates;
}

/// Get string with the top crates
String getTop(List<Queue<String>> crates) {
  List<String> top = List.empty(growable: true);

  for (Queue col in crates) {
    top.add(col.first);
  }

  return top.join();
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();
  List<String> header = getHeader(lines);
  List<String> instructions = lines.sublist(header.length + 2);

  String top = getTop(crateMover9000(getCrates(header), instructions));
  print("Part 1: $top");

  top = getTop(crateMover9001(getCrates(header), instructions));
  print("Part 2: $top");
}
