// // ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:smart_soliq_app/core/const/const.dart';
// import 'package:smart_soliq_app/models/subject.dart';
// import 'package:smart_soliq_app/widgets/subject_card.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final List<Subject> subjects = [
//     Subject(name: "Tarix", imagePath: "assets/images/history.png"),
//     Subject(name: "Adabiyot", imagePath: "assets/images/adabiyot.png"),
//     Subject(name: "Matematika", imagePath: "assets/images/matematika.png"),
//   ];

//   final List<Color> backgroundColors = [
//     Color(0xFFEAF8E5), // Yashil fon
//     Color(0xFFFFF0E5), // Apelsin fon
//     Color(0xFFFFE5E5), // Qizil fon
//   ];

//   final List<Color> borderColors = [
//     Color(0xFF4CAF50), // Yashil ramka (Tarix)
//     Color(0xFFFF9800), // Apelsin ramka (Adabiyot)
//     Color(0xFFF44336), // Qizil ramka (Matematika)
//   ];

//   List<Subject> filteredSubjects = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredSubjects = subjects;
//   }

//   void _filterSubjects(String query) {
//     setState(() {
//       filteredSubjects = subjects
//           .where((subject) =>
//               subject.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppConstant.whiteColor,
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: _filterSubjects,
//               decoration: InputDecoration(
//                 hintText: "Fan qidirish",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.9,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: filteredSubjects.length,
//                 itemBuilder: (context, index) {
//                   return SubjectCard(
//                     subject: filteredSubjects[index],
//                     backgroundColor: backgroundColors[index % backgroundColors.length],
//                     borderColor: borderColors[index % borderColors.length],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_soliq_app/blocs/subject/subject_all_bloc.dart';
import 'package:smart_soliq_app/blocs/subject/subject_all_state.dart';
import 'package:smart_soliq_app/controller/subject_controller.dart';
import 'package:smart_soliq_app/core/const/const.dart';
import 'package:smart_soliq_app/core/endpoints/endpoints.dart';
import 'package:smart_soliq_app/export_files.dart';
import 'package:smart_soliq_app/models/subject.dart';
import 'package:smart_soliq_app/screens/book/books_screen.dart';
import 'package:smart_soliq_app/service/logout.dart';
import 'package:smart_soliq_app/service/storage_service.dart';
import 'package:smart_soliq_app/service/toast_service.dart';
import 'package:smart_soliq_app/widgets/custom_text_field.dart';
import 'package:smart_soliq_app/widgets/subject_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<Subject> subjects = [
  //   Subject(name: "Tarix", imagePath: "assets/images/history.png"),
  //   Subject(name: "Adabiyot", imagePath: "assets/images/adabiyot.png"),
  //   Subject(name: "Matematika", imagePath: "assets/images/matematika.png"),
  //   Subject(name: "Tarix", imagePath: "assets/images/history.png"),
  //   Subject(name: "Adabiyot", imagePath: "assets/images/adabiyot.png"),
  //   Subject(name: "Matematika", imagePath: "assets/images/matematika.png"),
  //   Subject(name: "Tarix", imagePath: "assets/images/history.png"),
  //   Subject(name: "Adabiyot", imagePath: "assets/images/adabiyot.png"),
  //   Subject(name: "Matematika", imagePath: "assets/images/matematika.png"),
  // ];

  // final List<Color> backgroundColors = [
  //   Color(0xFFEAF8E5), // Yashil fon
  //   Color(0xFFFFF0E5), // Apelsin fon
  //   Color(0xFFFFE5E5), // Qizil fon
  // ];

  // final List<Color> borderColors = [
  //   Color(0xFF4CAF50), // Yashil ramka (Tarix)
  //   Color(0xFFFF9800), // Apelsin ramka (Adabiyot)
  //   Color(0xFFF44336), // Qizil ramka (Matematika)
  // ];

  @override
  void initState() {
    super.initState();
  }

  TextEditingController seachController = TextEditingController();
  ToastService toastService = ToastService();
  Map getUser() {
    var user = StorageService().read(StorageService.user);
    if (user != null) {
      return user;
    }
    return {"name": "", "phone": "", "id": "4433833"};
  }

  final List<GridItem> items = [
    GridItem('Soliqlarim', 'assets/icons/magazine.svg'),
    GridItem('Keshbek va Imtiyozlar', 'assets/icons/magazine.svg'),
    GridItem('Soliq Hamkor', 'assets/icons/magazine.svg'),
    GridItem('Barqarorlik reytengi', 'assets/icons/magazine.svg'),
    GridItem('Mening uyim', 'assets/icons/magazine.svg'),
    GridItem('"Soliq" biznes', 'assets/icons/magazine.svg'),
       GridItem('Personal xizmatlar', 'assets/icons/magazine.svg'),
    GridItem('Umumiy xizmatlar', 'assets/icons/magazine.svg'),
    GridItem('Mening jarimalarim', 'assets/icons/magazine.svg'),
    GridItem('Xorijga chiqish', 'assets/icons/magazine.svg'),
    GridItem('Elektron raqamli imzo', 'assets/icons/settings.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    Map user = getUser();
    return Scaffold(
      backgroundColor: AppConstant.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Salom, " + user["name"].toString().split(" ")[0].toString(),
              style: TextStyle(
                color: AppConstant.blackColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "ID ${user["id"]}",
              style: TextStyle(
                color: AppConstant.greyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Jami hisoblangan",
                  style: TextStyle(
                    color: AppConstant.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "154 010",
                  style: TextStyle(
                    color: AppConstant.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: 1.sw,
              height: 55.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder:
                    (context, index) => Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 6.w),
                      child: Container(
                        width: 120.w,
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                         
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 223, 238, 246),
                          borderRadius: BorderRadius.circular(16.r)
                        ),
                        child: Column(mainAxisSize: MainAxisSize.min,
                        children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        [
                                          "Jarayonda",
                                          "Hamyonda",
                                          "Tasdiqlangan",
                                          "To'langan"
                                        ][index],
                                        style: TextStyle(
                      color: AppConstant.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                      [
                                          "23 536",
                                            "0",
                                              "130 474",
                                                "130 474"
                                      ][index],
                                        style: TextStyle(
                      color: [
                        const Color.fromARGB(255, 39, 69, 219),
                        const Color.fromARGB(255, 18, 117, 59),
                        const Color.fromARGB(255, 90, 210, 60),
                        const Color.fromARGB(255, 228, 135, 34)
                      ][index],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                              
                        ],),
                      ),
                    ),
              ),
            ),
           SizedBox(
            height: 16.h,
           ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                        "Xizmatlar",
                        style: TextStyle(
                          color: AppConstant.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                ],
              ),
            ),
              
            
             SizedBox(
            height: 4.h,
           ),
           GridView.count(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // disable inner scrolling

              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h
              ),
              

          crossAxisCount: 3, // 3 columns
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8, // control height vs width
          children: items.map((item) {
            return Container(
               decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 223, 238, 246),
                          borderRadius: BorderRadius.circular(16.r)
                        ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.iconPath,
                    height: 48,
                    width: 48,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
          ],
        ),
      ),
    );
  }
}


class GridItem {
  final String title;
  final String iconPath;

  GridItem(this.title, this.iconPath);
}