import 'package:flutter/material.dart';

import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': ( _ ) => const UsuariosPage(),
  'register': ( _ ) => const RegisterPage(),
  'login'   : ( _ ) => const LoginPage(),
  'loading' : ( _ ) => const LoadingPage(),
  'chat'    : ( _ ) => const ChatPage(),
};