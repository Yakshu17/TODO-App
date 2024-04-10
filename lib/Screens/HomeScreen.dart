import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/Screens/AddTaskScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  bool isloading =true;
  List items = [];
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 15,
        backgroundColor: Colors.orange,
      ),
      body: Visibility(
        visible: isloading,
    replacement: RefreshIndicator(color: Colors.orange,
          onRefresh: fetchTodo,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final id = item['_id'] as String;
              return ListTile(
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'delete') {
                      //delete and remove the item
                      deleteById(id);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
                leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    child: Text('${index + 1}')),
                title: Text(
                  item['title'],
                  style: const TextStyle(color: Colors.blueAccent),
                ),
                subtitle: Text(
                  item['description'],
                  style: const TextStyle(color: Colors.blueAccent),
                ),
              );
            },
          ),
        ),
        child: const Center(child: CircularProgressIndicator(color: Colors.orange,),),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddTaskScreen(),
          ));
        },
        label: const Text(
          'Add Task',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
  // This Function is used to delete the task with the help of ID in random APIs.
  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      //remove item from the list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      //show error
    }
  }
//This Function is used to fetch the data from random APIs (JSON Data).
  Future<void> fetchTodo() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      //show error
    }
    setState(() {
      isloading=false;
    });
  }
}
