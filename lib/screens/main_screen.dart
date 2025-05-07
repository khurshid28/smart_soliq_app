// ignore_for_file: deprecated_member_use

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_soliq_app/blocs/rate/rate_state.dart';
import 'package:smart_soliq_app/blocs/rate/rate_bloc.dart';
import 'package:smart_soliq_app/controller/rate_controller.dart';
import 'package:smart_soliq_app/export_files.dart';
import 'package:smart_soliq_app/screens/book/books_body.dart';
import 'package:smart_soliq_app/screens/chat/chat_screen.dart';
import 'package:smart_soliq_app/screens/home/home_screen.dart';
import 'package:smart_soliq_app/screens/profile.dart';
import 'package:smart_soliq_app/screens/rate/rate_screen.dart';
import 'package:smart_soliq_app/screens/saved/saved_body.dart';
import 'package:smart_soliq_app/service/logout.dart';
import 'package:smart_soliq_app/service/storage_service.dart';
import 'package:smart_soliq_app/service/toast_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  List<String> appBarTitle = ['Asosiy', 'Soliqlar', 'Chat', 'Profil'];
  List<Map<String, String>> svgIcon = [
    {
      'main': 'assets/icons/house.svg',
      'mainfill': 'assets/icons/housefill.svg',
    },
    {
      'contract': 'assets/icons/magazine.svg',
      'contractfill': 'assets/icons/magazinefill.svg',
    },
    {
      'chat': 'assets/icons/chat.svg',
      'chatfill': 'assets/icons/chatfill.svg',
    },
    {
      'profile': 'assets/icons/person.svg',
      'profilefill': 'assets/icons/personfill.svg',
    },
  ];

  ToastService toastService =ToastService();

  
  int findRate(List data){
    Map? user = StorageService().read(StorageService.user);
    return data.indexWhere((element)=> element["id"].toString() == "${user?["id"]}") + 1;

  }
  num getPercent(List results){
     
     double score = 0;
     if(results.isEmpty) return 0;
     for (var r in results) {
      score+=(r["solved"] as int)/(r["test"]?["_count"]?["test_items"] ?? 1);
     }

     return (score * 1000/(results.length)).floor()/10;

  }
  List sortRates(List data){
    data.sort((a, b) => getPercent(b["results"]).compareTo(getPercent(a["results"])));
   return data;
  }
  @override
  void initState() { 
    super.initState();
    RateController.getAll(context);
  }
  @override
  Widget build(BuildContext context) {
    // print("Access_token :"+ StorageService().read(StorageService.access_token));
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppConstant.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: appBarTitle[currentIndex],
          isLeading: false,

          ),
      ),
      body: selectBody(currentIndex),
      // drawer: CustomDrawer(scaffoldKey: scaffoldKey),
      // drawerEnableOpenDragGesture: true,
      // drawerScrimColor: Colors.black38,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppConstant.whiteColor,
        selectedItemColor: AppConstant.primaryColor,
        unselectedItemColor: AppConstant.blackColor,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,

        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon:
                currentIndex != 0
                    ? SvgPicture.asset(svgIcon[0]['main'].toString())
                    : SvgPicture.asset(svgIcon[0]['mainfill'].toString()),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon:
                currentIndex != 1
                    ? SvgPicture.asset(svgIcon[1]['contract'].toString())
                    : SvgPicture.asset(svgIcon[1]['contractfill'].toString()),
            label: 'Soliqlar',
          ),
          BottomNavigationBarItem(
            icon:
                currentIndex != 2
                    ? SvgPicture.asset(svgIcon[2]['chat'].toString())
                    : SvgPicture.asset(svgIcon[2]['chatfill'].toString(),color: AppConstant.primaryColor,),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon:
                currentIndex != 3
                    ? SvgPicture.asset(svgIcon[3]['profile'].toString())
                    : SvgPicture.asset(svgIcon[3]['profilefill'].toString()),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  selectBody<Widget>(int currentIndex) {
    if (currentIndex == 0) {
      return HomeScreen();
    } else if (currentIndex == 1) {
      return BooksBody();
    } else if (currentIndex == 2) {
      return ChatScreen();
    } else if (currentIndex == 3) {
      return const ProfileScreen();
    }
    return HomeScreen();

    // if (currentIndex == 0) {
    //   return const HomeScreen();
    // } else if (currentIndex == 1) {
    //   return const DocumentScreen();
    // } else if (currentIndex == 2) {
    //   return const MarketScreen();
    // } else if (currentIndex == 3) {
    //   return const ProfileScreen();
    // }
  }
}
