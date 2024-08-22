import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:learn/ui/add_feedback.dart";

class FeedbackDisplayPage extends StatelessWidget {
  const FeedbackDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>const AddFeedback()));
              },
              icon: Icon(Icons.add))
        ],
        title: Text("Feedback"),
      ),
      body: FutureBuilder(
        future: getFeedbacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!["message"].length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text( snapshot.data!["message"][index]["name"]),
                  subtitle: Text(
                    snapshot.data!["message"][index]["feedback"],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getFeedbacks() async {
    final response = await http
        .get(Uri.parse("http://10.0.2.2:5000/student/feedback/getAll"));
    if (response.statusCode == 200) {
      print("response got");
      return jsonDecode(response.body);
    } else {
      return {};
    }
  }
}
