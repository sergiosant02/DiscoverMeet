import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:discover_meet/main.dart';
import 'package:discover_meet/src/connections/user_connection.dart';
import 'package:discover_meet/src/utils/interface_colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  String email = '';
  String password = '';
  bool obscureText = true;
  InterfaceColors interfaceColors = InterfaceColors();
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            // Ocultar el teclado cuando se toca fuera del campo de texto
            if (_emailFocusNode.hasFocus) {
              _emailFocusNode.unfocus();
            }
            if (_passwordFocusNode.hasFocus) {
              _passwordFocusNode.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(
                  Icons.supervised_user_circle,
                  size: size.shortestSide * 0.4,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextFormField(
                    focusNode: _emailFocusNode,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'example@gmail.com',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Escribe algún email';
                      }
                      return null;
                    },
                    onChanged: (value) => email = value,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                SizedBox(
                  child: TextFormField(
                    focusNode: _passwordFocusNode,
                    obscureText: obscureText,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Escribe alguna contraseña';
                      }
                      return null;
                    },
                    onChanged: (value) => password = value,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SwitchListTile.adaptive(
                    value: !obscureText,
                    title: const Text('Mostrar contraseña'),
                    onChanged: (value) {
                      setState(() {
                        obscureText = !value;
                      });
                    }),
                SizedBox(
                  height: size.height * 0.2,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserConnection userConnection = UserConnection();
                      final res = await userConnection.login(email, password);
                      if (res.statusCode == 200) {
                        dev.log(res.headers.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Inicio correcto')),
                        );
                        pref.email = email;
                        pref.password = password;

                        if (kIsWeb) {
                          pref.token = json.decode(res.body)['token'];
                        } else {
                          pref.token = res.headers['set-cookie'] ?? '';
                        }
                        setState(() {
                          Navigator.pushNamed(context, '/home');
                        });
                      } else {
                        if (res.statusCode >= 400 && res.statusCode < 500) {
                          String error = json.decode(res.body)['message'];
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pruebe más tarde.'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(color: Color.fromRGBO(63, 35, 5, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
