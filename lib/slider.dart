import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_slider/image_slider.dart';
import 'package:policy_maker/MyHomePage.dart';
import 'package:policy_maker/animations.dart';
import 'package:policy_maker/mainPage.dart';

class ImagePage extends StatefulWidget {
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final kTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 26.0,
    height: 1.5,
  );

  @override
  void initState() {
    super.initState();
  }

  final kSubtitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    height: 1.2,
  );
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.0,
      width: isActive ? 16.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueAccent :Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/10),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 500.0,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top:40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          FadeAnimation(
                            1,
                            Container(
                              child: Image(
                                image: AssetImage('assets/insurence.png'),
                                width: 300.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            child: Center(
                              child: Text(
                                'Find the Best Insurance \n Suitable for you',
                                textAlign: TextAlign.center,
                                style: kTitleStyle,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Browse through a variety of Insurance Types, Plans and Find the one most suitable to you",
                            style: kSubtitleStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                            1,
                            Container(
                              child: Image(
                                image: AssetImage('assets/web.png'),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            child: Center(
                              child: Text(
                                ' Know its Pros and Cons',
                                style: kTitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Compare the Installments, Premium, Discounts and Plan features and Choose the most satisfying plans",
                            style: kSubtitleStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                            1,
                            Container(
                              child: Image(
                                image: AssetImage('assets/proandcons.png'),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            child: Text(
                              'Easily Share this with your loved ones',
                              style: kTitleStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            " Easily share this information with anyone \n with a click",
                            style: kSubtitleStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != _numPages - 1
                    ? Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    _pageController.animateToPage(_numPages-1, duration: Duration(microseconds: 300), curve: Curves.easeIn);
                                  },
                                  child: Icon(Icons.arrow_forward),
                                ),
                              ],
                            ),
                            //   ),
                            // ),
                          )
                        ],
                      )
                    : Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: Text('Done'),
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage()));
                          },
                          ),
                      )
                      ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
      
    );
  }
}
