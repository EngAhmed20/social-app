class MessageModel{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? Text;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.Text,

  });
  MessageModel.fromJson(Map<String,dynamic> json)
  {
    senderId=json['senderId'];
    receiverId=json['receiverId'];
    dateTime=json['dateTime'];
    Text=json['Text'];


  }
  Map<String,dynamic>toMap()
  {
    return{
      'Text':Text,
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
    };
  }
}