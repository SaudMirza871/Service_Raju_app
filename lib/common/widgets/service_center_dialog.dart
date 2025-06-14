import 'package:get/get.dart';
import 'package:ServiceRaju/utils/core_export.dart';

class ServiceCenterDialog extends StatefulWidget {
  final Service? service;
  final CartModel? cart;
  final int? cartIndex;
  final bool? isFromDetails;
  final ProviderData? providerData;
  final Discount? discount;
  final double lowestPrice;
  const ServiceCenterDialog(
      {super.key,
      required this.service,
      this.cart,
      this.cartIndex,
      this.isFromDetails = false,
      this.providerData,
      this.discount,
        required this.lowestPrice,});

  @override
  State<ServiceCenterDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ServiceCenterDialog> {
  @override
  void initState() {
    Get.find<CartController>().setInitialCartList(widget.service!);
    Get.find<CartController>()
        .updatePreselectedProvider(null, shouldUpdate: false);
    Get.find<AllSearchController>().searchFocus.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
      );
    }
    return pointerInterceptor();
  }

  pointerInterceptor() {
    return Padding(
      padding: EdgeInsets.only(
          top: ResponsiveHelper.isWeb() ? 0 : Dimensions.cartDialogPadding),
      child: PointerInterceptor(
        child: Container(
          width: ResponsiveHelper.isDesktop(context)
              ? Dimensions.webMaxWidth / 2
              : Dimensions.webMaxWidth,
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Dimensions.radiusExtraLarge)),
          ),
          child: GetBuilder<CartController>(builder: (cartControllerInit) {
            return GetBuilder<ServiceController>(builder: (serviceController) {
              if (widget.service!.variationsAppFormat!.zoneWiseVariations !=
                  null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions.paddingSizeDefault)),
                          child: CustomImage(
                            image: '${widget.service!.thumbnailFullPath}',
                            height: 70,
                            width: 70,
                          ),
                        ),
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   alignment: Alignment.center,
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Colors.white70.withValues(alpha: 0.6),
                        //       boxShadow: Get.isDarkMode
                        //           ? null
                        //           : [
                        //               BoxShadow(
                        //                 color: Colors.grey[300]!,
                        //                 blurRadius: 2,
                        //                 spreadRadius: 1,
                        //               )
                        //             ]),
                        //   child: InkWell(
                        //       onTap: () => Get.back(),
                        //       child: const Icon(
                        //         Icons.close,
                        //         color: Colors.black54,
                        //       )),
                        // )
                        Column(
                          children: [
                            const SizedBox(
                              height: Dimensions.paddingSizeEight,
                            ),
                            Text(
                              widget.service!.name!,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: Dimensions.paddingSizeMini,
                            ),
                            Text(
                              widget.service!.variationsAppFormat!.zoneWiseVariations!
                                  .length >
                                  1
                                  ? "${widget.service!.variationsAppFormat!.zoneWiseVariations!.length} ${'variations_available'.tr}"
                                  : "${widget.service!.variationsAppFormat!.zoneWiseVariations!.length} ${'variation_available'.tr}",
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withValues(alpha: .5)),
                            ),
                            if (ResponsiveHelper.isMobile(context))
                              Row(
                                children: [
                                  SizedBox(
                                    height: 25,
                                    child: Row(
                                      children: [
                                        Gaps.horizontalGapOf(3),
                                        Image(image: AssetImage(Images.starIcon)),
                                        Gaps.horizontalGapOf(5),
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                              "${widget.service?.avgRating!.toStringAsFixed(2)}",
                                              style: robotoBold.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gaps.horizontalGapOf(5),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text("(${widget.service?.ratingCount})",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color!
                                                .withValues(alpha: .6))),
                                  ),
                                  DiscountTag(
                                      fromTop: 0,
                                      color: Theme.of(context).colorScheme.error,
                                      discount: widget.discount!.discountAmount!,
                                      discountType: widget.discount!.discountAmountType)
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                !ResponsiveHelper.isMobile(context)
                                    ? Row(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      child: Row(
                                        children: [
                                          Gaps.horizontalGapOf(3),
                                          Image(
                                              image:
                                              AssetImage(Images.starIcon)),
                                          Gaps.horizontalGapOf(5),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                                "${widget.service?.avgRating!.toStringAsFixed(2)}",
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gaps.horizontalGapOf(5),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text("(${widget.service?.ratingCount})",
                                          style: robotoBold.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color!
                                                  .withValues(alpha: .6))),
                                    )
                                  ],
                                )
                                    : const SizedBox(),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                !ResponsiveHelper.isMobile(context)
                                    ? Row(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      child: Row(
                                        children: [
                                          Gaps.horizontalGapOf(3),
                                          Image(
                                              image:
                                              AssetImage(Images.starIcon)),
                                          Gaps.horizontalGapOf(5),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text("${widget.service?.avgRating!.toStringAsFixed(2)}",
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gaps.horizontalGapOf(5),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text("(${widget.service?.ratingCount})",
                                          style: robotoBold.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color!
                                                  .withValues(alpha: .6))),
                                    )
                                  ],
                                )
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 100,
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: Get.height * 0.1,
                                    maxHeight: Get.height * 0.4),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        cartControllerInit.initialCartList.length,
                                    itemBuilder: (context, index) {
                                      //variation item
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: Dimensions.paddingSizeSmall),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical:
                                                  Dimensions.paddingSizeExtraSmall),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).hoverColor,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(Dimensions
                                                      .paddingSizeDefault))),
                                          child: GetBuilder<CartController>(
                                            builder: (cartController) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              cartControllerInit
                                                                  .initialCartList[
                                                                      index]
                                                                  .variantKey
                                                                  .replaceAll(
                                                                      '-', ' '),
                                                              style: robotoMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall),
                                                              maxLines: 2,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                            const SizedBox(
                                                              height: Dimensions
                                                                  .paddingSizeExtraSmall,
                                                            ),
                                                            Directionality(
                                                              textDirection:
                                                                  TextDirection.ltr,
                                                              child: Text(
                                                                  PriceConverter.convertPrice(
                                                                      double.parse(cartControllerInit
                                                                          .initialCartList[
                                                                              index]
                                                                          .price
                                                                          .toString()),
                                                                      isShowLongPrice:
                                                                          true),
                                                                  style: robotoMedium.copyWith(
                                                                      color: Get
                                                                              .isDarkMode
                                                                          ? Theme.of(
                                                                                  context)
                                                                              .primaryColorLight
                                                                          : Theme.of(
                                                                                  context)
                                                                              .primaryColor,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Expanded(child: SizedBox()),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              cartControllerInit
                                                                          .initialCartList[
                                                                              index]
                                                                          .quantity >
                                                                      0
                                                                  ? InkWell(
                                                                      onTap: () {
                                                                        cartController
                                                                            .updateQuantity(
                                                                                index,
                                                                                false);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: 30,
                                                                        width: 30,
                                                                        margin: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                Dimensions.paddingSizeSmall),
                                                                        decoration: BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color: Theme.of(context)
                                                                                .colorScheme
                                                                                .secondary),
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child: Icon(
                                                                          Icons
                                                                              .remove,
                                                                          size: 15,
                                                                          color: Theme.of(
                                                                                  context)
                                                                              .cardColor,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
                                                              cartControllerInit
                                                                          .initialCartList[
                                                                              index]
                                                                          .quantity >
                                                                      0
                                                                  ? Text(
                                                                      cartControllerInit
                                                                          .initialCartList[
                                                                              index]
                                                                          .quantity
                                                                          .toString(),
                                                                    )
                                                                  : const SizedBox(),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartController
                                                                      .updateQuantity(
                                                                          index,
                                                                          true);
                                                                },
                                                                child: Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          Dimensions
                                                                              .paddingSizeSmall),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .secondary),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 15,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .cardColor,
                                                                  ),
                                                                ),
                                                              )
                                                            ]),
                                                      ),
                                                    ]),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              // const SizedBox(height: Dimensions.paddingSizeLarge),
                            ]),
                      ),
                    ),
                    GetBuilder<CartController>(builder: (cartController) {
                      bool addToCart = true;
                      return cartController.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Row(children: [
                              if (Get.find<SplashController>()
                                      .configModel
                                      .content
                                      ?.directProviderBooking ==
                                  1)
                                (widget.providerData != null ||
                                        cartController.selectedProvider != null)
                                    ? GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            useRootNavigator: true,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) =>
                                                AvailableProviderWidget(
                                              subcategoryId: widget
                                                      .service?.subCategoryId ??
                                                  "",
                                            ),
                                          );
                                        },
                                        child: SelectedProductWidget(
                                          providerData: widget.providerData ??
                                              cartController.selectedProvider,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            useRootNavigator: true,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) =>
                                                AvailableProviderWidget(
                                              subcategoryId: widget
                                                      .service?.subCategoryId ??
                                                  "",
                                            ),
                                          );
                                        },
                                        child: const UnselectedProductWidget(),
                                      ),
                              if (Get.find<SplashController>()
                                      .configModel
                                      .content
                                      ?.directProviderBooking ==
                                  1)
                                const SizedBox(
                                  width: Dimensions.paddingSizeSmall,
                                ),
                              if (Get.find<SplashController>()
                                      .configModel
                                      .content
                                      ?.biddingStatus ==
                                  1)
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        context: Get.context!,
                                        builder: (BuildContext context) {
                                          return const BottomCreatePostDialog();
                                        });
                                    if (widget.service != null) {
                                      Get.find<CreatePostController>()
                                          .updateSelectedService(
                                              widget.service!);
                                      Get.find<CreatePostController>()
                                          .resetCreatePostValue(
                                              removeService: false);
                                    }
                                  },
                                  child: Container(
                                    height: ResponsiveHelper.isDesktop(context)
                                        ? 50
                                        : 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSmall),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withValues(alpha: 0.5),
                                          width: 0.7),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.1),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.paddingSizeSmall),
                                    child: Center(
                                        child: Hero(
                                      tag: 'provide_image',
                                      child: Image.asset(
                                        Images.customPostIcon,
                                        height: 30,
                                        width: 30,
                                      ),
                                    )),
                                  ),
                                ),
                              if (Get.find<SplashController>()
                                      .configModel
                                      .content
                                      ?.biddingStatus ==
                                  1)
                                const SizedBox(
                                  width: Dimensions.paddingSizeSmall,
                                ),
                              Expanded(
                                child: CustomButton(
                                  height: ResponsiveHelper.isDesktop(context)
                                      ? 55
                                      : 45,
                                  onPressed: cartControllerInit.isButton
                                      ? () async {
                                          if (addToCart) {
                                            addToCart = false;
                                            await cartController
                                                .addMultipleCartToServer(
                                                    providerId: cartController
                                                            .selectedProvider
                                                            ?.id ??
                                                        widget
                                                            .providerData?.id ??
                                                        "");
                                            await cartController
                                                .getCartListFromServer(
                                                    shouldUpdate: true);
                                          }
                                          if (!Get.find<AuthController>()
                                                  .isLoggedIn()) {
                                            // Get.toNamed(RouteHelper.getNotLoggedScreen(
                                            //     RouteHelper.cart,
                                            //     "cart"));
                                            print("not login ${RouteHelper.getCartRoute()}");
                                            Get.toNamed(
                                                RouteHelper.getSignInRoute(fromPage: "serviceDetails"));
                                          } else {
                                            Get.find<CheckOutController>()
                                                .updateState(PageState.orderDetails);
                                              Get.toNamed(RouteHelper.getCheckoutRoute(
                                                  'cart',
                                                  'orderDetails',
                                                  'null'));
                                          }
                                          print("check login ${Get.find<SplashController>().configModel.content?.guestCheckout} : ${Get.find<AuthController>().isLoggedIn()}");
                                        }
                                      : null,
                                  buttonText:
                                      (cartController.cartList.isNotEmpty &&
                                              cartController.cartList
                                                      .elementAt(0)
                                                      .serviceId ==
                                                  widget.service!.id)
                                          ? 'update_cart'.tr
                                          : 'add_to_cart'.tr,
                                ),
                              )
                            ]);
                    }),
                  ],
                );
              }
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70.withValues(alpha: 0.6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[
                                  Get.find<ThemeController>().darkTheme
                                      ? 700
                                      : 300]!,
                              blurRadius: 2,
                              spreadRadius: 1,
                            )
                          ]),
                      child: InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.close)),
                    ),
                  ),
                  SizedBox(
                      height: Get.height / 7,
                      child: Center(
                          child: Text(
                        'no_variation_is_available'.tr,
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge),
                      )))
                ],
              );
            });
          }),
        ),
      ),
    );
  }
}
