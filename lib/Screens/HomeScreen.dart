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
  @override
  List items =[];
  void initState() {
    super.initState();
    fetchTodo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 40,
        backgroundColor: Colors.black54,
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: ListView.builder(
          itemCount: items.length,
            itemBuilder: (context,index){
            final item=items[index];
            final id =item['_id'] as String;
            return ListTile(
              trailing: PopupMenuButton(onSelected: (value){
                if(value =='edit'){
                  //open edit page
                  navigatetoeditpage(item);
                }
                else if(value == 'delete'){
                  //delete and remove the item
                  deleteById(id);
                }
              },
                itemBuilder:(context) {
                return [
                  PopupMenuItem(child: Text('Edit'),value: 'edit',),
                  PopupMenuItem(child: Text('Delete'),value: 'delete',),

                ];
              },),
        leading: CircleAvatar(child: Text('${index+1}')),
              title: Text(item['title']),
        subtitle: Text(item['description']),
            );

            },
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(backgroundColor: Colors.black54,
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTaskScreen(),));
        },
        label: const Text('Add Task',style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Future<void> deleteById(String id) async {
    final url ='https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response =await http.delete(uri);
    if(response.statusCode ==200){
      //remove item from the list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items=filtered;
      });
    }
    else{
      //show error
    }
  }

  void navigatetoeditpage(Map item){
    final route= MaterialPageRoute(builder: (context) => AddTaskScreen(),);
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    else {

    }
  }
}
