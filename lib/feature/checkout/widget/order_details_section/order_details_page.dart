import 'package:ServiceRaju/feature/checkout/widget/choose_booking_type_widget.dart';
import 'package:ServiceRaju/feature/checkout/widget/order_details_section/create_account_widget.dart';
import 'package:ServiceRaju/feature/checkout/widget/order_details_section/repeat_booking_schedule_widget.dart';
import 'package:ServiceRaju/utils/core_export.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return GetBuilder<CartController>(builder: (cartController) {
        bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
        bool createGuestAccount = Get.find<SplashController>()
                .configModel
                .content
                ?.createGuestUserAccount ==
            1;
        ConfigModel configModel = Get.find<SplashController>().configModel;
        AddressModel? addressModel = CheckoutHelper.selectedAddressModel(
            selectedAddress: locationController.selectedAddress,
            pickedAddress: locationController.getUserAddress());
        bool contactPersonInfoAvailable = addressModel != null &&
            addressModel.contactPersonNumber != null &&
            addressModel.contactPersonNumber != "";

        return SingleChildScrollView(
            child: Column(children: [
          GetBuilder<ScheduleController>(builder: (scheduleController) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Column(children: [
                isLoggedIn && configModel.content?.repeatBooking == 1
                    ? const ChooseBookingTypeWidget()
                    : const SizedBox(),
                const SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                (scheduleController.selectedServiceType ==
                            ServiceType.regular ||
                        !isLoggedIn)
                    ? const ServiceSchedule()
                    : const RepeatBookingScheduleWidget(),
              ]),
            );
          }),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
              // // Birth Date
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 10.0),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(8),
              //     border: Border.all(
              //         color: Theme.of(context).primaryColor),
              //   ),
              //   child: TextButton(
              //     onPressed: () async {
              //       DateTime? pickedDate = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime.now(),
              //         firstDate: DateTime(1901),
              //         lastDate: DateTime.now(),                                    builder:
              //           (BuildContext context, Widget? child) {
              //         return Theme(
              //           data: ThemeData.light().copyWith(
              //             colorScheme: ColorScheme.light(
              //               primary: Colors.white,
              //               onPrimary:
              //               Theme.of(context).primaryColor,
              //               surface: const Color(0xFFFFF7EC),
              //               onSurface:
              //               Theme.of(context).primaryColor,
              //             ),
              //             dialogBackgroundColor:
              //             const Color(0xFFFFF7EC),
              //             textButtonTheme: TextButtonThemeData(
              //               style: TextButton.styleFrom(
              //                 foregroundColor: Theme.of(context)
              //                     .primaryColor,
              //                 backgroundColor: Colors.white,
              //               ),
              //             ),
              //           ),
              //           child: child!,
              //         );
              //       },
              //       );
              //       if (pickedDate != null) {
              //         setState(() {
              //           _dateController.text =
              //               DateFormat('dd/MM/yyyy')
              //                   .format(pickedDate);
              //         });
              //       }
              //     },
              //     style: TextButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 10.0),
              //       alignment: Alignment.centerLeft,
              //       backgroundColor: Colors.white,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment:
              //       MainAxisAlignment.spaceBetween,
              //       children: [
              //         _dateController.text.isEmpty
              //             ? const Text(
              //           "Select Date",
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: Colors.grey,
              //           ),
              //         )
              //             : Text(
              //           _dateController.text,
              //           style: const TextStyle(
              //             fontSize: 16,
              //             color: Colors.black,
              //           ),
              //         ),
              //         const Icon(Icons.calendar_month_outlined,
              //             color: Colors.grey, size: 25),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 8.0),
              //
              // // Birth Timing
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 10.0),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(8),
              //     border: Border.all(
              //         color: Theme.of(context).primaryColor),
              //   ),
              //   child: TextButton(
              //     onPressed: () async {
              //       TimeOfDay? pickedTime = await showTimePicker(
              //         initialTime: TimeOfDay.now(),
              //         context: context,
              //         builder:
              //             (BuildContext context, Widget? child) {
              //           return Theme(
              //             data: ThemeData.light().copyWith(
              //               timePickerTheme: TimePickerThemeData(
              //                 dialHandColor: Colors.black12,
              //                 dialTextStyle: const TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //                 dialTextColor:
              //                 Theme.of(context).primaryColor,
              //                 dialBackgroundColor: Colors.white,
              //                 dayPeriodColor: Colors.white,
              //                 dayPeriodTextColor:
              //                 Theme.of(context).primaryColor,
              //                 backgroundColor:
              //                 const Color(0xFFFFF7EC),
              //                 hourMinuteTextColor:
              //                 Theme.of(context).primaryColor,
              //                 hourMinuteColor: Colors.white,
              //                 inputDecorationTheme:
              //                 InputDecorationTheme(
              //                   border: InputBorder.none,
              //                   filled: true,
              //                   fillColor: Colors.white,
              //                   hintStyle: TextStyle(
              //                       color: Theme.of(context)
              //                           .primaryColor),
              //                   labelStyle: TextStyle(
              //                       color: Theme.of(context)
              //                           .primaryColor),
              //                 ),
              //               ),
              //               dialogBackgroundColor: Colors.white,
              //               textButtonTheme: TextButtonThemeData(
              //                 style: TextButton.styleFrom(
              //                   foregroundColor: Theme.of(context)
              //                       .primaryColor,
              //                   backgroundColor: Colors.white,
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius:
              //                       BorderRadius.circular(
              //                           10)),
              //                 ),
              //               ),
              //             ),
              //             child: child!,
              //           );
              //         },
              //       );
              //       if (pickedTime != null) {
              //         setState(() {
              //           // birthHour = pickedTime.hour.toString();
              //           // birthMinute =
              //           //     pickedTime.minute.toString();
              //           _timeController.text =
              //               pickedTime.format(context);
              //         });
              //       }
              //     },
              //     style: TextButton.styleFrom(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 10.0),
              //       alignment: Alignment.centerLeft,
              //       backgroundColor: Colors.white,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment:
              //       MainAxisAlignment.spaceBetween,
              //       children: [
              //         _timeController.text.isEmpty
              //             ? const Text(
              //           "Select Time",
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: Colors.grey,
              //           ),
              //         )
              //             : Text(
              //           _timeController.text,
              //           style: const TextStyle(
              //             fontSize: 16,
              //             color: Colors.black,
              //           ),
              //         ),
              //         const Icon(Icons.timelapse_outlined,
              //             color: Colors.grey, size: 25),
              //       ],
              //     ),
              //   ),
              // ),
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: AddressInformation(),
          ),
          if (!isLoggedIn && createGuestAccount && contactPersonInfoAvailable)
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: CreateAccountWidget(),
            ),
          if (!isLoggedIn && createGuestAccount && contactPersonInfoAvailable)
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
          cartController.cartList.isNotEmpty &&
                  cartController.cartList.first.provider != null
              ? ProviderDetailsCard(
                  providerData:
                      Get.find<CartController>().cartList.first.provider,
                )
              : const SizedBox(),

              const SizedBox(height: 8.0),
          Get.find<AuthController>().isLoggedIn()
              ? const ShowVoucher()
              : const SizedBox(),
          const CartSummery()
        ]));
      });
    });
  }
}
