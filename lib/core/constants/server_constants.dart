class ServerConstants {
  static const ticketUrl =
      "https://faro-faro-721376a5fee3.herokuapp.com/tickets";
  static const memberUrl =
      "https://faro-faro-721376a5fee3.herokuapp.com/members";
  static const eventUrl = "https://faro-faro-721376a5fee3.herokuapp.com/events";
  static const logInUrl = "https://faro-faro-721376a5fee3.herokuapp.com/login";
  static const signInUrl =
      "https://faro-faro-721376a5fee3.herokuapp.com/signup";
  static const logOutUrl =
      "https://faro-faro-721376a5fee3.herokuapp.com/logout";
  static const userUrl = "https://faro-faro-721376a5fee3.herokuapp.com/users";
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
