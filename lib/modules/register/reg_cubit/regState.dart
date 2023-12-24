
abstract class SocialRegState{}
class SocialRegInitialState extends SocialRegState{

}
class SocialRegLoadingState extends SocialRegState{

}
class SocialRegSucessState extends SocialRegState{



}
class SocialRegErrorState extends SocialRegState{
  final String error ;


  SocialRegErrorState(this.error);
}
class SocialRegShowPassState extends SocialRegState{}

class SocialCreateUserSucessState extends SocialRegState{

  final String uId;

  SocialCreateUserSucessState(this.uId);

}
class SocialCreateUserErrorState extends SocialRegState{
  final String error ;


  SocialCreateUserErrorState(this.error);
}