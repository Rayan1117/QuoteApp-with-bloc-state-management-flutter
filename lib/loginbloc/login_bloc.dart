import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

var token;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    
    on<FetchDetailsEvent>(
      (event, emit) => emit(
        FetchDetailsState(token: token),
      ),
    );
    on<LoginTriggerEvent>((event, emit) async {
      Future<int> login() async {
        if (event.formKey.currentState!.validate()) {
          print("validated");
          try {
            final response = await http
                .post(Uri.parse("http://10.0.2.2:5000/student/login"),
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode({
                      "email": event.emailController.text,
                      "password": event.passwordController.text
                    }))
                .then(
                  (data) => {jsonDecode(data.body)['message']['token']},
                )
                .catchError((err) => throw err);
            print(response.first);
            token = response.first;
            return 1;
          } catch (err) {
            print(err);
            return 0;
          }
        }
        return 0;
      }

      (await login() == 1)
          ? {
              print("logged in"),
              emit(
                LoginTriggerState(),
              ),
            }
          : print("can't log in");
    });

    on<RegisterEvent>((event, emit) async {
      Future<int> register() async {
        try {
          final response = await http
              .post(
                Uri.parse("http://10.0.2.2:5000/register"),
                headers: {"Content-Type": "application/json"},
                body: jsonEncode(
                  {
                    "user": event.usernameController.text,
                    "email": event.emailController.text,
                    "password": event.passwordController.text
                  },
                ),
              )
              .then((msg) => jsonDecode(msg.body)['message'])
              .catchError((err) => throw err);
          print(response);
          return 1;
        } catch (err) {
          print(err);
          return 0;
        }
      }

      (await register() == 1)
          ? {emit(RegisterState()), print("registered successfully")}
          : print("can't register");
    });

    on<AuthPageChangeEvent>((event, emit) {
      emit(AuthPageChangeState(wigetList: event.wigetList));
    });
    on<SliderValueChangeEvent>(
      (event, emit) => emit(SliderValueChangeState(value: event.value)),
    );
  }
}
