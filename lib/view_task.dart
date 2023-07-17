import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main()async{
  await Hive.initFlutter();
  Hive.openBox('todo');
}

class View_task extends StatefulWidget {

  String? title;
  String? description;
  View_task({required this.title,required this.description});

  @override
  State<View_task> createState() => _View_taskState();
}

class _View_taskState extends State<View_task> {

  final Hive_Box3= Hive.box('todo') ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              Text('${widget.title}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8),
                child: Text('${widget.description}',style: TextStyle(fontSize: 15),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
