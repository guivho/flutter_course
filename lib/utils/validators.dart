class Validators {
  static String password(String input) {
    List<String> e = [];
    input = input.trim();
    if (input == null || input.isEmpty) {
      e.add('Password is required');
    } else {
      if (input.length < 6) e.add('Minimum length is 6');
      if (!RegExp("[0-9]").hasMatch(input)) e.add('Use at least one digit');
      if (!RegExp("[A-Z]").hasMatch(input)) e.add('Use at least one of [A-Z]');
      if (!RegExp("[a-z]").hasMatch(input)) e.add('Use at least one of [a-z]');
      if (!RegExp("[ @!*&^]").hasMatch(input))
        e.add('Use at least one of [ @!*&^]');
    }
    if (e.length > 0) return e.join("\r\n");
    return null;
  }

  static String emailAddress(String input) {
    String re =
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    if (RegExp(re).hasMatch(input.trim())) return null;
    return "Invalid email address";
  }

  static String confirmPassword(String input, String password) {
    if (input.trim() == password.trim()) return null;
    return 'Passwords do not match!';
  }
}
