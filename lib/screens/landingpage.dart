import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internshiptask/main.dart';
import 'package:http/http.dart' as http;
import 'campreview.dart';

// ignore: must_be_immutable
class LandinPage extends StatefulWidget {
  var cameras = [];
  LandinPage(this.cameras);
  @override
  _LandinPageState createState() => _LandinPageState();
}

class _LandinPageState extends State<LandinPage> {
  bool ca = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(
                width: 90,
              ),
              Text(
                "Savings",
                style: GoogleFonts.varela(
                    fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pay Through UPI",
                          style: GoogleFonts.varela(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            decoration:
                                InputDecoration(hintText: "Enter UPI Number"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.grey[100],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width + 30,
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  child: CamPrev(cameras),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            minChildSize: 0.3,
            maxChildSize: 0.8,
            initialChildSize: 0.3,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    child: FutureBuilder(
                  future: getImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var url_img = snapshot.data.toString();
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        height: 10,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Search Contact",
                                        style: GoogleFonts.varela(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              suffixIcon:
                                                  Icon(Icons.book_outlined),
                                              hintText: "Select Number"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: SizedBox(
                                        height: 75,
                                        width: 75,
                                        child: Image.network(url_img),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Tony Stark",
                                          style: GoogleFonts.varelaRound(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "7897897890",
                                          style: GoogleFonts.varelaRound(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )),
              );
            },
          )
        ]));
  }

  Future<String> getImage() async {
    var url = Uri.parse('https://fakeface.rest/face/json');
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData["image_url"];
      } else {
        return 'https://www.pngitem.com/pimgs/m/627-6275734_profile-icon-contacts-hd-png-download.png';
      }
    } catch (e) {
      return 'https://www.pngitem.com/pimgs/m/627-6275734_profile-icon-contacts-hd-png-download.png';
    }
  }
}
