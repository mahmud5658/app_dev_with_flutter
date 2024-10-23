class ServerURLSs {
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';
  static const String homeSliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoryListUrl = '$_baseUrl/CategoryList';
  static const String popularProductList =
      '$_baseUrl/ListProductByRemark/popular';
  static const String newProductList = '$_baseUrl/ListProductByRemark/new';
  static const String specialProductList =
      '$_baseUrl/ListProductByRemark/special';

  static String productListByCategoryUrl(String id) =>
      '$_baseUrl/ListProductByCategory/$id';

  static String productDetailsUrl(String id) =>
      '$_baseUrl/ProductDetailsById/$id';

  static String logInUrl({required String email}) =>
      '$_baseUrl/UserLogin/$email';

  static String authUrl({required String email, required String oTP}) =>
      '$_baseUrl/VerifyLogin/$email/$oTP';
  static const String readProfile = '$_baseUrl/ReadProfile';
  static const String createProfile = '$_baseUrl/CreateProfile';
  static const String createCart = '$_baseUrl/CreateCartList';
  static const String fetchCarts = '$_baseUrl/CartList';

  static String deleteCart({required String productId}) =>
      '$_baseUrl/DeleteCartList/$productId';
  static const String dummyImage =
      'https://images.pexels.com/photos/4439425/pexels-photo-4439425.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  static String addToWishList({required String productId}) => '$_baseUrl/CreateWishList/$productId';
  static const String fetchWishList = '$_baseUrl/ProductWishList';
  static String deleteFromWishList({required String productId}) => '$_baseUrl/RemoveWishList/$productId';
}
