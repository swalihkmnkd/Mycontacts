import 'package:contacts/addPage.dart';
import 'package:contacts/provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fprovider dp = Provider.of<fprovider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Contacts(
                      from: "new",
                      tittle: "Add New",
                      ids: "",
                    ),
                  ));
            }),
        title: Text("Contacts"),
      ),
      body: Container(
        child: Consumer<fprovider>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: dp.modelist.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Center(child: Text("hdrt")),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                          ),
                          Column(
                            children: [
                              Text(
                                value.modelist[index].Name.toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                value.modelist[index].Phone.toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    elevation: 20,
                    color: Colors.white,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onLongPress: () {

                    String name = value.modelist[index].Name.toString();
                    String phone = value.modelist[index].Phone.toString();
                    dp.beAnEnrollerAlert(context, index, name, phone);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
