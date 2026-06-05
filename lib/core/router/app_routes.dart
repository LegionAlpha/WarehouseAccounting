abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String addProduct = '/add-product';
  static const String users = '/users';
  static const String myBorrowed = '/my-borrowed';

  static const String catalog = '/catalog';
  static const String scan = '/scan';
  static const String profile = '/profile';

  static const String productDetailPattern = '/product/:id';
  static const String productQrPattern = '/product/:id/qr';

  static String productDetail(String id) => '/product/$id';
  static String productQr(String id) => '/product/$id/qr';
}
