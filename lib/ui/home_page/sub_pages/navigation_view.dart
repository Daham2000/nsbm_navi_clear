import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nsbm_navi_clear/theme/styled_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:nsbm_navi_clear/db/location_api.dart';

import '../../root_page/root_bloc.dart';
import '../../root_page/root_state.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

String fromWhere = "";

class _NavigationViewState extends State<NavigationView> {

  @override
  void initState() {
    super.initState();
  }
  String _fromWhere = "";
  String _toWhere = "";

  showMsg(String toWhere){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Navigation is not available for ${toWhere}."),
      backgroundColor: StyledColor.blurPrimary,
    ));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<RootBloc, RootState>(
      buildWhen: (pre, current) =>
          pre.toWhere != current.toWhere ||
          pre.toWhereList != current.toWhereList ||
          pre.fromWhereList != current.fromWhereList,
      builder: (context, state) {
        if (_fromWhere == "") {
          _fromWhere = state.fromWhereList[0];
          _toWhere = state.toWhereList[0];
        }
        if (state.toWhere != "") {
          if (state.toWhereList.contains(state.toWhere)) {
            _toWhere = state.toWhere;
          }else{
            Future.delayed(Duration.zero, () async {
              showMsg(state.toWhere);
            });
          }
        }
        return ListView(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                    child: Text(
                      "From where:",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 40,
                  child: DropdownButton<String>(
                    value: _fromWhere,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromWhere = newValue!;
                      });
                    },
                    items: state.fromWhereList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
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
                    child: DropdownButton<String>(
                      value: _toWhere,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          _toWhere = newValue!;
                        });
                      },
                      items: state.toWhereList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (_fromWhere != "") {
                  final doc =
                      await LocationApi().getNavigation(_fromWhere, _toWhere);
                  if (doc != null) {
                    await launch(doc['vImage']);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Navigation is not available...'),
                      backgroundColor: StyledColor.blurPrimary,
                    ));
                  }
                } else {
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
          ],
        );
      },
    );
  }
}
