import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/Screens/AddTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 40,
        backgroundColor: Colors.black54,
      ),
      body: Container(
        color: Colors.black38,
      ),
      floatingActionButton: FloatingActionButton.extended(backgroundColor: Colors.black54,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTaskScreen(),));
        },
        label: Text('Add Task',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
