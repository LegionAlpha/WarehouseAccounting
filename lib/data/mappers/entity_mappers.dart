import 'package:warehouse_accounting/data/local/app_database.dart';
import 'package:warehouse_accounting/data/local/daos/product_dao.dart';
import 'package:warehouse_accounting/domain/entities/app_user.dart';
import 'package:warehouse_accounting/domain/entities/product.dart';
import 'package:warehouse_accounting/domain/entities/product_log.dart';

extension UserRowMapper on UserRow {
  AppUser toEntity() => AppUser(
    id: id,
    name: name,
    email: email,
    role: role,
    createdAt: createdAt,
  );
}

extension ProductWithHolderMapper on ProductWithHolder {
  Product toEntity() => Product(
    id: product.id,
    name: product.name,
    description: product.description,
    status: product.status,
    createdBy: product.createdBy,
    createdAt: product.createdAt,
    imagePath: product.imagePath,
    takenByUserId: product.takenBy,
    takenByName: holderName,
    takenAt: product.takenAt,
  );
}

extension ProductLogWithUserMapper on ProductLogWithUser {
  ProductLog toEntity() => ProductLog(
    id: log.id,
    productId: log.productId,
    userId: log.userId,
    userName: userName,
    action: log.action,
    timestamp: log.timestamp,
  );
}
