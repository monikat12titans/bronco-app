import 'package:bronco_trucking/di/api/api_interface.dart';
import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/di/locator.dart';
import 'package:bronco_trucking/enum/font_type.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:bronco_trucking/ui/common/translation_service.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/custom_progress_dialog.dart';
import 'package:bronco_trucking/ui/global_controller.dart';
import 'package:bronco_trucking/ui/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    AppComponentBase.instance.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: const InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEE4D17), width: 2)),
            )),
        // logWriterCallback: Logger.write,
        initialRoute: RouteName.root,
        getPages: Routes.routes,
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        initialBinding: BindingsBuilder(() {
          Get.put(SplashController());
          Get.lazyPut(() => APIProvider());
          Get.put(GlobalController());
        }),
        // like this!

        builder: (context, _) {
		  final _appTheme = AppTheme.of(context);
		  ScreenUtil.init(
			context, // Provide the BuildContext
			minTextAdapt: true, // Initialize _minTextAdapt
			designSize: Size(_appTheme.expectedDeviceWidth,
                  _appTheme.expectedDeviceHeight)
			);
		  return Scaffold(
			body: Stack(
			  children: <Widget>[
				StreamBuilder<bool?>(
				  initialData: false,
				  stream: AppComponentBase.instance.progressDialogStream,
				  builder: (context, snapshot) {
					return IgnorePointer(
					  ignoring: snapshot.data ?? false,
					  child: _,
					);
				  },
				),
				StreamBuilder<bool?>(
				  initialData: true,
				  stream: AppComponentBase.instance.networkManage.internetConnectionStream,
				  builder: (context, snapshot) {
					return SafeArea(
					  child: AnimatedContainer(
						height: snapshot.data ?? false ? 0 : 100.h,
						duration: Utils.animationDuration,
						color: _appTheme.redColor,
						child: Material(
						  type: MaterialType.transparency,
						  child: Center(
							child: Text(
							  StringConstants.noInternetConnection,
							  style: _appTheme.customTextStyle(
								fontSize: 40,
								color: _appTheme.whiteColor,
								fontFamilyType: FontFamily.OpenSans,
								fontWeightType: FontWeight.bold,
							  ),
							),
						  ),
						),
					  ),
					);
				  },
				),
				StreamBuilder<bool?>(
				  initialData: false,
				  stream: AppComponentBase.instance.progressDialogStream,
				  builder: (context, snapshot) {
					if (snapshot.data ?? false) {
					  return Center(child: CustomProgressDialog());
					} else {
					  return const Offstage();
					}
				  },
				)
			  ],
			),
		  );
		},
      ),
    );
  }

  @override
  void dispose() {
    AppComponentBase.instance.dispose();
    super.dispose();
  }
}
