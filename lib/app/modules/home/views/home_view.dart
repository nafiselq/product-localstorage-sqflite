import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_product_local/app/data/models/products_model.dart';
import 'package:todo_product_local/app/data/services/local/database_helper.dart';
import 'package:todo_product_local/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Appbar
    AppBar appBar() {
      return AppBar(
        title: const Text('List Products'),
        centerTitle: true,
      );
    }

    //Content
    Widget content() {
      return FutureBuilder<List<Product>?>(
          future: DatabaseHelper.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var product = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.ADD_PRODUCT, arguments: product);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.only(top: 25),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Column(
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text("Deskripsi : "),
                                Text(product.description)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Qty : "),
                                Text(product.qty.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Harga : "),
                                Text(product.price.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const SizedBox();
          });
    }

    return Scaffold(
      appBar: appBar(),
      body: content(),
      floatingActionButton: InkWell(
        onTap: () {
          Get.toNamed(Routes.ADD_PRODUCT, arguments: null);
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadiusDirectional.circular(50),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
