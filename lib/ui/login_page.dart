import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class AuthencationPage extends StatelessWidget {
  AuthencationPage({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void validateSignUp() async {
    if (formKey.currentState!.validate()) {
      print("validated");
      try {
        final response = await http
            .get(
              Uri.parse("http://10.0.2.2:5000/"),
            )
            .then(
              (data) => jsonDecode(data.body)['message'],
            )
            .catchError((err) => throw err);
        print(response);
      } catch (err) {
        print(err);
      }
    }
  }

  void register() async {
    try {
      final response = await http
          .post(Uri.parse("http://10.0.2.2:5000/register"),
              headers: {"Content-Type": "application/json"},
              body: jsonEncode({
                "user": _userController.text,
                "email": _emailController.text,
                "password": _passwordController.text
              }))
          .then((msg) => jsonDecode(msg.body)['message'])
          .catchError((err) => throw err);
      print(response);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                customTextField(_userController, "Username",
                    validator: (val) =>
                        (val!.trim().isEmpty) ? "must enter the email" : null),
                customTextField(_emailController, "Email",
                    validator: (val) =>
                        (val!.trim().isEmpty) ? "must enter the email" : null),
                customTextField(_passwordController, "Password",
                    validator: (val) => (val!.trim().isEmpty)
                        ? "must enter the password"
                        : null,
                    isObscure: true),
                ElevatedButton(
                    onPressed: validateSignUp, child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(TextEditingController controller, String label,
          {required Function(String? value) validator,
          bool isObscure = false}) =>
      Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          obscureText: isObscure,
          controller: controller,
          validator: (value) {
            validator(value);
            return null;
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(label),
          ),
        ),
      );
}
