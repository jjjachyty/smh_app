import 'package:event_bus/event_bus.dart';
import 'package:smh/models/resources.dart';
import 'package:smh/models/user.dart';

//Bus初始化
EventBus eventBus = EventBus();

class UserChangeEvent {
  UserChangeEvent();
}

class ToLogin {
  ToLogin();
}

// class UserLoggedOutEvent {
//   UserLoggedOutEvent();
// }

class ShowVideo {
  ShowVideo();
}

class PlayMoieEvent {
  VideoResources resources;
  PlayMoieEvent(this.resources);
}
