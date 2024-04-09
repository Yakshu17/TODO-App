import'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      title: Text('Add Todo',style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.black54,
    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30,),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black54,
            ),
                onPressed: (){},
                child:Text('Submit',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      )
    );
  }
}
