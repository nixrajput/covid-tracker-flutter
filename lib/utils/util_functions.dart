RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

String formatToNumeric(String value) {
  return value.replaceAllMapped(reg, mathFunc);
}
