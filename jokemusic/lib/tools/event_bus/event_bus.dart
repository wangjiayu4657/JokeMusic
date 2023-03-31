import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

//购物车
class CartEventBus {
  String? text;
  CartEventBus({this.text});
}


//退出登录
class LogoutEventBus {

}

//地址
class AddressEventBus {

}
