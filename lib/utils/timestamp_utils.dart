import 'package:intl/intl.dart';

String timestampToHour(String? timestamp, String? formatParse) {
  if (timestamp == null) {
    return 'Timestamp Empty';
  } else {
    var parser = DateFormat('yyyy-MM-dd HH:mm:ss.mmmmmm');
    var format = DateFormat(formatParse);
    var result = format.format(parser.parse(timestamp));

    return result;
  }
}
