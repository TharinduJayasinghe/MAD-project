import 'dart:convert';

import 'package:food_app_flutter_zone/src/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class CartModel extends Model{

List<Cart> _cart =[];
List<Cart> _order=[];
bool _isLoading = false;

 bool get isLoading {
    return _isLoading;
  }

  List<Cart> get cart {
    return List.from(_cart);
  }

 List<Cart> get order {
    return List.from(_order);
  }

  int get orderLength{
    return _order.length;
  }

  Future<bool> addCart(Cart cart) async{
  _isLoading = true;
  notifyListeners();
  try{
final Map<String, dynamic> cartData = {
        "mail": cart.mail,
        "title": cart.title,
        "qnt": cart.qnt,
        "orderDate": cart.orderDate,
        "address": cart.address,
        "price" : cart.price
      };
      final http.Response response = await http.post(
          "https://foodie-a4fc5.firebaseio.com/cart.json",
          body: json.encode(cartData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      Cart cartWithId = Cart(
        id: responeData["name"],
        title: cart.title,
        price: cart.price,
        qnt: cart.qnt,
        
      );

      _cart.add(cartWithId);
      _isLoading = false;
      notifyListeners();
      // fetchFoods();
      return Future.value(true);
  }catch(e)
  {
    _isLoading = false;
      notifyListeners();
      return Future.value(false);
  }

  }

  Future<bool> addOrder(Cart cart) async{
    _isLoading = true;
    notifyListeners();
  try{
      final Map<String, dynamic> cartData = {
        "mail": cart.mail,
        // "orderDate": cart.orderDate,
        "address": cart.address,
        "total" : cart.total
      };
      final http.Response response = await http.post(
          "https://foodie-a4fc5.firebaseio.com/order.json",
          body: json.encode(cartData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      Cart ordertWithId = Cart(
        id: responeData["name"],
        title: cart.address,
        price: cart.price,
        // qnt: cart.qnt,
      );
      deleteCart() ;
      _order.add(ordertWithId);
      _isLoading = false;
      notifyListeners();
      // fetchFoods();
      return Future.value(true);
      }catch(e)
    {
    _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> fetchCart() async{
     _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
          await http.get("https://foodie-a4fc5.firebaseio.com/cart.json");

      // print("Fecthing data: ${response.body}");
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Cart> cartItems = [];

      fetchedData.forEach((String id, dynamic cartData) {
        Cart cartItem = Cart(
          id: id,
          title: cartData["title"],
          qnt:cartData["qnt"] ,
          price: cartData["price"],
          
        );

        cartItems.add(cartItem);
      });

      _cart = cartItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      print("The errror: $error");
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> fetchOrder() async{
     _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
          await http.get("https://foodie-a4fc5.firebaseio.com/order.json");

      // print("Fecthing data: ${response.body}");
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Cart> cartItems = [];

      fetchedData.forEach((String id, dynamic cartData) {
        Cart cartItem = Cart(
          id: id,
          address: cartData["address"],
          mail:cartData["mail"] ,
          total: cartData["total"],
          
        );

        cartItems.add(cartItem);
      });

      _order = cartItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      print("The errror: $error");
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> deleteCart() async{
    _isLoading = true;
    notifyListeners();

    try{
      final http.Response response = await http.delete("https://foodie-a4fc5.firebaseio.com/cart.json");

      // delete item from the list of food items
      // _cart.removeWhere((Cart cart) => cart.id == cartId );


    _isLoading = false;
    notifyListeners();
    return Future.value(true);
    }catch(error){
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

}