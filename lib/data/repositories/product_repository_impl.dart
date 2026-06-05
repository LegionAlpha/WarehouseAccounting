import 'dart:math';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:warehouse_accounting/data/local/app_database.dart';
import 'package:warehouse_accounting/data/local/daos/product_dao.dart';
import 'package:warehouse_accounting/data/mappers/entity_mappers.dart';
import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/domain/entities/product_log.dart';
import 'package:warehouse_accounting/domain/enums/log_action.dart';
import 'package:warehouse_accounting/domain/enums/product_status.dart';
import 'package:warehouse_accounting/domain/failures/app_exceptions.dart';
import 'package:warehouse_accounting/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required AppDatabase database, required Uuid uuid})
    : _db = database,
      _uuid = uuid;

  final AppDatabase _db;
  final Uuid _uuid;

  ProductDao get _products => _db.productDao;

  @override
  Stream<List<Product>> watchProducts() {
    return _products.watchProducts().map(
      (rows) => rows.map((r) => r.toEntity()).toList(),
    );
  }

  @override
  Stream<Product?> watchProduct(String id) {
    return _products.watchProduct(id).map((row) => row?.toEntity());
  }

  @override
  Future<Product?> findById(String id) async {
    final row = await _products.findById(id);
    return row?.toEntity();
  }

  @override
  Stream<List<Product>> watchProductsTakenBy(int userId) {
    return _products
        .watchProductsTakenBy(userId)
        .map((rows) => rows.map((r) => r.toEntity()).toList());
  }

  @override
  Stream<List<ProductLog>> watchHistory(String productId) {
    return _products
        .watchHistory(productId)
        .map((rows) => rows.map((r) => r.toEntity()).toList());
  }

  @override
  Future<Product> createProduct({
    required String name,
    required String description,
    required int createdBy,
    String? imagePath,
  }) async {
    final id = _uuid.v4();
    await _products.insertProduct(
      ProductsCompanion.insert(
        id: id,
        name: name.trim(),
        description: Value(description.trim()),
        imagePath: Value(imagePath),
        status: ProductStatus.available,
        createdBy: createdBy,
        createdAt: DateTime.now(),
      ),
    );
    final created = await _products.findById(id);
    return created!.toEntity();
  }

  static const _demoNames = <String>[
    'Дрель-шуруповёрт Bosch GSR 120-LI',
    'Перфоратор Makita HR2470',
    'УШМ (болгарка) DeWalt DWE4157',
    'Электролобзик Bosch PST 700 E',
    'Гайковёрт ударный Metabo SSW 685',
    'Циркулярная пила Bosch GKS 190',
    'Сварочный аппарат Resanta САИ-220',
    'Компрессор воздушный Fubag, 50 л',
    'Генератор бензиновый Huter DY6500L',
    'Тепловая пушка Ballu BHP-3',
    'Строительный пылесос Karcher WD 5',
    'Лазерный нивелир Bosch GLL 3-80',
    'Шуруповёрт аккумуляторный Makita DF333D',
    'Стремянка алюминиевая, 5 ступеней',
    'Тележка гидравлическая (рохля), 2.5 т',
    'Стеллаж металлический 2000×1000',
    'Ящик инструментальный, металл',
    'Набор отвёрток, 24 шт',
    'Рулетка измерительная, 10 м',
    'Каска защитная, белая',
    'Перчатки рабочие, нитрил (12 пар)',
    'Очки защитные, прозрачные',
    'Респиратор 3M 6200',
    'Удлинитель силовой, 50 м',
    'Кабель ВВГнг 3×2.5, бухта 100 м',
    'Краска фасадная, 25 кг',
    'Цемент М500, 50 кг',
    'Саморезы по дереву 4×50, 1000 шт',
    'Стрейч-плёнка упаковочная',
    'Скотч армированный, 50 мм',
    'Мешки строительные, 70 л (50 шт)',
    'Грунтовка глубокого проникновения, 10 л',
  ];

  static const _demoDescriptions = <String>[
    'Исправен, на гарантии.',
    'Б/у, рабочее состояние.',
    'Новый, в заводской упаковке.',
    'Требует проверки перед выдачей.',
    'Комплект полный. Хранение на стеллаже A-3.',
  ];

  @override
  Future<int> seedDemoProducts({
    required int count,
    required int createdBy,
  }) async {
    final rnd = Random();
    final now = DateTime.now();
    final names = [..._demoNames]..shuffle(rnd);

    final rows = <ProductsCompanion>[];
    for (var i = 0; i < count; i++) {
      final base = names[i % names.length];
      final name = i < names.length ? base : '$base (${i ~/ names.length + 1})';
      final createdAt = now.subtract(
        Duration(hours: i * 6 + rnd.nextInt(6), minutes: rnd.nextInt(60)),
      );
      final isTaken = rnd.nextInt(10) < 3;
      var takenAt = createdAt.add(Duration(hours: 1 + rnd.nextInt(24)));
      if (takenAt.isAfter(now)) takenAt = now;
      final code = 1000 + rnd.nextInt(9000);
      final description =
          '${_demoDescriptions[rnd.nextInt(_demoDescriptions.length)]} Арт. $code';

      rows.add(
        ProductsCompanion.insert(
          id: _uuid.v4(),
          name: name,
          description: Value(description),
          status: isTaken ? ProductStatus.taken : ProductStatus.available,
          createdBy: createdBy,
          createdAt: createdAt,
          takenBy: isTaken ? Value(createdBy) : const Value.absent(),
          takenAt: isTaken ? Value(takenAt) : const Value.absent(),
        ),
      );
    }

    await _products.insertProducts(rows);
    return rows.length;
  }

  @override
  Future<Product> takeProduct({
    required String productId,
    required int userId,
  }) {
    return _db.transaction(() async {
      final row = await _products.findRow(productId);
      if (row == null) {
        throw const ProductNotFoundException();
      }
      if (row.status == ProductStatus.taken) {
        throw ProductAlreadyTakenException(row.name);
      }

      final now = DateTime.now();
      await _products.markTaken(id: productId, userId: userId, at: now);
      await _products.insertLog(
        ProductLogsCompanion.insert(
          productId: productId,
          userId: userId,
          action: LogAction.taken,
          timestamp: now,
        ),
      );

      final updated = await _products.findById(productId);
      return updated!.toEntity();
    });
  }

  @override
  Future<Product> returnProduct({
    required String productId,
    required int userId,
  }) {
    return _db.transaction(() async {
      final row = await _products.findRow(productId);
      if (row == null) {
        throw const ProductNotFoundException();
      }
      if (row.status == ProductStatus.available) {
        final current = await _products.findById(productId);
        return current!.toEntity();
      }
      if (row.takenBy != userId) {
        throw NotBorrowerException(row.name);
      }

      final now = DateTime.now();
      await _products.markAvailable(productId);
      await _products.insertLog(
        ProductLogsCompanion.insert(
          productId: productId,
          userId: userId,
          action: LogAction.returned,
          timestamp: now,
        ),
      );

      final updated = await _products.findById(productId);
      return updated!.toEntity();
    });
  }
}
