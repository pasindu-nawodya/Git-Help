import 'package:flutter/material.dart';
import 'package:githelp/screen/post/post.dart';
import '../../constant.dart';

class TopicCard extends StatelessWidget {
  final String titles;
  final int number;
  final Widget widget;
  final String desc;
  final String com;
  final String stp;
  final String id;
  const TopicCard({
    Key key,
    this.titles,
    this.number,
    this.widget,
    this.com,
    this.desc,
    this.stp,
    this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: SizedBox(
        height: 100,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onDoubleTap: (){
            print("Tapped");
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => (Post(titles,desc,stp,com,id))),
            );
          },
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 3),
                      blurRadius: 8,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 30,
                top: 25,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: 136,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        number.toString()+" )  "+titles,
                        style: kTitleTextstyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
