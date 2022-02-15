
import 'dart:io';
import 'package:flutter/foundation.dart';//kIsWeb


class Environment{

  static String apiUrl = kIsWeb ? 'http://192.168.1.71:3000/api' : 'http://192.168.1.71:3000/api';
  //static String apiUrl = Platform.isAndroid ? 'http://192.168.1.71:3000/api' : 'http:localhost:3000/api';
  static String socketUrl = Platform.isAndroid ? 'http://192.168.1.71:3000' : 'http://192.168.1.71:3000';
  //static String socketUrl = Platform.isAndroid ? 'http://192.168.1.71:3000' : 'http:localhost:3000';

}