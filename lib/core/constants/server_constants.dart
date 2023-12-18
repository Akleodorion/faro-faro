class ServerConstants {
  static const ticketUrl = 'http://192.168.1.21:3000/tickets';
  static const memberUrl = 'http://192.168.1.21:3000/members';
  static const eventUrl = 'http://192.168.1.21:3000/events';
  static const logInUrl = 'http://192.168.1.21:3000/login';
  static const signInUrl = 'http://192.168.1.21:3000/signup';
  static const logOutUrl = 'http://192.168.1.21:3000/logout';
  static const userUrl = "http://192.168.1.21:3000/users";
}

abstract class ServerEndPoint {
  String specificEndPoint();
}

class ServerEventConstants implements ServerEndPoint {
  ServerEventConstants({required this.eventId});
  final int eventId;

  static const eventUrl = ServerConstants.eventUrl;

  @override
  String specificEndPoint() {
    return "${ServerConstants.eventUrl}/$eventId";
  }

  String get activateEventUrl {
    return "${ServerConstants.eventUrl}/$eventId/update_activation";
  }

  String get closeEventUrl {
    return "${ServerConstants.eventUrl}/$eventId/update_close";
  }
}

class ServerTicketConstants extends ServerEndPoint {
  final int ticketId;

  ServerTicketConstants({required this.ticketId});

  static const ticketUrl = ServerConstants.ticketUrl;

  @override
  String specificEndPoint() {
    return "${ServerConstants.ticketUrl}/$ticketId";
  }
}

class ServerMembersConstants implements ServerEndPoint {
  ServerMembersConstants({required this.memberId});
  final int memberId;

  static const memberUrl = ServerConstants.memberUrl;

  @override
  String specificEndPoint() {
    return "${ServerConstants.memberUrl}/$memberId";
  }
}
