import 'package:flutter/material.dart';

import 'fetch.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CourseListScreen(),
    );
  }
}

class CourseListScreen extends StatefulWidget {

  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  List<String> tabs = [
    "All",
    "Photography",
    "Graphic Design",
    "Web Development",
  ];
  int current = 0;

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return 78;
      case 2:
        return 192;
      case 3:
        return 263;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return 50;
      case 1:
        return 80;
      case 2:
        return 50;
      case 3:
        return 50;
      default:
        return 0;
    }
  }
  late Future<ApiResponse> futureApiResponse;

  @override
  void initState() {
    super.initState();
    futureApiResponse = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0,
      backgroundColor: Colors.white,
        leading: const Icon(Icons.menu,color: Colors.black,size: 30,),
        title:const Center(child: Text('COURSES',style: TextStyle(color: Colors.black),)) ,
        actions: [const Padding(
          padding: EdgeInsets.only(right: 15),
          child: CircleAvatar(
  radius: 25, // set the radius of the avatar
  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUSGvxp_PqJleI4QYw0SaYvUYuBOBU0sI32uC79QlqNtwTEy43qvP8UZj2KyAMl9oYCCk&usqp=CAU'), // set the image of the avatar
),
        )],
      ),
      backgroundColor: Colors.white,
      body:
Stack(
          children:[
      
             Padding(
               padding: const EdgeInsets.only(top: 5),
               child: Container(
                child: Column(
      
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 45),
                      
                      child: Text("nafisa sulthana!",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white,fontSize: 30),),
                    ),
                    Center(
                      child: Text("   Continue your lesson or do you want to ",
                      style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 18)),
                    ), Center(
                      child: Text("   learn something new  ",
                      style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 18)),
                    ),
                  
                  ],
                ),
            height: 400,
            width: size.width,
            decoration: BoxDecoration(color: Color.fromARGB(122, 148, 30, 233),borderRadius: BorderRadius.circular(35)),
          ),
             ),



      Align(
          alignment: Alignment.topCenter,
      child:
       Padding(
         padding: const EdgeInsets.only(top: 190),
          child: Container(
        child: Center(child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Find your lesson",style: TextStyle(color: Color.fromARGB(230, 158, 158, 158)),),
                ),
             //  const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(left: 90,),
                  child: Card(child: Icon(Icons.search),color: Colors.amber,),
                ),
              ],
            ),
          ),
        )),
        
        height: 50,
              width: 310,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
            ),
           ),
           ),
          
           
       Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 240),
          child: Container(
            child: Container(height: 500,width: 500,decoration: 
            BoxDecoration(borderRadius: BorderRadius.circular(35),color: Colors.white
            ),
              child: FutureBuilder<ApiResponse>(
                future: futureApiResponse,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                     child: ListView.builder(
                        itemCount: snapshot.data!.courses.length,
                        itemBuilder: (context, index) {
                          Course course = snapshot.data!.courses[index];
                          return ListTile(
                            title: Text(course.title),
                            
                            subtitle: Text(course.description),
                          leading: Container(height: 150,width:80,
                          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://cdn.pixabay.com/photo/2014/02/27/16/10/tree-276014_960_720.jpg"),
                fit: BoxFit.cover,
              ),
                          )
                           ) );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
          
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    ]));
  }
}
