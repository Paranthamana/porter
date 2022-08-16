class SignInResponseModel{

  bool _isSuccess;
  String _message;

  SignInResponseModel(this._isSuccess, this._message);
  String get message=> _message;
  bool get isSuccess=> _isSuccess;
}