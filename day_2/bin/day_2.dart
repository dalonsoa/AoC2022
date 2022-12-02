import 'dart:io';

int checkRound(String round) {
  switch (round) {
    case "A X":
      {
        return 3 + 1;
      }
    case "B X":
      {
        return 0 + 1;
      }
    case "C X":
      {
        return 6 + 1;
      }
    case "A Y":
      {
        return 6 + 2;
      }
    case "B Y":
      {
        return 3 + 2;
      }
    case "C Y":
      {
        return 0 + 2;
      }
    case "A Z":
      {
        return 0 + 3;
      }
    case "B Z":
      {
        return 6 + 3;
      }
    default:
      {
        return 3 + 3;
      }
  }
}

int checkRoundV2(String round) {
  switch (round) {
    case "A X":
      {
        return 0 + 3;
      }
    case "B X":
      {
        return 0 + 1;
      }
    case "C X":
      {
        return 0 + 2;
      }
    case "A Y":
      {
        return 3 + 1;
      }
    case "B Y":
      {
        return 3 + 2;
      }
    case "C Y":
      {
        return 3 + 3;
      }
    case "A Z":
      {
        return 6 + 2;
      }
    case "B Z":
      {
        return 6 + 3;
      }
    default:
      {
        return 6 + 1;
      }
  }
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();

  // Part 1
  int score = lines.map(checkRound).reduce((value, element) => value + element);
  print("Part 1: $score");

  // Part 2
  score = lines.map(checkRoundV2).reduce((value, element) => value + element);
  print("Part 2: $score");
}
