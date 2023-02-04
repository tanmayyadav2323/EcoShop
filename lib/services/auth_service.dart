import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/global_variables.dart';

class AuthService {
  //sign up user
  void signUpUser({
    required String email,
    required BuildContext context,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: []
      );
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Account has been created!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //sign in user
  void signInUser({
    required String email,
    required BuildContext context,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        password: password,
        address: '',
        type: '',
        name: '',
        token: '',
        cart: []
      );
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs
              .setString('x-auth-token', jsonDecode(res.body)['token'])
              .then((value) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          });
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        userProvider.setUser(userRes.body);
      }
      await http.post(Uri.parse('$uri/tokenIsValid'));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
