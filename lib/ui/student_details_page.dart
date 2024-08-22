import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:learn/loginbloc/login_bloc.dart";
import "package:learn/ui/display_feedback.dart";

class StudentDetailsPage extends StatelessWidget {
  const StudentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Student Details"),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is FetchDetailsState) {
            return FutureBuilder(
              future: state.getDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Name : ${snapshot.data!['name']}"),
                        Text("Department : ${snapshot.data!['department']}"),
                        Text("Year : ${snapshot.data!['year']}"),
                        Text(
                            "CGPA : ${double.parse(snapshot.data!['CPGPA'].toString()).toStringAsPrecision(2)}")
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return const Center(
                  child: Text("hello"),
                );
              },
            );
          } else {
            return const Center(
              child: Text("something went wrong"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FeedbackDisplayPage(),
            ),
          );
        },
        child: Text("feedback"),
      ),
    );
  }
}
