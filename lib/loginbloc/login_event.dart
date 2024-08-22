part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class AuthPageChangeEvent extends LoginEvent {
  final List<Widget> wigetList;

  AuthPageChangeEvent({required this.wigetList});
}

final class LoginTriggerEvent extends LoginEvent {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  LoginTriggerEvent(
      {required this.emailController,
      required this.passwordController,
      required this.formKey});
}

final class RegisterEvent extends LoginEvent {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final GlobalKey<FormState> formKey;
  RegisterEvent(
      {required this.emailController,
      required this.passwordController,
      required this.formKey,
      required this.usernameController});
}

final class FetchDetailsEvent extends LoginEvent{
  
}

final class SliderValueChangeEvent extends LoginEvent{
  final double value;

  SliderValueChangeEvent({required this.value});
  
}