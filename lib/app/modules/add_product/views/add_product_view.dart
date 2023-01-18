import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_product_local/app/data/models/products_model.dart';
import 'package:todo_product_local/app/modules/widget/custom_button.dart';

import '../controllers/add_product_controller.dart';

// ignore: must_be_immutable
class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);

  Product? product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product != null ? 'Update Product' : 'Tambah Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameProduct,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Nama Produk",
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Produk tidak boleh kosong.';
                    }
                    if (value.length < 10) {
                      return 'Nama Produk minimal 10 karakter.';
                    }
                    if (value.trim() == "") {
                      return 'Tidak boleh hanya mengandung spasi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.qtyProduct,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Stok Produk",
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Stok Produk tidak boleh kosong.';
                    }
                    if (value.trim() == "") {
                      return 'Tidak boleh hanya mengandung spasi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.pricePrice,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Harga Produk",
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harga Produk tidak boleh kosong.';
                    }
                    if (value.length < 3) {
                      return 'Harga Produk minimal 3 karakter.';
                    }
                    if (value.trim() == "") {
                      return 'Tidak boleh hanya mengandung spasi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.descProduct,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text(
                      "Deskripsi Produk",
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Deskripsi Produk tidak boleh kosong.';
                    }
                    if (value.length < 10) {
                      return 'Deskripsi Produk minimal 10 karakter.';
                    }
                    if (value.trim() == "") {
                      return 'Tidak boleh hanya mengandung spasi.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                    title: product != null ? 'Update Produk' : 'Tambah Produk',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.action(product);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
