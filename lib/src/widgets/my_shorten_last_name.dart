String shortenLastName(String fullName) {
  List<String> nameParts = fullName.split(" ");

  if (nameParts.length >= 3) {
    String firstName = nameParts.first;
    String middleName = nameParts[1];
    String lastName = nameParts.last;

    String abbreviatedLastName =
        lastName.length > 1 ? "${lastName[0]}." : lastName;

    return "$firstName $middleName $abbreviatedLastName";
  } else {
    return fullName; // Return the original name if it has less than 3 words
  }
}
