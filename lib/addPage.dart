import 'package:contacts/contacts.dart';
import 'package:contacts/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contacts extends StatelessWidget {
  String? from;
  String? tittle;
  String? ids;

  Contacts(
      {Key? key, required this.from, required this.tittle, required this.ids})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    fprovider dp = Provider.of<fprovider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Text(
                  tittle.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
              ),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.black12, shape: BoxShape.circle),
              ),
              SizedBox(
                height: 30,
              ),
              dp.textfeild(
                controller: dp.textname,
                type: TextInputType.name,
                label: "Name",
                hind: "Name",
                length: 20,
              ),
              SizedBox(
                height: 30,
              ),
              dp.textfeild(
                controller: dp.textphone,
                type: TextInputType.phone,
                label: "Phone",
                hind: "Phone number",
                length: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 50,
                    minimumSize: Size.fromHeight(50),
                    shape: StadiumBorder()),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactPage(),
                    ),
                  );
                  dp.get();


                  dp.add(name: from.toString(), id: ids.toString());
                },
                child: Text("SAVE"),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  dp.get();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactPage(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Contacts",
                      style: TextStyle(fontSize: 40),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
