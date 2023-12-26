class MessageData {
  String? id;
  String? customerId;
  String? messageText;
  String? replyId;
  String? datetime;
  String? clientName;
  String? replyName;

  MessageData(
      {this.id,
      this.customerId,
      this.messageText,
      this.replyId,
      this.replyName,
      this.clientName,
      this.datetime});

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? '' : json['id'] as String;
    customerId =
        json['customer_id'] == null ? '' : json['customer_id'] as String;
    messageText =
        json['message_text'] == null ? '' : json['message_text'] as String;
    replyId = json['reply_id'] == null ? '' : json['reply_id'] as String;
    clientName = json['clientname'] == null ? '' : json['clientname'] as String;
    datetime = json['datetime'] == null ? '' : json['datetime'] as String;
    replyName = json['reply_name'] == null ? '' : json['reply_name'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['message_text'] = messageText;
    data['reply_id'] = replyId;
    data['datetime'] = datetime;
    data['clientname'] = clientName;
    data['reply_name'] = replyName;
    return data;
  }
}
