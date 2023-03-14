import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 187, 212, 255),
        appBar: AppBar(
          title: Center(child: const Text('About me')),
        ),
        body: Container(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/me.jpeg'),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: Column(children: [
                  ListTile(
                    leading: Text("Name"),
                    title: Text("Arpana Prajapati"),
                  ),
                  ListTile(
                    leading: Text("Age"),
                    title: Text("20"),
                  ),
                  ListTile(
                    leading: Text("Gender"),
                    title: Text("Female"),
                  ),
                  ListTile(
                    leading: Text("Hobbies"),
                    title: Text("Listening to music"),
                  ),
                ]),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 106, 208, 255),
                  ),
                  title: Text("contact no"),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.lightBlue,
                  ),
                  title: Text("arpanap2002@gmail.com"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to first route when tapped.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen()),
                  );
                },
                child: const Text('Go to next page!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
  // SecondScreenState secondScreenState = secondScreen.createState();
}

class _SecondScreenState extends State<SecondScreen> {
  // SecondScreen createState() => SecondScreen();

  final formKey = GlobalKey<FormState>();
  String Gvar1 = "All is Well";
  String name = "Anonymous";
  // TextEditingController _emailTEC = TextEditingController();

  getValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString('article');
    return val;
  }

  getValueForName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString('name');
    return val;
  }

  setValue() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('article', Gvar1);
    pref.setString('name', name);
  }

  @override
  void initState() {
    super.initState();
    checkForMailValue();
  }

  checkForMailValue() async {
    String? count = await getValue() ?? "All is Well";
    String? count2 = await getValueForName() ?? "Anonymous";
    setState(() {
      Gvar1 = count.toString();
      name = count2.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 207, 224, 255),
        appBar: AppBar(
          title: Center(child: const Text('Post anything')),
        ),
        body: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      // controller: _emailTEC,
                      decoration: InputDecoration(hintText: 'Your Pen Name'),
                      validator: (val) {
                        if (val.toString().trim().isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value.toString();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Write whatever is there in your mind...'),
                      validator: (val) {
                        if (val.toString().trim().isEmpty) {
                          return "required";
                        }
                        if (val.toString().length < 8) {
                          return "more than 8 characters needed";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        Gvar1 = value.toString();
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          formKey.currentState?.save();
                          print("the form is valid");
                          print(Gvar1);
                          setValue();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondScreen()));
                        }
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              ),
            ),
            Container(
                child: Column(
              children: [
                Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.text_fields,
                      color: Colors.lightBlue,
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: Gvar1,
                        // style: TextStyle(fontWeight: FontWeight.bold),
                        style: TextStyle(
                          fontSize: 27,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.blue[700]!,
                        ),
                      ),
                      selectionRegistrar: SelectionContainer.maybeOf(context),
                      selectionColor: const Color(0xAF6694e8),
                    ),
                    trailing: Text(name),
                  ),
                ),
              ],
            )),
          ]),
        ),
      ),
    );
  }
}
