class ServerConstants {
  static const serverUrl = "https://faro-faro-721376a5fee3.herokuapp.com";
  static const localhostUrl = "http://localhost:3001";
  static const ticketUrl = "$localhostUrl/tickets";
  static const memberUrl = "$localhostUrl/members";
  static const eventUrl = "$localhostUrl/events";
  static const logInUrl = "$localhostUrl/login";
  static const signInUrl = "$localhostUrl/signup";
  static const logOutUrl = "$localhostUrl/logout";
  static const userUrl = "$localhostUrl/users";
  static const requestResetTokenUrl = "$localhostUrl/password/forgot";
  static const resetPasswordUrl = "$localhostUrl/password/reset";
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
