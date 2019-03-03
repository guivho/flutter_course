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

const String EMAILPROMPT = 'Email:';
const String PASSWORDPROMPT = 'password:';

// for firebase api
const String FB_APIKEY = 'AIzaSyAp6DJzAFqy6zaKhThrFeT4dhnzUsm0-Fo';
const String FB_EMAIL = 'email';
const String FB_IDTOKEN = 'idToken';
const String FB_LOCALID = 'localId';
const String FB_REFRESCTOKEN = 'refreshToken';
const String FB_PASSWORD = 'password';
const String FB_RETURNSECURETOKEN = 'returnSecureToken';
const String FB_SIGNUP =
    'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=';
const String FB_SUCCESS = 'success';

enum DrawerType {
  fromListToAdmin,
  fromAdminToList,
}

enum CardType {
  list,
  info,
}
