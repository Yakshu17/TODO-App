import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/Screens/HomeScreen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Add Todo',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.orange,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: titlecontroller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 150,
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    controller: descriptioncontroller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 55,
                  width: 400,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: submitdata,
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          )),
    );
  }

// This Function is used to submit the user data to the API on Server.
  Future<void> submitdata() async {
    // 1.)Get the data from form in app
    final title = titlecontroller.text;
    final description = descriptioncontroller.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    // 2.)submit Data to the server
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // 3.)how success or fail message based on the status.
    if (response.statusCode == 201) {
      final snackBar = SnackBar(
        content: const Text('Creation Successful'),
        backgroundColor: (Colors.orange),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      final errorsnackBar = SnackBar(
        content: const Text('Creation Failed'),
        backgroundColor: (Colors.redAccent),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(errorsnackBar);
    }
    titlecontroller.clear();
    descriptioncontroller.clear();
  }
}
