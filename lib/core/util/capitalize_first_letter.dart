abstract class CapitalizeFirstLetter {
  String capitalizeInput(String input);
}

class CapitalizeFirstLetterImpl extends CapitalizeFirstLetter {
  @override
  String capitalizeInput(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }
}
