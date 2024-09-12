import 'package:flutter/cupertino.dart';

class UnfocusedContext {
  static unfocusedContext(BuildContext context) {
    return FocusScope.of(context).unfocus();
  }
}
