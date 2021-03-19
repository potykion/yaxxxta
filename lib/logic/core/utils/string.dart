/// Удаляет символы справа
/// https://stackoverflow.com/a/57007532/5500609
String rtrim(String from, String pattern) {
  var i = from.length;
  while (from.startsWith(pattern, i - pattern.length)) {
    i -= pattern.length;
  }
  return from.substring(0, i);
}
