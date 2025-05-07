import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_soliq_app/blocs/book/book_all_bloc.dart';
import 'package:smart_soliq_app/blocs/book/book_all_state.dart';
import 'package:smart_soliq_app/blocs/scanner/Scanner_bloc.dart';
import 'package:smart_soliq_app/controller/book_controller.dart';
import 'package:smart_soliq_app/core/const/const.dart';
import 'package:smart_soliq_app/core/endpoints/endpoints.dart';
import 'package:smart_soliq_app/export_files.dart';
import 'package:smart_soliq_app/models/book.dart';
import 'package:smart_soliq_app/models/subject.dart';
import 'package:smart_soliq_app/screens/book/book_screen.dart';
import 'package:smart_soliq_app/service/logout.dart';
import 'package:smart_soliq_app/service/toast_service.dart';
import 'package:smart_soliq_app/widgets/BookCard.dart';
import 'package:smart_soliq_app/widgets/custom_text_field.dart';
import 'package:smart_soliq_app/widgets/subject_card.dart';

import '../qrcode/qrcode_alert.dart';

class BooksBody extends StatefulWidget {
  const BooksBody({super.key});

  @override
  _BooksBodyState createState() => _BooksBodyState();
}

class _BooksBodyState extends State<BooksBody> {
  // final List<Book> books = [
  //   Book(name: "Germaniya tarixi", imagePath: "assets/images/history.png"),
  //   Book(name: "Angliya tarixi", imagePath: "assets/images/adabiyot.png"),
  //   Book(name: "O'rta Osiyo tarixi", imagePath: "assets/images/matematika.png"),
  //    Book(name: "Fransiya tarixi", imagePath: "assets/images/matematika.png"),
  // ];

  // final List<Color> backgroundColors = [
  //   Color(0xFFEAF8E5), // Yashil fon
  //   Color(0xFFFFF0E5), // Apelsin fon
  //   Color(0xFFFFE5E5), // Qizil fon

  //    Color.fromARGB(255, 204, 203, 246),
  // ];

  // final List<Color> borderColors = [
  //   Color(0xFF4CAF50), // Yashil ramka (Tarix)
  //   Color(0xFFFF9800), // Apelsin ramka (Adabiyot)
  //   Color(0xFFF44336), // Qizil ramka (Matematika)
  //    Color.fromARGB(255, 124, 118, 240),
  // ];

  @override
  void initState() {
    super.initState();
  }

  ToastService toastService = ToastService();
  void _openQRScanner(BuildContext context) async {
  final scannedCode = await showDialog(
    context: context,
    builder: (context) => QRScannerDialog(),
  );
 for (var i = 0; i < 5; i++) {
    print(">>>>");
 }
  print(scannedCode);

  if (scannedCode != null) {
    print('Scanned QR Code: $scannedCode');
    await showSuccessDialog(context, "Coca Cola 1.5L",12300);
     ScannerBloc scannerBloc = context.read<ScannerBloc>() ;

      scannerBloc.add({
    'id': 'C-20250428039',
    'category': 'Korzinka',
    'status': 'Tekshirilmoqda',
    'dateSent':  DateFormat("dd.MM.yyyy h:mma").format(DateTime.now()..add(Duration(hours: 5))),
    'entity': "Coca cola 1.5L",
    'dueDate': DateFormat("dd.MM.yyyy").format(DateTime.now().add(Duration(days: 30,hours: 5))),
     'price': '12,300 UZS', // Price added here
  // DateFormat("h:mma").format(date);
// 'dateSent':  '28.05.2025 – 10:42',
      });
    // Handle scanned result
  }
}





Future showSuccessDialog(BuildContext context, String serviceName, int? price) async{
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: EdgeInsets.only(top: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      actionsPadding: EdgeInsets.only(bottom: 10, right: 10),
      title: Column(
        children: [
          Icon(Icons.check_circle_rounded, color: Colors.green, size: 60),
          SizedBox(height: 10),
          Text(
            "Service Confirmed",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            serviceName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          if (price != null) ...[
            SizedBox(height: 8),
            Text(
              "Price: ${price.toString()} so'm",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.check),
          label: Text("OK"),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ),
  );
}
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: AppConstant.whiteColor,
      floatingActionButton: FloatingActionButton(onPressed: (){
      
_openQRScanner(context);
      }, child: Icon(Icons.qr_code_2_rounded,color: Colors.white,),backgroundColor:AppConstant.primaryColor ,),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocBuilder<ScannerBloc,List>(
          builder: (context, state) {
            List complaintData = state.reversed.toList();
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 16.h
              ),
              child: Column(children: List.generate(complaintData.length, (index)=>ComplaintCard(
               id: complaintData[index]['id']!,
                  category: complaintData[index]['category']!,
                  status: complaintData[index]['status']!,
                  dateSent: complaintData[index]['dateSent']!,
                  entity: complaintData[index]['entity']!,
                  dueDate: complaintData[index]['dueDate']!,
             price: complaintData[index]['price']!,
            ))));
          }
        ),
      ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final String id;
  final String category;
  final String status;
  final String dateSent;
  final String entity;
  final String dueDate;
   final String price;

  const ComplaintCard({
    super.key,
    required this.id,
    required this.category,
    required this.status,
    required this.dateSent,
    required this.entity,
    required this.dueDate,
    required this.price,
  });

   Color _getStatusColor(String status) {
    switch (status) {
      case 'Tekshirilmoqda':
        return Colors.blueAccent.shade100; // Yellow for "In progress"
      case 'Tasdiqlangan':
        return Colors.green.shade200; // Green for "Resolved"
      case 'Rad etilgan':
        return Colors.red.shade200; // Red for "Rejected"
      default:
        return Colors.blue.shade200; // Default for other statuses
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Card(
        shadowColor: Colors.transparent,
        color: const Color.fromARGB(255, 223, 238, 246),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        // elevation: 3,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            dividerColor: Colors.transparent,
          ),
          child: 
          
        ExpansionTile(
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              Text(id, style: TextStyle(fontSize: 14.sp)),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text("Murojaat yo'nalishi: ", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                  Text(category, style: TextStyle(fontSize: 13.sp)),
                ],
              ),
              SizedBox(height: 6.h),
              // Displaying price
              Row(
                children: [
                  Text("Narx: ", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                  Text(price, style: TextStyle(fontSize: 13.sp)),
                ],
              ),
              Row(
                children: [
                  Text("Holati: ", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                              color: _getStatusColor(status), // Dynamic background color

                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(status, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold,color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
          children: [
            SizedBox(height: 10.h),
            Row(
              children: [
                Text("Murojaat yo‘llangan sana: ", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                Text(dateSent, style: TextStyle(fontSize: 13.sp)),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Text("Xizmat subyekti: ", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                Text(entity, style: TextStyle(fontSize: 13.sp)),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Text("Ko‘rib chiqish muddati: ", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                Text(dueDate, style: TextStyle(fontSize: 13.sp)),
              ],
            ),
          ],
        ), ),
      ),
    );
  }
}
