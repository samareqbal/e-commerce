import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upstore/features/store/models/product_model.dart';
import 'package:upstore/utils/constants/sizes.dart';

class ImageController extends GetxController{
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;


  List<String> getAllProductImages(ProductModel product){
    Set<String> images = {};

    images.add(product.thumbnail);

    selectedProductImage.value = product.thumbnail;

    if(product.images != null && product.images!.isNotEmpty){
      images.addAll(product.images!);
    }


    if(product.productVariations != null && product.productVariations!.isNotEmpty){
      List<String> variationImages = product.productVariations!.map((e) => e.image).toList();

      images.addAll(variationImages);
    }

    return images.toList();
  }

  void showEnlargedImage(String image){
    Get.to(fullscreenDialog: true , () => Dialog.fullscreen(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: SSizes.defaultSpace * 2, horizontal: SSizes.defaultSpace),
          child: CachedNetworkImage(imageUrl: image),),

          const SizedBox(height: SSizes.spaceBtwSections),

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
            ),
          )
        ],
      ),
    ));
  }
}