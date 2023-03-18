import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'dart:io';
import 'dart:async';
import 'Thrid_FLower_Picker.dart'; // 'Import'  You can import any file made for flutter

class SecondPage extends StatefulWidget {
  SecondPage({Key? key}):super(key:key);

// This widget is the root of your application.
@override
_SecondPageState createState() => _SecondPageState();
}
class _SecondPageState extends State<SecondPage> {
  File? ImageFlower;
  //? is used for to make varable that is not allowed left empty to be left empty for future changes to the varable,
  // ! is used for the exact oppsite, It makes a varable that would normally be allowed to be left empty to not be left out

  final ImagePicker picker = ImagePicker(); //final means the items from the libary will never change it wont replace if tried to replace the terminal will show error
//await and async works together to make the code wait for user to pick image and then continue
  void ImagesOfFlower(ImageSource source ) async{
    PickedFile? FlowerFile = await picker.getImage(source:source);
    setState((){
      ImageFlower = File(FlowerFile!.path); // ImageFlower is the Image that was selected
    });
  }

  @override
  Widget build(BuildContext context){
return Scaffold(
    body:ImageFlower!=null //'!=' means it is not equal to
                          // null means it is nothing or non exsistent
                         // combo of both makes the code run through the bottom portion if there is a image to go on with
    ?Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
        ElevatedButton(  // this button goes to the third page where the soil get analyzed
           onPressed:(){
              Navigator.push(
                context,CupertinoPageRoute( //CupertinoPageRoute connects and make the second page to third page
                  builder:(context)=> ThirdPage(imagefile:ImageFlower!)
              )
         );
        },
        child: Text('Analyze Soil')
    )]))
    :Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            ElevatedButton(
                onPressed:(){ImagesOfFlower(ImageSource.gallery);},
                  child: Text('Select Image')
                )
          ]))

    );}}

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
// body is start for a widget
// widget is either colum(inft) or a contanier(1)
//you can have many chirldern inside of one main child?
// use backslash for special characters
// style: TextStyle(fontSize: N),
//everthing is behind body: what ever the thing is (center maybe)
//final String foo = word add this to whaterver you want kind of like copy and paste $foo
