import 'package:flutter/material.dart';
import 'page2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _numberController = TextEditingController();
  final List<TextEditingController> _nameControllers = [];
  Map<String, List<String>> _institutions = {
    'ประชาชื่น': [],
    'อินทร': [],
    'กนกอาชีวะ': [],
    'บูรณพล': [],
  };

  Map<String, List<String>> _institutionImages = {
    'ประชาชื่น': ['assets/images/pachachun.png'],
    'อินทร': ['assets/images/inton.png'],
    'กนกอาชีวะ': ['assets/images/kanokachiwa.png'],
    'บูรณพล': ['assets/images/bu.png'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            "assets/images/4kinglogo.jpg",
            width: 150,
            height: 150,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity, 
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/all2.png"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200.0,
                      child: TextField(
                        controller: _numberController,
                        decoration: InputDecoration(
                          labelText: 'ป้อนจำนวนคน',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_numberController.text.isNotEmpty) {
                      int n = int.parse(_numberController.text);
                      _nameControllers.clear();
                      for (int i = 0; i < n; i++) {
                        _nameControllers.add(TextEditingController());
                      }
                      setState(() {});
                    }
                  },
                  child: Text(
                    'รับจำนวน',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                SizedBox(height: 20.0),
                if (_nameControllers.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ..._nameControllers.map(
                        (controller) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                            child: SizedBox(
                              width: 200.0,
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: 'ป้อนชื่อ',
                                  labelStyle: TextStyle(color: Colors.white),
                                  //hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          _generateRandomInstitutions();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageTwo(
                                institutions: _institutions,
                                institutionImages: _institutionImages,
                                resetDataCallback: _resetData,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'สุ่ม',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _generateRandomInstitutions() {
    _institutions.forEach((key, value) {
      _institutions[key] = [];
    });

    List<String> tempInstitutions = _institutions.keys.toList();
    tempInstitutions.shuffle();

    int totalPeople = 0;
    _nameControllers.forEach((controller) {
      String name = controller.text.trim();
      if (name.isNotEmpty) {
        totalPeople++;
      }
    });

    int peoplePerInstitution = totalPeople ~/ _institutions.length;
    int remainingPeople = totalPeople % _institutions.length;

    int currentIndex = 0;
    for (int i = 0; i < tempInstitutions.length; i++) {
      int count =
          i < remainingPeople ? peoplePerInstitution + 1 : peoplePerInstitution;
      for (int j = 0; j < count; j++) {
        if (currentIndex < _nameControllers.length &&
            _nameControllers[currentIndex].text.trim().isNotEmpty) {
          _institutions[tempInstitutions[i]]!
              .add(_nameControllers[currentIndex].text.trim());
          currentIndex++;
        }
      }
    }

    setState(() {});
  }

  void _resetData() {
    _numberController.clear();
    _nameControllers.clear();
    _institutions.forEach((key, value) {
      _institutions[key] = [];
    });
    setState(() {});
  }
}
