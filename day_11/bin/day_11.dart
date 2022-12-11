import 'dart:io';

class Monkey {
  List<int> items = [];
  int numOp = 0;
  List<String> operation = [];
  int divisibleBy = 1;
  int onTrue = 1;
  int onFalse = 2;

  /// Manipulates the item at the indez position
  ///
  /// It then scale the result to a manageable int size, which does not alter
  /// the end result, anf, potentially, apply a relief of worrines.
  int manipulate(int index, int relief, int commonDivisor) {
    numOp += 1;

    int first =
        ("old" == operation[0]) ? items[index] : int.parse(operation[0]);
    int second =
        ("old" == operation[2]) ? items[index] : int.parse(operation[2]);

    return (((operation[1] == "+") ? first + second : first * second) %
            commonDivisor) ~/
        relief;
  }

  int test(int item) {
    return ((item % divisibleBy) == 0) ? onTrue : onFalse;
  }
}

/// Get's the list of monkeys and therir initial state from the input
List<Monkey> getMonkeys(List<String> lines) {
  List<Monkey> monkeys = [];

  for (String line in lines) {
    if (line.startsWith("Monkey")) {
      monkeys.add(Monkey());
    } else if (line.contains("Starting items")) {
      monkeys.last.items =
          line.split(":").last.split(",").map((e) => int.parse(e)).toList();
    } else if (line.contains("Operation")) {
      monkeys.last.operation = line.split(" = ").last.split(" ");
    } else if (line.contains("Test")) {
      monkeys.last.divisibleBy = int.parse(line.split(" ").last);
    } else if (line.contains("true")) {
      monkeys.last.onTrue = int.parse(line.split(" ").last);
    } else if (line.contains("false")) {
      monkeys.last.onFalse = int.parse(line.split(" ").last);
    }
  }

  return monkeys;
}

/// Runs through the rounds to get the monkeys business level
///
/// This is defined as the multiplication of the number of manipulations of the
/// two monkeys who have done more manipulations.
int getBusiness(
    List<Monkey> monkeys, int rounds, int relief, int commonDivisor) {
  for (int j = 0; j < rounds; j++) {
    for (Monkey monkey in monkeys) {
      for (int i = 0; i < monkey.items.length; i++) {
        int item = monkey.manipulate(i, relief, commonDivisor);
        monkeys[monkey.test(item)].items.add(item);
      }
      monkey.items.clear();
    }
  }

  List<int> business = monkeys.map((e) => e.numOp).toList();
  business.sort();
  business = business.reversed.toList().sublist(0, 2);

  return business[0] * business[1];
}

void main(List<String> arguments) {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();

  List<Monkey> monkeys = getMonkeys(lines);
  // This is obtained from the multiplication of the divisibleBy attributes of
  // each monkey to ensure that the worrines level is always within reasonable
  // values (i.e., can be stored in the computer!)
  int commonDivisor =
      monkeys.map((e) => e.divisibleBy).reduce((value, e) => value * e);

  print("Part 1: ${getBusiness(monkeys, 20, 3, commonDivisor)}");

  monkeys = getMonkeys(lines);
  print("Part 2: ${getBusiness(monkeys, 10000, 1, commonDivisor)}");
}
