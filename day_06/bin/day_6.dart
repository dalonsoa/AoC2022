import 'dart:io';

/// Find a marker of the specified length
int findMarker(String line, int num) {
  int marker = 0;
  for (int i = num; i < line.length; i++) {
    Set code = Set.from(line.substring(i - num, i).split(""));
    if (code.length == num) {
      marker = i;
      break;
    }
  }
  return marker;
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();
  int marker = 0;

  for (String line in lines) {
    marker = findMarker(line, 4);
    print("Part 1: $marker");
  }

  for (String line in lines) {
    marker = findMarker(line, 14);
    print("Part 2: $marker");
  }
}
