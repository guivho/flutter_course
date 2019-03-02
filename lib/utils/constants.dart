const String ADMIN = 'admin';
const String ADMINROUTE = '/$ADMIN';
const String AUTHROUTE = '/';
const String CONFIRMPASSWORD = 'Confirm password';
const String DBSERVER = 'https://flutter-products-8fcda.firebaseio.com/';
const String JSON = '.json';
const String NAME = 'name';
const String NOPRODUCTS = 'No products found';
const String PRODUCT = 'product';
const String PRODUCTROUTE = '/$PRODUCT';
const String PRODUCTS = 'products';
const String PRODUCTSROUTE = '/$PRODUCTS';

const String PRODUCTSURL = '$DBSERVER$PRODUCTS$JSON';

const String EMAIL = 'Email';
const String PASSWORD = 'Password';

enum DrawerType {
  fromListToAdmin,
  fromAdminToList,
}

enum CardType {
  list,
  info,
}
