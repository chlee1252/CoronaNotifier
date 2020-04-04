import 'package:CoronaNotifier/helper/detailInfo.dart';
import 'package:flutter/material.dart';

import '../service/stateDetail.dart';
import '../geoAPI/myAPI.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({this.title});

  final title;
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List data;
  List filteredData;
  String title;
  var _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.title = widget.title;
    _getData().then((d) {
      setState(() {
        this.data = d;
        this.filteredData = this.data;
      });
    });
  }

  Future<List> _getData() async {
    final String url = detail_url + "/${this.title}";
    var detail;
    try {
      detail = StateDetail(url: url);
      await detail.getDetailData();
    } catch (e) {
      return [];
    }

    return detail.detailData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            this.title,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(220, 220, 220, 1.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(220, 220, 220, 1.0)),
                      ),
                      contentPadding: EdgeInsets.all(15.0),
                      hintText: 'Search',
                    ),
                    onChanged: (string) {
                      setState(() {
                        this.filteredData = this
                            .data
                            .where((u) => (u.county
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      });
                    },
                  ),
                  IconButton(
                    color: Color.fromRGBO(220, 220, 220, 1.0),
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _textController.clear();
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      setState(() {
                        this.filteredData = this.data;
                      });
                    },
                  ),
                ],
              ),
              this.data == null
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ),
                      ),
                    )
                  : Expanded(
                      child: NotificationListener(
                        onNotification: (t) {
                          if (t is UserScrollNotification) {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          }
                          return true;
                        },
                        child: Scrollbar(
                          child: ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Container(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                  child: Center(
                                      child: Text(
                                          'Updated: ${this.data[0].date}')),
                                );
                              }
                              final current = this.filteredData[index - 1];
                              return Container(
                                height: 100.0,
                                child: Card(
                                  color: Color.fromRGBO(220, 220, 220, 1.0),
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        current.county,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.5,
//                              fontWeight: FontWeight.bold,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: current.active.toString(),
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              TextSpan(text: ' | '),
                                              TextSpan(
                                                  text:
                                                      current.death.toString()),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 0.0,
                                color: Colors.white,
                              );
                            },
                            itemCount: this.filteredData.length + 1,
                          ),
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
