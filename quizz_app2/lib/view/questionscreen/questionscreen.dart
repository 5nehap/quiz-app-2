import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizz_app2/utils/colorconstant.dart';
import 'package:quizz_app2/view/dummydb.dart';
import 'package:quizz_app2/view/resultscreen/resultscreen.dart';

class QuestionScreen extends StatefulWidget {
  final String itemname;
  const QuestionScreen({super.key, required this.itemname});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Timer _timer; // Timer variable
  int _remainingTime = 30; // Countdown time in seconds
  var itemlist = [];
  dynamic count = 0;
  int? selectedanswerindex;
  int rightAnswerCount = 0;
  

  @override
  void initState() {
    super.initState();
    items();
  }


  void items() {
    print(widget.itemname);
    if (widget.itemname == "Sports") {
      itemlist = Dummydb.SportsList;
    } else if (widget.itemname == "General Knowledge") {
      itemlist = Dummydb.GeneralknowledgeList;
    } else if (widget.itemname == "Maths") {
      itemlist = Dummydb.mathsList;
    } else if (widget.itemname == "Science ") {
      itemlist = Dummydb.ScienceList;
    } else {
      itemlist = Dummydb.technologyList;
    }
  }

  void startTimer() {
    _remainingTime = 30; // Reset the timer for each question
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          // Handle timeout: Move to the next question
          _timer.cancel();
          NextQuestion();
        }
      });
    });
  }

  void NextQuestion() {
    if (count < itemlist.length - 1) {
      setState(() {
        count++;
        selectedanswerindex = null; // Reset selected answer
        _remainingTime = 30; // Reset timer for the next question
        // startTimer(); // Restart the timer
      });
    } else {
      // Navigate to the result screen if it was the last question
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            RightanswerCount: rightAnswerCount,
          ),
        ),
      );
    }
  }
  

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: RoundedProgressBar(
        //       childLeft: Text("${percentage.toStringAsFixed(1)}%",
        //           style: TextStyle(color: Colors.white)),
        //       percent: percentage,
        //       theme: RoundedProgressBarTheme.green),
        //  actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 10),
        //       child: Text(
        //         "$currentQuest/${lastQuest - 1}",
        //         style: TextStyle(color: Colorconstant.TextWhite),
        //       ),
        //     )
        //   ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
             

            Stack(
               children: 
              [
                
              // Positioned(
                
              //     child: CircleAvatar(
                  
              //       backgroundColor: Colorconstant.primaryColor,
              //       radius: 30,
              //       child: CircularProgressIndicator(
              //         value: _remainingTime / 30,
              //         backgroundColor: Colorconstant.Containerclr,
              //         color: Colorconstant.TextWhite,
              //       ),
              //     ),
              // ),
                
                // Text(
                //   "$_remainingTime",
                //   style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //       color: Colorconstant.TextWhite),
                // ),
               ],
            
          
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        itemlist[count]["question"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colorconstant.TextWhite),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colorconstant.Containerclr, width: 5),
                      color: Colorconstant.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                itemlist[count]["options"].length,
                (index) => Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      if (selectedanswerindex == null) {
                        setState(() {
                          selectedanswerindex = index;

                          if (index == itemlist[count]["answerindex"]) {
                            rightAnswerCount++;
                          }
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: getcolor(index), width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemlist[count]["options"][index],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colorconstant.TextWhite),
                          ),
                          Icon(
                            Icons.circle_outlined,
                            color: Colorconstant.Containerclr,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (selectedanswerindex != null)
              InkWell(
                onTap: () {
                  NextQuestion();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colorconstant.Containerclr),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colorconstant.TextWhite),
                    ),
                  ),
                ),
              ),
      ],
        ),
      )
    );
    
  }
  Color getcolor(int optionIndex) {
    if (selectedanswerindex != null &&
        optionIndex == itemlist[count]["answerindex"]) {
      return Colorconstant.Green;
    }

    if (selectedanswerindex == optionIndex) {
      if (selectedanswerindex == itemlist[count]["answerindex"]) {
        return Colorconstant.Green;
      } else {
        return Colorconstant.Red;
      }
    } else {
      return Colorconstant.Containerclr;
    }
  }
}
