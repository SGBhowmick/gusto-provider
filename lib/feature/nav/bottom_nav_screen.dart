import 'dart:ui';
import 'package:dusto_provider/feature/payement_information/controller/payment_info_controller.dart';
import 'package:dusto_provider/helper/extension_helper.dart';
import 'package:dusto_provider/util/core_export.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';

class BottomNavScreen extends StatefulWidget {
  final int pageIndex;
  final bool formTutorial;

  static Future<void> loadData({int pageIndex = 0}) async {
    Get.find<DashboardController>().getDashboardData(reload: true);
    Get.find<DashboardController>().getEarningData();
    Get.find<UserProfileController>().getProviderInfo(reload: true);
    Get.find<ServiceCategoryController>().getCategoryList(
      shouldUpdate: true,
      reloadSubcategory: true,
    );
    Get.find<LocalizationController>().filterLanguage(shouldUpdate: false);
    Get.find<ConversationController>().getChannelList(1, type: "serviceman");
    Get.find<ConversationController>().getChannelList(1, type: "customer");
    Get.find<ServicemanSetupController>().getAllServicemanList(
      1,
      reload: true,
      status: 'all',
    );
    await Get.find<UserProfileController>().getProviderInfo(reload: true).then((
      isProviderModelAvailable,
    ) {
      Get.find<BusinessSubscriptionController>().getSubscriptionPackageList();
      if (pageIndex != 1) {
        Get.find<BusinessSubscriptionController>().openTrialEndBottomSheet();
      }
      Get.find<UserProfileController>().trialWidgetShow(route: "");
    });
    Get.find<AuthController>().updateToken();
    Get.find<PaymentInfoController>().getPaymentMethods(
      isUpdate: false,
      isReload: false,
    );
  }

  const BottomNavScreen({
    super.key,
    required this.pageIndex,
    this.formTutorial = false,
  });

  @override
  BottomNavScreenState createState() => BottomNavScreenState();
}

class BottomNavScreenState extends State<BottomNavScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;
  bool _canExit = GetPlatform.isWeb ? true : false;
  bool isTutorialActive = false;

  @override
  void initState() {
    super.initState();

    final bool tutorialCurrentStatus =
        Get.find<UserProfileController>()
            .providerModel
            ?.content
            ?.providerInfo!
            .tutorialData?[AppConstants.serviceSubscriptionTutorialKey]
            ?.contains('0') ??
        true;

    isTutorialActive = widget.formTutorial && tutorialCurrentStatus;

    if (!isTutorialActive) {
      BottomNavScreen.loadData(pageIndex: widget.pageIndex);
    }
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _screens = [
      const DashBoardScreen(),
      const BookingRequestScreen(),
      ShowCaseWidget(
        builder: (context) {
          return AllServicesScreen(isTutorialActive: isTutorialActive);
        },
      ),
      Text("more".tr),
    ];

    return CustomPopScopeWidget(
      onPopInvoked: () {
        if (_pageIndex != 0) {
          _setPage(0);
        } else {
          if (_canExit) {
            SystemNavigator.pop();
          } else {
            showCustomSnackBar(
              'back_press_again_to_exit'.tr,
              type: ToasterMessageType.info,
            );
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
          }
        }
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withValues(alpha: 0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) => robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: states.contains(WidgetState.selected)
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.6) ??
                            Colors.grey,
                ),
              ),
            ),
            child: NavigationBar(
              height: 85,
              animationDuration: const Duration(milliseconds: 200),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              selectedIndex: _pageIndex,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onDestinationSelected: _setPage,
              surfaceTintColor: Theme.of(context).colorScheme.surface,
              backgroundColor: Colors.transparent,
              elevation: 2,
              indicatorColor: Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.1),
              destinations: [
                NavigationDestination(
                  icon: _buildIcon(Images.dashboard, false),
                  selectedIcon: _buildIcon(Images.dashboard, true),
                  label: 'dashboard'.tr,
                ),
                NavigationDestination(
                  icon: _buildIcon(Images.requests, false),
                  selectedIcon: _buildIcon(Images.requests, true),
                  label: 'requests'.tr,
                ),
                NavigationDestination(
                  icon: _buildIcon(Images.service, false),
                  selectedIcon: _buildIcon(Images.service, true),
                  label: 'services'.tr,
                ),
                NavigationDestination(
                  icon: _buildIcon(Images.more, false),
                  selectedIcon: _buildIcon(Images.more, true),
                  label: 'more'.tr,
                ),
              ],
            ),
          ),
        ),
        body: GetBuilder<UserProfileController>(
          builder: (userProfileController) {
            return PageView.builder(
              controller: _pageController,
              itemCount: _screens!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _screens![index];
              },
            );
          },
        ),
        floatingActionButton:
            Get.find<SplashController>().configModel.content?.biddingStatus ==
                    1 &&
                Get.find<SplashController>().showCustomBookingButton
            ? GestureDetector(
                onTap: () => Get.find<BusinessSubscriptionController>()
                    .openTrialEndBottomSheet()
                    .then((isTrial) {
                      if (isTrial) {
                        if (Get.find<UserProfileController>()
                            .checkAvailableFeatureInSubscriptionPlan(
                              featureType: 'bidding',
                            )) {
                          Get.to(() => const CustomerRequestListScreen());
                        }
                      }
                    }),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: context.customThemeColors.shadow,
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).cardColor,
                  ),
                  padding: const EdgeInsets.all(
                    Dimensions.paddingSizeDefault - 2,
                  ),
                  child: Image.asset(
                    Images.createPostIconWithRedDot,
                    height: 40,
                    width: 40,
                  ),
                ),
              )
            : null,
      ),
    );
  }

  void _setPage(int pageIndex) {
    if (pageIndex == 3) {
      Get.find<UserProfileController>().trialWidgetShow(route: "show-dialog");
      Get.bottomSheet(
        const MenuScreen(),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        barrierColor: Colors.black.withValues(
          alpha: Get.isDarkMode ? 0.7 : 0.6,
        ),
      ).then((_) {
        Get.find<UserProfileController>().trialWidgetShow(route: "");
      });
    } else {
      setState(() {
        if (pageIndex == 2) {
          final bool tutorialCurrentStatus =
              Get.find<UserProfileController>()
                  .providerModel
                  ?.content
                  ?.providerInfo!
                  .tutorialData?[AppConstants.serviceSubscriptionTutorialKey]
                  ?.contains('0') ??
              true;

          isTutorialActive = tutorialCurrentStatus;
        }

        _pageController?.jumpToPage(pageIndex);
        _pageIndex = pageIndex;
      });
    }
  }

  Widget _buildIcon(String iconPath, bool isSelected) {
    return iconPath.isEmpty
        ? const SizedBox(width: 24, height: 24)
        : Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withValues(alpha: 0.6) ??
                      Colors.grey,
          );
  }
}
