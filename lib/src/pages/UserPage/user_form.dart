import 'package:discover_meet/src/custom_widgets/app_bar_discover.dart';
import 'package:discover_meet/src/models/genre_enum.dart';
import 'package:discover_meet/src/models/user_model.dart';
import 'package:discover_meet/src/utils/interface_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/page_provider.dart';

class UserForm extends StatefulWidget {
  UserForm({super.key, required this.user});
  UserModel user;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Genre selectedValueGenre = Genre.MALE;
  String passwordConfirmation = "";

  @override
  void initState() {
    super.initState();
    if (widget.user.genre != selectedValueGenre) {
      selectedValueGenre = widget.user.genre;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageProvider _pageProvider = Provider.of<PageProvider>(context);

    return Scaffold(
      appBar: AppBarDiscover.build(context, false),
      backgroundColor: InterfaceColors.backgroundColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.user.firstName,
                decoration: InputDecoration(
                    labelText: 'Nombre', border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.user.firstName = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                //controller: lastNameController,
                initialValue: widget.user.lastName,
                decoration: InputDecoration(
                    labelText: 'Apellido', border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu apellido';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.user.lastName = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                //controller: emailController,
                initialValue: widget.user.email,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu email';
                  }
                  if (!isValidEmail(value)) {
                    return 'Ingresa un email válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.user.email = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                //controller: phoneController,
                initialValue: widget.user.phone,
                decoration: InputDecoration(
                    labelText: 'Teléfono', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu teléfono';
                  }
                  if (!isValidPhoneNumber(value)) {
                    return 'Ingresa un número de teléfono válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.user.phone = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: selectedValueGenre,
                items: dropdownItemsGenre,
                validator: (value) {
                  if (value == null) {
                    return "Debes especificar un género";
                  }
                  return null;
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedValueGenre = value;
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                //controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Contraseña', border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  if (value!.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.user.password = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                //controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'Confirmación de contraseña',
                    border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu contraseña';
                  }
                  if (value!.length < 8) {
                    return 'La contraseña debe tener al menos 8 caracteres';
                  }
                  if (passwordConfirmation != widget.user.password) {
                    return "Las contraseñas deben coincidir";
                  }
                  return null;
                },
                onSaved: (value) {
                  passwordConfirmation = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si el formulario es válido, guarda los valores
                    _formKey.currentState!.save();

                    // Realiza cualquier acción necesaria con los datos aquí
                    // Por ejemplo, puedes enviarlos al servidor o hacer algo más.

                    // Luego, puedes redirigir o mostrar un mensaje de éxito, etc.
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidPhoneNumber(String phone) {
    // Expresión regular para validar números de teléfono
    // Acepta formatos como (123) 456-7890, 123-456-7890, 123.456.7890, 1234567890, +31636363634, etc.
    // Puedes ajustar esta expresión regular según tus necesidades específicas.
    final RegExp phoneRegExp = RegExp(
      r'^(?:\+?\d{1,3})?(?:[.-]?\d{3})+[.-]?\d{4}$',
    );

    return phoneRegExp.hasMatch(phone);
  }

  bool isValidEmail(String email) {
    // Expresión regular para validar direcciones de correo electrónico
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    );

    return emailRegExp.hasMatch(email);
  }

  List<DropdownMenuItem<Genre>> get dropdownItemsGenre {
    List<DropdownMenuItem<Genre>> menuItems = [
      const DropdownMenuItem(child: Text("Hombre"), value: Genre.MALE),
      const DropdownMenuItem(child: Text("Mujer"), value: Genre.FEMALE),
    ];
    return menuItems;
  }
}
