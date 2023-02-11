import 'dart:collection';

import 'package:contacts/usermodel.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'addPage.dart';

class fprovider extends ChangeNotifier {
  Future<AlertDialog?> beAnEnrollerAlert(
      BuildContext context, int index, String name, String phone) {
    fprovider dp = Provider.of<fprovider>(context, listen: false);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<fprovider>(builder: (context, value, child) {
            return AlertDialog(
              title: Column(
                children: [
                  Text(name),
                  Text(phone),
                ],
              ),
              backgroundColor: Colors.grey,
              contentPadding: const EdgeInsets.only(
                top: 10.0,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  value.alertbutten(
                      text: "EDIT",
                      action: () {
                        String id1 = value.modelist[index].id.toString();

                        print(id1);
                        dp.get();
                        dp.updateDocument(id1);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Contacts(
                                  from: "edit", tittle: "Edit", ids: id1),
                            ));
                      }),
                  value.alertbutten(
                      text: "DELETE",
                      action: () {
                        value.delete(value.modelist[index].id.toString());
                        value.get();

                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          });
        });
  }

  Widget alertbutten({required String text, required Function() action}) {
    return TextButton(
      onPressed: action,
      child: Container(
        color: Colors.green,
        padding: EdgeInsets.all(14),
        child: Text(
          text,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget textfeild(
      {required String hind,
      required String label,
      int? length,
      required TextInputType type,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      keyboardType: type,
      maxLength: length,
      decoration: InputDecoration(
          hintText: hind,
          helperText: "Maximum $length letters",
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }

  TextEditingController s = TextEditingController();
  String d = "";
  List<usermodel> modelist = [];
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  TextEditingController textname = TextEditingController();
  TextEditingController textphone = TextEditingController();

  void te() {
    d = s.text;
    notifyListeners();
  }

  void add({required String name, required String id}) {
    Map<String, Object> map = HashMap();
    map["name"] = textname.text;
    map["phone"] = textphone.text;
    if (name == "new") {
      fb.collection("contact").doc().set(map);
      notifyListeners();
    } else {
      fb.collection("contact").doc(id).update(map);
      notifyListeners();
    }
  }

  void get() {
    modelist.clear();
    fb.collection("contact").get().then((value) {
      for (var element in value.docs) {
        Map<dynamic, dynamic> map = element.data();

        modelist.add(usermodel(
            map["name"].toString(), map["phone"].toString(), element.id));
      }
      notifyListeners();
    });
  }

  Future<void> delete(String id) async {
    print(id);
    await fb.collection("contact").doc(id).delete();

    notifyListeners();
  }

  void updateDocument(String id) async {
    print("update");
    fb.collection("contact").doc(id).get().then((value) {
      textname.text = value.get("name").toString();
      textphone.text = value.get("phone").toString();

      notifyListeners();
    });
  }
}
