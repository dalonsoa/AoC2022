import 'dart:io';

void main() {
  var fileName = 'input.txt';
  // var fileName = 'test.txt';

  List<String> lines = File(fileName).readAsLinesSync();
  int currentElf = 1;
  int currentCalories = 0;
  int mostCaloriesElf = 1;
  int mostCalories = 0;
  List<int> allCalories = List.empty(growable: true);

  for (var line in lines) {
    var calories = int.tryParse(line);

    // As long as we don't get a blank line, we add the calories
    if (calories != null) {
      currentCalories = currentCalories + calories.toInt();

      // When there's a blank line, check if it is the lasrgest and add it to the
      // list of all calories
    } else {
      if (currentCalories > mostCalories) {
        mostCaloriesElf = currentElf;
        mostCalories = currentCalories;
      }
      allCalories.add(currentCalories);
      currentCalories = 0;
      currentElf += 1;
    }
  }

  // If the last calories is not zero, we add it to the list.
  if (currentCalories != 0) {
    allCalories.add(currentCalories);
  }

  allCalories.sort();

  print(mostCaloriesElf);
  print(allCalories.last);
  print(allCalories
      .sublist(allCalories.length - 3)
      .reduce((value, element) => value + element));
}
