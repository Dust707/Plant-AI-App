import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
class ThirdPage extends StatefulWidget {
  ThirdPage({Key? key,required this.imagefile}):super(key:key);
  File imagefile;
// This widget is the root of your application.
  // async
  @override
  _ThirdPageState createState() => _ThirdPageState();
}
class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState(){
    super.initState();
    Upload();
  }
  Map<String,dynamic> results={};
  void Upload() async{
    var url='http://10.0.2.2:5000';// url exsist on every computer
    Map<String,String> headers={"Connection":"Keep-Alive","Keep-Alive":"timeout=5,max=1000"};
    http.MultipartRequest Request=http.MultipartRequest("POST",Uri.parse("$url/analyze"));
    Request.headers.addAll(headers);
    Request.files.add(await http.MultipartFile.fromPath(
        "image",
        widget.imagefile.path,
        contentType: MediaType("application","jpg")));
    Request.send().then((r) async{
      print(r.statusCode);
      if (r.statusCode==200){
        var result=await r.stream.transform(utf8.decoder).join();
        print(result);
        setState((){
          results=json.decode(result);
        }
        );
      }});
    //set state creat a varible an uses it for the app
//results=json.decode(result); decodes string in the format of a dictionary and adds it into the dictionary
  } // Map<String,String> equals to dictionary Key value pairs, no limit, asa long as there is open space in storage
  // {"Connection"<--- Thats key :"Keep-Alive"<----Thats value,"Keep-Alive":"timeout=5,max=1000"};
  // Timeout and max=1100 are all one string they are in the same qoutes. how long theapp stays connect until it times out
  // (headers) are headers= {} add on before it ship to web,
  //resuest.headers is a function.
  //Request.files.add(await http.MultipartFile.fromPath("image",widget.imagefile.path, contentType: MediaType("application","jpg")));
  //this code sends a file to sever and then it specifys the file sent in to be a JPG file.
//r.stream.transform(utf8.decoder).join();
  // this line of code sends back a coded message, this code decodes it to readable english .join combines all of teh decoded letters togather for you to read
  //results.isNotEmpty means if the result return is not emptyit will run thourgh the rest of the code
//void initState(){super.initState(); Upload(); it makes the app go right to run the the code that connects the app to the sever
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:results.isNotEmpty
    ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,))
    :Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Text ('Please hold tight while we are analyzing your soil'),
        CupertinoActivityIndicator(animating:true ,radius: 20,)

      ]
      ))

    );}}

// results.isNotEmpty means if the result return is not empty it will run thourgh all of the code inside the center with the question mark before it
// ? is an if statement and : is the out statement
// the only time we would not use ? is when we are waiting results.isNotEmpty to be = to true

