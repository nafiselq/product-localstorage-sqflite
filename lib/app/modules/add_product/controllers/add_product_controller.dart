import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_product_local/app/data/models/products_model.dart';
import 'package:todo_product_local/app/data/services/local/database_helper.dart';
import 'package:todo_product_local/app/routes/app_pages.dart';

class AddProductController extends GetxController {
  //TODO: Implement AddProductController
  RxBool isLoading = false.obs;
  Product? product = Get.arguments;
  final nameProduct = TextEditingController();
  final descProduct = TextEditingController();
  final qtyProduct = TextEditingController();
  final pricePrice = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void getProduk() {
    if (product != null) {
      nameProduct.text = product!.name;
      descProduct.text = product!.description;
      qtyProduct.text = product!.qty.toString();
      pricePrice.text = product!.price.toString();
    }
  }

  void action(Product? product) async {
    final Product body = Product(
        id: product?.id,
        name: nameProduct.text,
        description: descProduct.text,
        qty: int.parse(qtyProduct.text),
        price: int.parse(pricePrice.text));
    if (product == null) {
      var oke = await DatabaseHelper.addProduct(body);
      print("tambah: ${oke}");
    } else {
      var oke = await DatabaseHelper.updateProduct(body);
      print("update: ${oke}");
    }
    Get.offAllNamed(Routes.HOME);
  }

  final count = 0.obs;
  @override
  void onInit() {
    getProduk();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameProduct.dispose();
    descProduct.dispose();
    qtyProduct.dispose();
    pricePrice.dispose();
    super.onClose();
  }
}
