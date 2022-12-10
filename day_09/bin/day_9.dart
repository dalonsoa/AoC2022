import 'dart:io';
import 'dart:math';

/// Finds the step for the head
Point<int> headStep(String dir, int steps) {
  if (dir == "R") {
    return Point(0, steps);
  } else if (dir == "L") {
    return Point(0, -steps);
  } else if (dir == "U") {
    return Point(steps, 0);
  } else if (dir == "D") {
    return Point(-steps, 0);
  } else {
    throw Exception(
        "Invalid direction! Valid values are 'R', 'L', 'U' and 'D'.");
  }
}

/// Finds the step for the tail
Point<int> tailStep(Point<int> head, Point<int> tail) {
  var sep = tail - head;
  if ([-1, 0, 1].contains(sep.x) & [-1, 0, 1].contains(sep.y)) {
    return Point(0, 0);
  } else if ((sep.x == 0) & [-2, 2].contains(sep.y)) {
    return Point(0, (sep.y < 0 ? 1 : -1));
  } else if ((sep.y == 0) & [-2, 2].contains(sep.x)) {
    return Point((sep.x < 0 ? 1 : -1), 0);
  } else {
    return Point((sep.x < 0 ? 1 : -1), (sep.y < 0 ? 1 : -1));
  }
}

/// Tracks the tail of the snake (aka rope) across the space
///
/// First, the head is moved according to the instructions. Then, each element
/// of the snake (aka knot) is moved following the previous one. The places
/// visited by the tail (the last knot) are tracked and returned.
List<Point<int>> trackTailSnake(
    List<Point<int>> snake, List<String> instructions) {
  List<Point<int>> visited = List.empty(growable: true);
  String dir;
  int steps;

  visited.add(snake.last);
  // Loop over the instructions
  for (String line in instructions) {
    dir = line.split(" ")[0];
    steps = int.parse(line.split(" ")[1]);

    // Loop over the steps
    for (int i = 0; i < steps; i++) {
      snake[0] = snake[0] + headStep(dir, 1);

      // Loop over the elements of the snake
      for (int j = 1; j < snake.length; j++) {
        snake[j] = snake[j] + tailStep(snake[j - 1], snake[j]);
      }

      if (!visited.contains(snake.last)) {
        visited.add(snake.last);
      }
    }
  }
  return visited;
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';
  // var fileName = 'test_long.txt';

  List<String> lines = File(fileName).readAsLinesSync();

  var snake = List.filled(2, Point(0, 0));
  var visited = trackTailSnake(snake, lines);
  print("Part 1: ${visited.length}");

  snake = List.filled(10, Point(0, 0));
  visited = trackTailSnake(snake, lines);
  print("Part 2: ${visited.length}");
}
