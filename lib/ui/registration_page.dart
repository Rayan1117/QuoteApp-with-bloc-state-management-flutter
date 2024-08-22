import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:learn/loginbloc/login_bloc.dart";
import "package:learn/ui/student_detail_querying_page.dart";
import "package:learn/ui/student_details_page.dart";

class AuthencationPage extends StatefulWidget {
  const AuthencationPage({super.key});

  Widget customTextField(TextEditingController controller, String label,
          {required Function(String? value) validator,
          bool isObscure = false}) =>
      Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          obscureText: isObscure,
          controller: controller,
          validator: (value) {
            return validator(value);
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(label),
          ),
        ),
      );

  @override
  State<AuthencationPage> createState() => _AuthencationPageState();
}

class _AuthencationPageState extends State<AuthencationPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(
      AuthPageChangeEvent(
        wigetList: registrationPage(context),
      ),
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _userController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Form(
            key: formKey,
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginTriggerState) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StudentDetailsPage(),
                    ),
                  );
                  BlocProvider.of<LoginBloc>(context).add(FetchDetailsEvent());
                }
                if (state is RegisterState) {
                  print("bruh");
                  try {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudentQueryPage(),
                      ),
                    );
                  } catch (err) {
                    print(err);
                  }
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: (state is AuthPageChangeState)
                      ? state.wigetList
                      : const [
                          Text(
                            'data',
                          ),
                        ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> registrationPage(BuildContext context) => [
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Sign Up",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 50,
        ),
        widget.customTextField(_userController, "Username",
            validator: (val) =>
                (val!.trim().isEmpty) ? "must enter the email" : null),
        widget.customTextField(_emailController, "Email",
            validator: (val) =>
                (val!.trim().isEmpty) ? "must enter the email" : null),
        widget.customTextField(_passwordController, "Password",
            validator: (val) =>
                (val!.trim().isEmpty) ? "must enter the password" : null,
            isObscure: true),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(
              RegisterEvent(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  formKey: formKey,
                  usernameController: _userController),
            );
          },
          child: const Text("Sign Up"),
        ),
        TextButton(
          onPressed: () => {
            _emailController.clear(),
            _passwordController.clear(),
            _userController.clear(),
            BlocProvider.of<LoginBloc>(context).add(
              AuthPageChangeEvent(
                wigetList: loginPage(context),
              ),
            ),
          },
          child: const Text("I already have an account"),
        ),
      ];

  List<Widget> loginPage(BuildContext context) => [
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Login",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 50,
        ),
        widget.customTextField(_emailController, "Email",
            validator: (val) =>
                (val!.trim().isEmpty) ? "must provide email" : null),
        widget.customTextField(_passwordController, "Password",
            validator: (val) =>
                (val!.trim().isEmpty) ? "must provide email" : null),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(LoginTriggerEvent(
                emailController: _emailController,
                passwordController: _passwordController,
                formKey: formKey));
          },
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () {
            _emailController.clear();
            _passwordController.clear();
            BlocProvider.of<LoginBloc>(context).add(
              AuthPageChangeEvent(
                wigetList: registrationPage(context),
              ),
            );
          },
          child: const Text("i don't have an account"),
        ),
      ];
}
