import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:upstore/data/repositories/banner/banner_repository.dart';
import 'package:upstore/features/store/models/banner_model.dart';
import 'package:upstore/utils/popups/snackbar_helpers.dart';

class BannerController extends GetxController{
  static BannerController get instance => Get.find();

  final _repository = Get.put(BannerRepository());
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isLoading = false.obs;

  final carouselController = CarouselSliderController();
  RxInt currentIndex = 0.obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void onPageChanged(int index){
    currentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try{

      isLoading.value = true;

      List<BannerModel> activeBanner = await _repository.fetchActiveBanners();
      banners.assignAll(activeBanner);


    }catch(e){
      SSnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }


}