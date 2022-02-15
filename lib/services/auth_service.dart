import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/usuario.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/global/environment.dart';

class AuthService with ChangeNotifier{

  Usuario? usuario;
  bool _autenticando = false;
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;

  Usuario? get getusuario => usuario;

  set autenticando (bool val) {
    _autenticando = val;
    notifyListeners();
  }

  //Getters del token de forma estatica
  static Future<String?>getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key:  'token');
    return token;
  }

  static Future<String?>deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key:  'token');
  }

  Future<bool> login (String email, String password) async {

    autenticando = true;
    final data = {
      'email': email,
      'password': password,
    };
    var url = Uri.parse('${Environment.apiUrl}/login/');
    final resp = await http.post(url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'}
    );

    autenticando = false;
    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
    
  }

  Future register(String nombre, String email, String password) async{
    autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    var url = Uri.parse('${Environment.apiUrl}/login/new/');
    final resp = await http.post(url,
    body: jsonEncode(data),
    headers: {'Content-Type': 'application/json'}
    );

    autenticando = false;
    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future isLoggedIn()async {
    final token = await _storage.read(key:   'token');
    
    var url = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp = await http.get(url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token.toString()
        }
    );

    if(resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken( String token ) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    await _storage.delete(key: 'token');
  }
}