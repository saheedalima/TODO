import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/HomePage.dart';

void main()async{
  await Hive.initFlutter();
  Hive.openBox('todo');
}
class Add_content extends StatefulWidget {

  @override
  State<Add_content> createState() => _Add_contentState();
}

class _Add_contentState extends State<Add_content> {

  final title_controller=TextEditingController();
  final description_controller=TextEditingController();
  final Hive_Box = Hive.box('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Go to Home"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: title_controller,
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                child: Center(
                  child: TextField(
                    controller: description_controller,
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
                String titlecon= title_controller.text;
                String descriptioncon= description_controller.text;
               // List<String> text_datas=[titlecon,descriptioncon];
                //if(text_datas!=null){
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage(datas : datas)));
               // }
                create_task({'title' : titlecon,'description':descriptioncon});
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
              }, child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> create_task(Map<String, String> newtask) async{
    await Hive_Box.add(newtask);

  }

}
