import 'package:flutter/material.dart';

class ChildMovement {
  final String id;
  final String title;
  final String location;
  final String date;
  final String amount;
  final bool isCredit;
  final IconData icon;
  final String category; // 'Transporte' or 'Alimentacion'
  final String? status;

  ChildMovement({
    required this.id,
    required this.title,
    required this.location,
    required this.date,
    required this.amount,
    required this.isCredit,
    required this.icon,
    required this.category,
    this.status,
  });
}

class ChildScholarship {
  final String id;
  final String title;
  final String type; // 'Alimentación', 'Estudio', 'Efectivo', 'Salud'
  final String monetaryAmount;
  final String periodicity; // 'Mensual', 'Anual', 'Semestral', 'Pago único'
  final String status;
  final Color statusColor;
  final Color textColor;
  final String description;
  final String nextPaymentDate;
  final bool canApplyOrRenew;

  ChildScholarship({
    required this.id,
    required this.title,
    required this.type,
    required this.monetaryAmount,
    required this.periodicity,
    required this.status,
    required this.statusColor,
    required this.textColor,
    required this.description,
    required this.nextPaymentDate,
    required this.canApplyOrRenew,
  });
}

class ChildProfile {
  final String id;
  final String name;
  final String rut;
  final String curso;
  final String establecimiento;
  final String? fechaNacimiento;
  final String image;
  int tneBalance;
  int baesBalance;
  final String tneCardNumber;
  final String baesCardNumber;
  final List<ChildMovement> tneMovements;
  final List<ChildMovement> baesMovements;
  final List<ChildScholarship> scholarships;

  ChildProfile({
    required this.id,
    required this.name,
    required this.rut,
    required this.curso,
    required this.establecimiento,
    this.fechaNacimiento,
    required this.image,
    required this.tneBalance,
    required this.baesBalance,
    required this.tneCardNumber,
    required this.baesCardNumber,
    required this.tneMovements,
    required this.baesMovements,
    required this.scholarships,
  });

  String get formattedTneBalance => '\$${tneBalance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  String get formattedBaesBalance => '\$${baesBalance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
}

class ParentDataStore extends ChangeNotifier {
  static final ParentDataStore instance = ParentDataStore._internal();
  ParentDataStore._internal();

  int _selectedChildIndex = 0;
  int get selectedChildIndex => _selectedChildIndex;

  void setSelectedChildIndex(int index) {
    if (index >= 0 && index < children.length) {
      _selectedChildIndex = index;
      notifyListeners();
    }
  }

  ChildProfile get activeChild => children[_selectedChildIndex];

  final List<ChildProfile> children = [
    ChildProfile(
      id: 'child_1',
      name: 'Camila Morales',
      rut: '21.345.678-9',
      curso: '2° Medio B',
      establecimiento: 'Liceo N° 1 Javiera Carrera',
      image: 'assets/images/pupilo_female.png',
      tneBalance: 2450,
      baesBalance: 48000,
      tneCardNumber: '9845-1234-77',
      baesCardNumber: '5412-8890-12',
      tneMovements: [
        ChildMovement(
          id: 'tne_1',
          title: 'Viaje Metro L1',
          location: 'Estación Baquedano',
          date: 'Hoy, 07:45 hrs',
          amount: '-\$240',
          isCredit: false,
          icon: Icons.subway_rounded,
          category: 'Transporte',
        ),
        ChildMovement(
          id: 'tne_2',
          title: 'Viaje Bus Red',
          location: 'Recorrido 506 (Hacia Liceo)',
          date: 'Ayer, 17:30 hrs',
          amount: '-\$240',
          isCredit: false,
          icon: Icons.directions_bus_rounded,
          category: 'Transporte',
        ),
        ChildMovement(
          id: 'tne_3',
          title: 'Recarga Online GetnetClick',
          location: 'Pago Web Apoderado',
          date: '18 Jul 2026, 21:10 hrs',
          amount: '+\$5.000',
          isCredit: true,
          icon: Icons.account_balance_wallet_rounded,
          category: 'Transporte',
        ),
        ChildMovement(
          id: 'tne_4',
          title: 'Viaje Metro L5',
          location: 'Estación Plaza de Armas',
          date: '17 Jul 2026, 14:20 hrs',
          amount: '-\$240',
          isCredit: false,
          icon: Icons.subway_rounded,
          category: 'Transporte',
        ),
      ],
      baesMovements: [
        ChildMovement(
          id: 'baes_1',
          title: 'Almuerzo PAE Casino',
          location: 'Casino Liceo N° 1',
          date: 'Hoy, 13:15 hrs',
          amount: '\$0 (Cobertura 100%)',
          isCredit: false,
          icon: Icons.restaurant_rounded,
          category: 'Alimentacion',
          status: 'Programa PAE',
        ),
        ChildMovement(
          id: 'baes_2',
          title: 'Supermercado Unimarc',
          location: 'Sucursal Alameda',
          date: '19 Jul 2026, 18:40 hrs',
          amount: '-\$14.500',
          isCredit: false,
          icon: Icons.shopping_cart_rounded,
          category: 'Alimentacion',
        ),
        ChildMovement(
          id: 'baes_3',
          title: 'Carga Mensual BAES',
          location: 'Mineduc / JUNAEB',
          date: '01 Jul 2026, 00:01 hrs',
          amount: '+\$48.000',
          isCredit: true,
          icon: Icons.savings_rounded,
          category: 'Alimentacion',
        ),
      ],
      scholarships: [
        ChildScholarship(
          id: 'sch_1',
          title: 'Beca BAES (Alimentación)',
          type: 'Alimentación',
          monetaryAmount: '\$48.000',
          periodicity: 'Mensual',
          status: 'Activa',
          statusColor: const Color(0xFFDCFCE7),
          textColor: const Color(0xFF15803D),
          description: 'Subsidio mensual alimenticio para estudiantes de educación media y superior.',
          nextPaymentDate: '01 de Agosto 2026',
          canApplyOrRenew: false,
        ),
        ChildScholarship(
          id: 'sch_2',
          title: 'Beca Bicentenario',
          type: 'Estudio',
          monetaryAmount: '\$1.150.000',
          periodicity: 'Anual',
          status: 'En Evaluación',
          statusColor: const Color(0xFFFEF3C7),
          textColor: const Color(0xFFB45309),
          description: 'Aporte económico para arancel y gastos de estudio de excelencia académica.',
          nextPaymentDate: 'Pendiente Resolución',
          canApplyOrRenew: true,
        ),
        ChildScholarship(
          id: 'sch_3',
          title: 'Servicios Médicos JUNAEB',
          type: 'Salud',
          monetaryAmount: 'Gratuito',
          periodicity: 'Anual',
          status: 'Agendado',
          statusColor: const Color(0xFFE0E7FF),
          textColor: const Color(0xFF4338CA),
          description: 'Control de salud oftálmica y entrega de lentes graduados sin costo.',
          nextPaymentDate: 'Cita: 28 de Julio 2026',
          canApplyOrRenew: false,
        ),
      ],
    ),
    ChildProfile(
      id: 'child_2',
      name: 'Javier Morales',
      rut: '22.456.789-0',
      curso: '8° Básico A',
      establecimiento: 'Colegio Barros Arana',
      image: 'assets/images/pupilo_male.png',
      tneBalance: 6800,
      baesBalance: 32500,
      tneCardNumber: '8812-4433-09',
      baesCardNumber: '6610-9941-55',
      tneMovements: [
        ChildMovement(
          id: 'tne_j1',
          title: 'Viaje Bus Red',
          location: 'Recorrido 210 (Av. Vicuña Mackenna)',
          date: 'Hoy, 08:10 hrs',
          amount: '-\$240',
          isCredit: false,
          icon: Icons.directions_bus_rounded,
          category: 'Transporte',
        ),
        ChildMovement(
          id: 'tne_j2',
          title: 'Recarga Presencial CajaVecina',
          location: 'Almacén Don Pedro',
          date: '20 Jul 2026, 19:15 hrs',
          amount: '+\$10.000',
          isCredit: true,
          icon: Icons.storefront_rounded,
          category: 'Transporte',
        ),
        ChildMovement(
          id: 'tne_j3',
          title: 'Viaje Metro L5',
          location: 'Estación Bellavista La Florida',
          date: '19 Jul 2026, 12:00 hrs',
          amount: '-\$240',
          isCredit: false,
          icon: Icons.subway_rounded,
          category: 'Transporte',
        ),
      ],
      baesMovements: [
        ChildMovement(
          id: 'baes_j1',
          title: 'Supermercado Lider',
          location: 'Sucursal Florida Center',
          date: '18 Jul 2026, 16:30 hrs',
          amount: '-\$15.500',
          isCredit: false,
          icon: Icons.shopping_bag_rounded,
          category: 'Alimentacion',
        ),
        ChildMovement(
          id: 'baes_j2',
          title: 'Panadería & Minimarket',
          location: 'San Juan Coquimbo',
          date: '15 Jul 2026, 11:20 hrs',
          amount: '-\$2.300',
          isCredit: false,
          icon: Icons.store_rounded,
          category: 'Alimentacion',
        ),
        ChildMovement(
          id: 'baes_j3',
          title: 'Carga Beca Presidente República',
          location: 'Depósito JUNAEB',
          date: '05 Jul 2026, 09:00 hrs',
          amount: '+\$62.000',
          isCredit: true,
          icon: Icons.savings_rounded,
          category: 'Alimentacion',
        ),
      ],
      scholarships: [
        ChildScholarship(
          id: 'sch_j1',
          title: 'Beca Presidente de la República',
          type: 'Efectivo',
          monetaryAmount: '\$62.000',
          periodicity: 'Mensual',
          status: 'Activa',
          statusColor: const Color(0xFFDCFCE7),
          textColor: const Color(0xFF15803D),
          description: 'Aporte de libre disposición asignado por rendimiento académico sobresaliente en educación básica y media.',
          nextPaymentDate: '05 de Agosto 2026',
          canApplyOrRenew: false,
        ),
        ChildScholarship(
          id: 'sch_j2',
          title: 'Beca Indígena (Básico)',
          type: 'Efectivo',
          monetaryAmount: '\$100.000',
          periodicity: 'Semestral',
          status: 'Asignada',
          statusColor: const Color(0xFFDBEAFE),
          textColor: const Color(0xFF1D4ED8),
          description: 'Aporte económico para estudiantes con ascendencia indígena acreditada por CONADI.',
          nextPaymentDate: '15 de Agosto 2026',
          canApplyOrRenew: false,
        ),
        ChildScholarship(
          id: 'sch_j3',
          title: 'Programa Alimentación Escolar (PAE)',
          type: 'Alimentación',
          monetaryAmount: '100% Cobertura',
          periodicity: 'Diaria',
          status: 'Activo',
          statusColor: const Color(0xFFDCFCE7),
          textColor: const Color(0xFF15803D),
          description: 'Ración de desayuno y almuerzo en casino escolar otorgada por JUNAEB.',
          nextPaymentDate: 'Diario en horario escolar',
          canApplyOrRenew: false,
        ),
      ],
    ),
  ];

  void rechargeTne(int childIndex, int amount, String paymentMethod) {
    if (childIndex >= 0 && childIndex < children.length) {
      final child = children[childIndex];
      child.tneBalance += amount;
      final now = DateTime.now();
      final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      child.tneMovements.insert(
        0,
        ChildMovement(
          id: 'tne_rec_${now.millisecondsSinceEpoch}',
          title: 'Recarga Online ($paymentMethod)',
          location: 'Apoderado App TNE',
          date: 'Hoy, $timeStr hrs',
          amount: '+\$${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
          isCredit: true,
          icon: Icons.add_card_rounded,
          category: 'Transporte',
        ),
      );
      notifyListeners();
    }
  }

  void addChild({
    required String name,
    required String rut,
    required String curso,
    required String establecimiento,
    String? fechaNacimiento,
  }) {
    children.add(
      ChildProfile(
        id: 'child_${children.length + 1}',
        name: name,
        rut: rut,
        curso: curso,
        establecimiento: establecimiento,
        fechaNacimiento: fechaNacimiento,
        image: name.trim().toLowerCase().endsWith('a') ? 'assets/images/pupilo_female.png' : 'assets/images/pupilo_male.png',
        tneBalance: 1000,
        baesBalance: 0,
        tneCardNumber: '9900-${DateTime.now().millisecond}-01',
        baesCardNumber: '5500-${DateTime.now().millisecond}-02',
        tneMovements: [],
        baesMovements: [],
        scholarships: [
          ChildScholarship(
            id: 'sch_new',
            title: 'Postulación en Curso',
            type: 'Estudio',
            monetaryAmount: 'En trámite',
            periodicity: 'Anual',
            status: 'Nueva',
            statusColor: const Color(0xFFFEF3C7),
            textColor: const Color(0xFFB45309),
            description: 'Vincúlate con JUNAEB para revisar becas disponibles para este alumno.',
            nextPaymentDate: 'Por definir',
            canApplyOrRenew: true,
          )
        ],
      ),
    );
    _selectedChildIndex = children.length - 1;
    notifyListeners();
  }
}
