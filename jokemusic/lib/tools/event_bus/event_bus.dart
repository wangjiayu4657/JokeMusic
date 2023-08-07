import 'package:event_bus/event_bus.dart';
import '../../pages/home/widgets/home_item_page.dart';

EventBus bus = EventBus();

class LoginEvent {

}

class VideoRequestEvent {
 late HomeItemType homeItemType;

 VideoRequestEvent({
    this.homeItemType = HomeItemType.focus
 });

}