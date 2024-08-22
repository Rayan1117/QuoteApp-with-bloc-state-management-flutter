part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class AuthPageChangeState extends LoginState {
  final List<Widget> wigetList;

  AuthPageChangeState({required this.wigetList});
}

final class LoginTriggerState extends LoginState {}

final class FetchDetailsState extends LoginState {
  final String token;
  Future<Map<String, dynamic>> getDetails() async {
    try {
      final response = await http
          .get(
            Uri.parse("http://10.0.2.2:5000/student/auth/getDetails"),
            headers: {"authorization":"Bearer $token","Content-Type":"application/json"}
          )
          .then((data) => jsonDecode(data.body)['message'][0])
          .catchError((err) => {throw err});
      return response;
    } catch (err) {
      print(err);
      return {"message": "something went wrong"};
    }
  }

  FetchDetailsState({required this.token});
}

final class RegisterState extends LoginState{

}

final class SliderValueChangeState extends LoginState{
  final double value;

  SliderValueChangeState({required this.value});
}