import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Controller untuk mendemonstrasikan penggunaan workers
class WorkerController extends GetxController {
  //variable reaktif yang akan kita monitor
  var count = 0.obs;

  @override
  void onInit() {
    //memanggil workder setiap kali count berubah
    ever(count, (_) => print("ever: Count changed to $count"));

    //memanggil worker hanya satu kali saat count berubah untuk pertama kalinya
    once(count, (_) => print("once: Count changed to $count"));

    //memanggil worker setiap 2 detik, hanya jika ada perubahan pada count
    interval(count, (_) => print("interval: Count changed to $count"),
        time: Duration(seconds: 2));

    super.onInit();
  }

  //fungsi untuk menambah nilai count
  void increment() {
    count++;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("workers Example")),
        body: WorkerExample(),
      ),
    );
  }
}

class WorkerExample extends StatelessWidget {
  //menginisialisasi controller menggunakan GetX
  final WorkerController wc = Get.put(WorkerController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text("Count: ${wc.count}", style: TextStyle(fontSize: 24))),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: wc.increment,
            child: Text("Increment"),
          ),
        ],
      ),
    );
  }
}

