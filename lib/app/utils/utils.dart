String formatDuration(Duration d) =>
    d.toString().split('.').first.padLeft(8, "0");

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
