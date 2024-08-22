import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:http/http.dart" as http;
import "package:learn/loginbloc/login_bloc.dart";

class AddFeedback extends StatelessWidget {
  const AddFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: TextFormField(
          controller: feedbackController,
          decoration: const InputDecoration(
            label: Text(
              "enter your feedback",
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addFeedback(feedbackController);
        },
        child: Text("submit"),
      ),
    );
  }

  Future<void> addFeedback(TextEditingController feedbackController) async {
    print(token);
    try {
      await http
          .post(
            Uri.parse("http://10.0.2.2:5000/student/auth/feedback/post"),
            body: jsonEncode(
              {"id": 1, "review": feedbackController.text},
            ),
            headers: {"Content-Type": "application/json","authorization":"Bearer $token"},
          )
          .then(
            (res) => print(
              jsonDecode(res.body)["message"],
            ),
          )
          .catchError((err) => throw err);
    } catch (err) {
      print(err);
    }
  }
}
