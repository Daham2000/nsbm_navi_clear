import 'package:nsbm_navi_clear/theme/styled_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/db/location_api.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

String fromWhere = "";

class _NavigationViewState extends State<NavigationView> {

  final TextEditingController _fromWhereController = TextEditingController();
  final TextEditingController _toWhereController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _fromWhereController.text = fromWhere;
    return ListView(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 120,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                child: Text(
                  "From where:",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 40,
              child: TextField(
                controller: _fromWhereController,
                  decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.8),
                ),
              )),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 120,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child: Text(
                    "To where:",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 40,
                child: TextField(
                    controller: _toWhereController,
                    decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 0.8),
                  ),
                )),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () async {
            if(_fromWhereController.text!=""){
              final doc = await LocationApi().getNavigation(_fromWhereController.text,"002");
              if(doc!=null){
                await launch(doc['vImage']);
              }
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('From where is not selected...'),
                backgroundColor: StyledColor.blurPrimary,
              ));
            }

          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.navigation),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height * 0.55,
        //   child: const WebView(
        //     initialUrl: 'https://app.togotiki.com/channel/treatwood/media/GS__5864',
        //   ),
        // )
      ],
    );
  }
}
