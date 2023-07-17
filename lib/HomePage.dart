import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:readmore/readmore.dart';
import 'package:todo/Add_content.dart';
import 'package:todo/view_task.dart';

void main()async{
  await Hive.initFlutter();
  Hive.openBox('todo');
  runApp(
    DevicePreview(enabled: !kReleaseMode,
    builder: (context) => MaterialApp(
      useInheritedMediaQuery: true, home: HomePage(),
    ), // Wrap your app
  ),);
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<Map<String,dynamic>> datas = [];
    final Hive_Box2= Hive.box('todo') ;

    @override
  void initState() {
      readTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 10),
              child: ListTile(
                leading: Icon(Icons.menu),
                title: Center(child: Text("Home",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: NetworkImage("https://images.unsplash.com/photo-1627850604058-52e40de1b847?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=873&q=80"),
                  fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text("Today's Task",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                trailing: Text("see All",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: datas.length,
                  itemBuilder: (context,index){
                    final mytask = datas[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: ()=>Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>
                            View_task(title:mytask['title'], description:mytask['description'],))),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2
                          )
                        ]
                      ),
                      height: 100,width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(mytask['title'],style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold,
                                  ),),
                                ),
                                Text(mytask['description'],
                                  // trimLines: 2,
                                  // colorClickableText: Colors.pink,
                                  // //trimMode: TrimMode.Line,
                                  // trimCollapsedText: 'Show more',
                                  // trimExpandedText: 'Show less',
                                  style: TextStyle(
                                  fontSize: 20,
                                ),)
                              ],
                            ),
                          ),
                          IconButton(onPressed: (){
                            deletetask(mytask['id']);
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Add_content()));
      },child: Icon(Icons.add),),

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.add),label: "add"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: "profile"),
      ]),
    );
  }
  void readTask() {
    final TaskFromHive = Hive_Box2.keys.map((key) {
      final values = Hive_Box2.get(key);
      return ({'id':key,'title':values['title'],'description':values['description']});
    });
    setState(() {
      datas = TaskFromHive.toList();
    });
  }

  Future<void> deletetask(id) async{
    await Hive_Box2.delete(id);
    readTask();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully deleted")));

  }


}
