
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier{
  final baseUrl = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:');
  final String key = 'AIzaSyAmECf6L59FbLZGkIL8cLq-Q6KFo1d6pX4';

  String? _userId;
  String? _token;

  String? get user{
    return _userId;
  }

  String? get token{
    return _token;
  }

  Future<void> manageAuth(email, password, action) async {
    try{
      final response = await http.post (
        Uri.parse('$baseUrl$action?key=$key'), 
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;

      if(response.statusCode != 200){
        if(decoded['error']['message'] == 'EMAIL_EXISTS'){
          throw Exception('Email já cadastrado');
        }else if (decoded['error']['message'] == 'INVALID_EMAIL'){
          throw Exception('Email inválido');
        }else if (decoded['error']['message'] == 'WEAK_PASSWORD'){
          throw Exception('Senha muito fraca');
        }else if (decoded['error']['message'] == 'EMAIL_NOT_FOUND'){
          throw Exception('Email não encontrado');
        }else if (decoded['error']['message'] == 'INVALID_PASSWORD'){
          throw Exception('Senha inválida');
        }
      }

      if(kDebugMode){
        print(response.statusCode);
        print(response.body);
      }

      if(response.statusCode == 200 && action == 'signInWithPassword'){
        if(kDebugMode){
        print(decoded);
      }
        _userId = decoded['idUser'];
        _token = decoded['idToken'];
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void logout(){
    _userId = null;
    _token = null;
    notifyListeners();
  }
}