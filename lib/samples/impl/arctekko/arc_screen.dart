import 'package:get_cli/samples/interface/sample_interface.dart';
import 'package:recase/recase.dart';

//Usei arc pra fazer referencia a clean do katekko
class ArcScreenSample extends Sample {
  String fileName;
  bool isExample;
  ArcScreenSample(String path, String fileName,
      {bool overwrite = false, this.isExample = false})
      : super(path, overwrite: overwrite);

  @override
  Future<String> get content async => !isExample
      ? '''import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/${fileName.snakeCase}.controller.dart';

class ${fileName.pascalCase}Screen extends GetView<${fileName.pascalCase}Controller> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${fileName.pascalCase}Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '${fileName.pascalCase}Screen  is working', 
          style: TextStyle(fontSize:20),
        ),
      ),
    );
  }
}
'''
      : '''import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'controllers/counter.controller.dart';

class CounterScreen extends GetView<CounterController> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo Home Page with GetX"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              () => Text(
                // Use Obx(()=> to update Text() whenever count is changed.
                controller.count.string,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: controller.increment),
    );
  }
}
''';
}
