
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannerBloc extends Cubit<List> {
  ScannerBloc() : super([
  {
    'id': 'C-20250428001',
    'category': 'Kommunal soha',
    'status': 'Tekshirilmoqda',
    'dateSent': '28.04.2025 – 10:42',
    'entity': "ATTO",
    'dueDate': '28.05.2025',
     'price': '1,700 UZS', // Price added here
  },
  {
    'id': 'C-20250428002',
    'category': 'Savdo va xizmatlar',
    'status': 'Tasdiqlangan',
    'dateSent': '27.04.2025 – 14:30',
    'entity': "'SuperMarket 24/7'",
    'dueDate': '27.05.2025',
     'price': '150,000 UZS', // Price added here
  },
  {
    'id': 'C-20250428003',
    'category': 'Ta’lim sohasi',
    'status': 'Ko‘rib chiqilmoqda',
    'dateSent': '26.04.2025 – 09:20',
    'entity': "'Innovatsion Maktab'",
    'dueDate': '26.05.2025',
     'price': '240,000 UZS', // Price added here
  },
  {
    'id': 'C-20250428004',
    'category': 'Sog‘liqni saqlash',
    'status': 'Rad etilgan',
    'dateSent': '25.04.2025 – 16:50',
    'entity': "'Shifo Poliklinikasi'",
    'dueDate': '25.05.2025',
     'price': '25,000 UZS', // Price added here
  },
  {
    'id': 'C-20250428005',
    'category': 'Transport',
    'status': 'Tekshirilmoqda',
    'dateSent': '24.04.2025 – 13:10',
    'entity': "'AvtoLine Logistics'",
    'dueDate': '24.05.2025',
     'price': '480,000 UZS', // Price added here
  },
]
);

   add(Map item)  {
  
    emit([...state,item]);
  }
}
