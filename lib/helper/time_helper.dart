import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart' as intl;

extension StringParsing on DateTime {
  String forLastMessage() {
    final timePassed = DateTime.now().difference(this);

    final dateString = timePassed <= Duration(days: 2)
        ? timeago.format(this)
        : intl.DateFormat.yMd().format(this);
    return dateString;
  }

  String forMessages() {
    final timePassed = DateTime.now().difference(this);

    final dateString = timePassed <= Duration(days: 1)
        ? intl.DateFormat.jm().format(this)
        : intl.DateFormat.yMd().format(this) +
            ' ' +
            intl.DateFormat.jm().format(this);
    return dateString;
  }
}
