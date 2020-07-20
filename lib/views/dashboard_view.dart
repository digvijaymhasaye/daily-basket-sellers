import 'dart:ui';

import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static final List<String> imgList = [
    // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  // final List<Widget> imageSliders = imgList
  //     .map((item) => Container(
  //           child: Container(
  //             margin: EdgeInsets.all(5.0),
  //             child: Container(
  //               color: Colors.red,
  //               height: MediaQuery.of(context).size.height / 2,
  //               width: MediaQuery.of(context).size.width,
  //               child: BezierChart(
  //                 bezierChartScale: BezierChartScale.CUSTOM,
  //                 xAxisCustomValues: const [0, 3, 10, 15, 20, 25, 30, 35],
  //                 series: const [
  //                   BezierLine(
  //                     label: "Custom 1",
  //                     data: const [
  //                       DataPoint<double>(value: 10, xAxis: 0),
  //                       DataPoint<double>(value: 130, xAxis: 5),
  //                       DataPoint<double>(value: 50, xAxis: 10),
  //                       DataPoint<double>(value: 150, xAxis: 15),
  //                       DataPoint<double>(value: 75, xAxis: 20),
  //                       DataPoint<double>(value: 0, xAxis: 25),
  //                       DataPoint<double>(value: 5, xAxis: 30),
  //                       DataPoint<double>(value: 45, xAxis: 35),
  //                     ],
  //                   ),
  //                   BezierLine(
  //                     lineColor: Colors.blue,
  //                     lineStrokeWidth: 2.0,
  //                     label: "Custom 2",
  //                     data: const [
  //                       DataPoint<double>(value: 5, xAxis: 0),
  //                       DataPoint<double>(value: 50, xAxis: 5),
  //                       DataPoint<double>(value: 30, xAxis: 10),
  //                       DataPoint<double>(value: 30, xAxis: 15),
  //                       DataPoint<double>(value: 50, xAxis: 20),
  //                       DataPoint<double>(value: 40, xAxis: 25),
  //                       DataPoint<double>(value: 10, xAxis: 30),
  //                       DataPoint<double>(value: 30, xAxis: 35),
  //                     ],
  //                   ),
  //                   BezierLine(
  //                     lineColor: Colors.black,
  //                     lineStrokeWidth: 2.0,
  //                     label: "Custom 3",
  //                     data: const [
  //                       DataPoint<double>(value: 5, xAxis: 0),
  //                       DataPoint<double>(value: 10, xAxis: 5),
  //                       DataPoint<double>(value: 35, xAxis: 10),
  //                       DataPoint<double>(value: 40, xAxis: 15),
  //                       DataPoint<double>(value: 40, xAxis: 20),
  //                       DataPoint<double>(value: 40, xAxis: 25),
  //                       DataPoint<double>(value: 9, xAxis: 30),
  //                       DataPoint<double>(value: 11, xAxis: 35),
  //                     ],
  //                   ),
  //                 ],
  //                 config: BezierChartConfig(
  //                   verticalIndicatorStrokeWidth: 2.0,
  //                   verticalIndicatorColor: Colors.black12,
  //                   showVerticalIndicator: true,
  //                   contentWidth: MediaQuery.of(context).size.width * 2,
  //                   backgroundColor: Colors.red,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ))
  //     .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          // autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        items: imgList
                            .map((item) => Container(
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: Container(
                                      color: Colors.red,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      width: MediaQuery.of(context).size.width,
                                      child: BezierChart(
                                        bezierChartScale:
                                            BezierChartScale.CUSTOM,
                                        xAxisCustomValues: const [
                                          0,
                                          5,
                                          10,
                                          15,
                                          20,
                                        ],
                                        series: const [
                                          BezierLine(
                                            label: "Custom 1",
                                            data: const [
                                              DataPoint<double>(
                                                  value: 10, xAxis: 0),
                                              DataPoint<double>(
                                                  value: 130, xAxis: 5),
                                              DataPoint<double>(
                                                  value: 50, xAxis: 10),
                                              DataPoint<double>(
                                                  value: 150, xAxis: 15),
                                              DataPoint<double>(
                                                  value: 75, xAxis: 20),
                                            ],
                                          ),
                                          BezierLine(
                                            lineColor: Colors.blue,
                                            lineStrokeWidth: 2.0,
                                            label: "Custom 2",
                                            data: const [
                                              DataPoint<double>(
                                                  value: 5, xAxis: 0),
                                              DataPoint<double>(
                                                  value: 50, xAxis: 5),
                                              DataPoint<double>(
                                                  value: 30, xAxis: 10),
                                              DataPoint<double>(
                                                  value: 30, xAxis: 15),
                                              DataPoint<double>(
                                                  value: 50, xAxis: 20),
                                            ],
                                          ),
                                          BezierLine(
                                            lineColor: Colors.black,
                                            lineStrokeWidth: 2.0,
                                            label: "Custom 3",
                                            data: const [
                                              DataPoint<double>(
                                                  value: 5, xAxis: 0),
                                              DataPoint<double>(
                                                  value: 10, xAxis: 5),
                                              DataPoint<double>(
                                                  value: 35, xAxis: 10),
                                              DataPoint<double>(
                                                  value: 40, xAxis: 15),
                                              DataPoint<double>(
                                                  value: 40, xAxis: 20),
                                            ],
                                          ),
                                        ],
                                        config: BezierChartConfig(
                                          verticalIndicatorStrokeWidth: 2.0,
                                          verticalIndicatorColor:
                                              Colors.black12,
                                          showVerticalIndicator: true,
                                          contentWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              2,
                                          backgroundColor: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Pending Orders',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 200.0,
                        padding: EdgeInsets.all(10.0),
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: EdgeInsets.all(5.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Items',
                                              style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '11',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'Amount',
                                              style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              '₹ 1342',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 150,
                                          child: VerticalDivider(
                                            thickness: 0.8,
                                            width: 1.0,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Digvijay Mhasaye',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              'Placed 30 minutes ago',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              // 'Expected to be delivered\non or before 2020-06-24',
                                              'Expected to be delivered\nin 30 minutes',
                                              maxLines: 2,
                                              overflow: TextOverflow.clip,
                                              // textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Recently Ordered Products',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 200.0,
                        // padding: EdgeInsets.all(10.0),
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          padding: const EdgeInsets.all(10),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 1,
                          children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[100],
                                child: Stack(children: [
                                  Image.network(
                                    'https://www.nescafe.com/sites/g/files/dzyqzn2211/files/styles/product_recommendation_large/public/2020-04/NESCAF%C3%89%20Classic_0.png?itok=7DZzsiFl',
                                  ),
                                  Positioned.fill(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 3,
                                        sigmaY: 3,
                                      ),
                                      child: Container(
                                        color: Colors.black.withOpacity(0),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Product name',
                                        style: TextStyle(
                                            letterSpacing: 0.5,
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        'Ordered quantity: 3000',
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Available quantity: 4000',
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ])),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Text('Heed not the rabble'),
                              color: Colors.teal[200],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Text('Sound of screams but the'),
                              color: Colors.teal[300],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Text('Who scream'),
                              color: Colors.teal[400],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Text('Revolution is coming...'),
                              color: Colors.teal[500],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: const Text('Revolution, they...'),
                              color: Colors.teal[600],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
