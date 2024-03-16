import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final Map<String, List<String>> institutions;
  final Map<String, List<String>> institutionImages;
  final VoidCallback resetDataCallback;

  PageTwo({required this.institutions, required this.institutionImages, required this.resetDataCallback});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.red[300]),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.red),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            resetDataCallback(); // เรียกใช้งานฟังก์ชัน callback เมื่อกดปุ่มกลับ
            Navigator.pop(context); // ปิดหน้า PageTwo
          },
        ),

      ),
      body: Container(
        color: Colors.black, 
        child: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 1.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          itemCount: institutions.length,
          itemBuilder: (BuildContext context, int index) {
            String key = institutions.keys.elementAt(index);
            List<String> value = institutions[key]!;
            List<String> imagePaths = institutionImages[key]!; // Get image paths for the current institution
            return Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                border: Border.all(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.0),
                  // Display image
                  Image.asset(
                    imagePaths.isNotEmpty ? imagePaths[0] : '', 
                    fit: BoxFit.fill,
                    width: 200,
                    height: 300,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$key: ${value.length} คน',
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int idx) {
                        return ListTile(
                          title: Text('คือ!! ${value[idx]}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
