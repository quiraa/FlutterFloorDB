import 'package:intl/intl.dart';

class Utils {
  static String createDate() {
    var now = DateTime.now();
    var pattern = DateFormat('EEEE, d MMMM yyyy');
    return pattern.format(now);
  }
}
