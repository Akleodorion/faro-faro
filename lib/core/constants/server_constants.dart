class ServerConstants {
  static const serverUrl = "https://faro-faro-721376a5fee3.herokuapp.com";
  static const localhostUrl =
      "http://10.0.2.2:3001"; // if android : 10.0.2.2:8000 , ios : http://localhost:3001
  static const ticketUrl = "$serverUrl/tickets";
  static const memberUrl = "$serverUrl/members";
  static const eventUrl = "$serverUrl/events";
  static const logInUrl = "$serverUrl/login";
  static const signInUrl = "$serverUrl/signup";
  static const logOutUrl = "$serverUrl/logout";
  static const userUrl = "$serverUrl/users";
  static const requestResetTokenUrl = "$serverUrl/password/forgot";
  static const resetPasswordUrl = "$serverUrl/password/reset";
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

  String get transferTicketUrl {
    return "${specificEndPoint()}/transfer_ticket";
  }

  String get validateTicketUrl {
    return "${specificEndPoint()}/validate_ticket";
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
