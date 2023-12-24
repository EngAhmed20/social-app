abstract class SocialLoginState{}
class SocialLoginInitialState extends SocialLoginState{

}
class SocialLoginILoadingState extends SocialLoginState{

}
class SocialLoginSucessState extends SocialLoginState{
  final String uId;

  SocialLoginSucessState(this.uId);


}
class SocialLoginErrorState extends SocialLoginState{
  final String error ;

  SocialLoginErrorState(this.error);
}
class SocialLoginIShowPassState extends SocialLoginState{}
class GetUserSuccessState extends SocialLoginState {}
class GetUserErrorState extends SocialLoginState {
  final String error;

  GetUserErrorState(this.error);
}
class GetUserLoadingState extends SocialLoginState {}



