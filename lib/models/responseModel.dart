/*
*
remember that the model is a custom data structure that is just more
* conveiniant to use so u can treat a bundle of data as one*/
class ResponseModel{
  bool _isSuccess;
  String _message;
/*
* notice that the constructor doesnt have the ({})
* without the {} u dont need requied and with it u have to
* make the vars public they cant be private
he's making them private to access them through getters and setters

* */
  ResponseModel(this._isSuccess,this._message);

  String get message => _message;
  bool get isSuccess => _isSuccess;



}