import 'dart:io';

import 'package:simple_chat/src/user_detail/domain/user_detail.dart';

class GoogleAds {
  const GoogleAds._();

  static String get bannerId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
}

class UserInformation {
  UserInformation();

  UserDetail? userDetail;
}
