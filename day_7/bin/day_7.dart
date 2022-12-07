import 'dart:io';
import 'dart:collection';

/// Switch directory
void cd(String dir, Queue<String> pwd) {
  if (dir == "..") {
    pwd.removeLast();
  } else {
    pwd.add(dir);
  }
}

/// Scans a directory recursively, calculating the size of subdirectories
void walkContents(
    String dir, Map<String, int> sizes, Map<String, List<String>> contains) {
  // Already done, so we move on
  if (sizes[dir] != 0) {
    return;
  }

  // Not done, so we scan the contents to gather their sizes
  for (var item in contains[dir]!) {
    if (sizes[item] == 0) {
      walkContents(item, sizes, contains);
    }
    sizes[dir] = sizes[dir]! + sizes[item]!;
  }
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();
  Queue<String> pwd = Queue();
  Map<String, List<String>> contains = {};
  Map<String, int> sizes = {};
  List<String> output;
  int totalSize = 0;
  const maxSize = 70000000;
  const needFree = 30000000;

  for (String line in lines) {
    if (line.startsWith("\$ cd")) {
      cd(line.split(" ").last, pwd);
    } else if (line.startsWith("\$ ls")) {
      contains[pwd.toList().join("/")] = [];
      sizes[pwd.toList().join("/")] = 0;
    } else if (line.startsWith("dir")) {
      output = line.split(" ");
      contains[pwd.toList().join("/")]!
          .add("${pwd.toList().join("/")}/${output.last}");
    } else {
      output = line.split(" ");
      contains[pwd.toList().join("/")]!
          .add("${pwd.toList().join("/")}/${output.last}");
      sizes["${pwd.toList().join("/")}/${output.last}"] =
          int.parse(output.first);
    }
  }

  walkContents("/", sizes, contains);

  for (String dir in contains.keys) {
    totalSize += sizes[dir]! <= 100000 ? sizes[dir]! : 0;
  }

  print("Part 1: $totalSize");

  var targetFree = needFree - (maxSize - sizes['/']!);
  var smallest = maxSize;

  for (String dir in contains.keys) {
    if ((sizes[dir]! > targetFree) & (sizes[dir]! < smallest)) {
      smallest = sizes[dir]!;
    }
  }
  print("Part 2: $smallest");
}
