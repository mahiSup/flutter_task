extension StringCasingExtension on String {
  String capitalizeWords() {
    return split(' ')
        .map(
          (word) => word.isEmpty
          ? word
          : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
    )
        .join(' ');
  }
}