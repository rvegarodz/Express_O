import 'package:intl/intl.dart';

/**
    Returns the current date in the format yyyyMMdd as an integer.
    @return An integer representing the current date in the format yyyyMMdd.
    */
String orderTime() {
  DateTime now = DateTime.now();
  String dateFormatted = DateFormat('yyyyMMdd_HHmmss').format(now);
  return dateFormatted;
}

/**
    Returns a string representing the name of an order document in Firestore.
    The document name is created by concatenating the current date and the last four characters of the provided user ID.
    @param userId A string representing the user ID.
    @param orderTime An integer representing the current date in the format yyyyMMdd.
    @return A string representing the name of the order document in Firestore.
    */
String orderDocName(String userId, String orderTime) {
  String last4Chars = userId.substring(userId.length - 4);
  String orderDocName = orderTime + '_' + last4Chars;
  return orderDocName;
}
