import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';


class Youtube extends StatefulWidget {
  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.orangeAccent),
              onPressed: (){
                Navigator.of(context).pop();
              }),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text("Recommended",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),textAlign: TextAlign.left,),
        ),
      body: Center( child: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              _vidframe(context,'assets/images/workout.jpg',
                  "https://youtu.be/CYD7f5b_qj4","20 MIN HOME WORKOUT"),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0,0.0, 10.0),),
              _vidframe(context,'assets/images/food.jpg',
                  "https://youtu.be/17GrPDnYt6E","Healthy Eating - Portion Control"),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0,0.0, 10.0),),
              _vidframe(context,'assets/images/sleep.jpg',
                  "https://youtu.be/fk-_SwHhLLc","Sleep Hygiene"),
              Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0,0.0, 10.0),),
              _vidframe(context,'assets/images/case.jpg',
                  "https://youtu.be/WtuXrrEZsAg","Healthcare in Singapore"),
            ],
          ),)
      ),
      )
    );
  }
  Widget _vidframe(BuildContext context,String img,String vid,String txt){
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height*0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey,
        ),
        child: Stack(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.3,
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(img,
                    fit: BoxFit.cover,),
                )),
            Positioned(
              child:
              Text(txt,style: TextStyle(
                fontSize: 20.0,color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),bottom: 7.0,left: 7.0,),
            Positioned(
              child: Icon(Icons.ondemand_video,color: Colors.white,
                size: 30.0,),
              bottom: 80.0,
              right: 150.0,
            )
          ],
        ),
      ),
      onTap: () {
        FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyD807BrBYfzVKSJqJlX2KBs02UkjXzLMIY",
          videoUrl: vid,
          autoPlay: true,
        );
      },
    );
  }
}

