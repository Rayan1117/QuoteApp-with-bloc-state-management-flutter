import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/loginbloc/login_bloc.dart';
import 'package:learn/ui/registration_page.dart';

class StudentQueryPage extends StatelessWidget {
  StudentQueryPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final AuthencationPage field = const AuthencationPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Query"),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                field.customTextField(nameController, "Student Name",
                    validator: (val) =>
                        (val!.trim().isEmpty) ? "Name must be entered" : null),
                field.customTextField(deptController, "Department",
                    validator: (val) => (val!.trim().isEmpty)
                        ? "Department field must be filled"
                        : null),
                DropdownButton<String>(
                  value: "1st year",
                  items: const [
                    DropdownMenuItem(
                      value: "1st year",
                      child: Text("1st year"),
                    ),
                    DropdownMenuItem(
                      value: "2nd year",
                      child: Text("2nd year"),
                    ),
                    DropdownMenuItem(
                      value: "3rd year",
                      child: Text("3rd year"),
                    ),
                    DropdownMenuItem(
                      value: "4th year",
                      child: Text("4th year"),
                    ),
                  ],
                  onChanged: (String? val) => print(val),
                ),
                Slider(

                  min: 0,
                  max: 10,
                  divisions: 100,
                  onChanged: (val) => BlocProvider.of<LoginBloc>(context)
                      .add(SliderValueChangeEvent(value: val)),
                  value: (state is SliderValueChangeState) ? state.value : 0,
                ),
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) => BlocProvider.of<LoginBloc>(context)
                      .add(SliderValueChangeEvent(value: double.parse(value),),),
                  decoration: InputDecoration(
                    label: Text("CGPA"),
                  ),
                )
              ], 
            ),
          );
        },
      ),
    );
  }
}
