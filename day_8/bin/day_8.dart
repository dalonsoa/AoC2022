import 'dart:io';

/// Finds if a tree is largest than any other tree in a list
bool isLargest(int heigth, List<int> others) {
  for (int i = 0; i < others.length; i++) {
    if (heigth <= others[i]) {
      return false;
    }
  }
  return true;
}

/// Finds if a tree at a certain grid position is visible in any direction.
bool isVisible(int row, int col, List<List<int>> grid) {
  var numRow = grid.length;
  var numCol = grid[0].length;

  if ((row == 0) | (row == numRow - 1) | (col == 0) | (col == numCol - 1)) {
    return true;
  }

  return isLargest(grid[row][col], grid[row].sublist(0, col)) |
      isLargest(grid[row][col], grid[row].sublist(col + 1)) |
      isLargest(
          grid[row][col], grid.map((e) => e[col]).toList().sublist(0, row)) |
      isLargest(
          grid[row][col], grid.map((e) => e[col]).toList().sublist(row + 1));
}

/// Finds the number of vissible trees from the outside
int numVisibleTrees(List<List<int>> grid) {
  int visibleCount = 0;

  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (isVisible(i, j, grid)) {
        visibleCount++;
      }
    }
  }

  return visibleCount;
}

/// Finds the number of trees seen by another tree
///
/// The list of other trees must be sorted so that the first element in the list
/// is the closest to the current tree.
int seenInDirection(int heigth, List<int> others) {
  int seen = 0;
  for (int i = 0; i < others.length; i++) {
    if (heigth <= others[i]) {
      seen++;
      break;
    }
    seen++;
  }
  return seen;
}

/// Calculates the score for a particular tree
int scoreForTree(int row, int col, List<List<int>> grid) {
  var numRow = grid.length;
  var numCol = grid[0].length;

  if ((row == 0) | (row == numRow - 1) | (col == 0) | (col == numCol - 1)) {
    return 0;
  }

  return seenInDirection(
          grid[row][col], grid[row].sublist(0, col).reversed.toList()) *
      seenInDirection(grid[row][col], grid[row].sublist(col + 1)) *
      seenInDirection(grid[row][col],
          grid.map((e) => e[col]).toList().sublist(0, row).reversed.toList()) *
      seenInDirection(
          grid[row][col], grid.map((e) => e[col]).toList().sublist(row + 1));
}

/// Find the highest possible scenic score
int findHighestScenicScore(List<List<int>> grid) {
  int score = 0;
  int current = 0;

  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      current = scoreForTree(i, j, grid);
      if (current > score) {
        score = current;
      }
    }
  }

  return score;
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<List<int>> lines = File(fileName)
      .readAsLinesSync()
      .map((e) => e.split("").map((e) => int.parse(e)).toList())
      .toList();

  print("Part 1: ${numVisibleTrees(lines)}");
  print("Part 2: ${findHighestScenicScore(lines)}");
}
