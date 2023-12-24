abstract class SocialStates{}
class SocialInatialState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialChangeBottomNav extends SocialStates{}
class SocialAddPostState extends SocialStates{}
class ImageProfilePickedSucess extends SocialStates{
}
class ImageProfilePickedError extends SocialStates{
}
class ImageCoverPickedSucess extends SocialStates{
}
class ImageCoverPickedError extends SocialStates{
}
class UploadImageCoverPickedSucess extends SocialStates{
}
class UploadImageCoverPickedError extends SocialStates{
}

class UploadImageProfilePickedSucess extends SocialStates{
}
class UploadImageProfilePickedError extends SocialStates{
}
class LoadingUpateUserState extends SocialStates{
}
class updateusererrorstate extends SocialStates{
  final String error;

  updateusererrorstate(this.error);
}
///////////////////////////////////////////////
/////post

class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSucessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class PostImagePickedSucess extends SocialStates{
}
class PostImagePickedError extends SocialStates{
}
class SocialRemovePostSucessState extends SocialStates{}

class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSucessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);

}
////////////likes
class SocialLikePostsLoadingState extends SocialStates{}
class SocialLikePostsSucessState extends SocialStates{}
class SocialLikePostsErrorState extends SocialStates{
  final String error;

  SocialLikePostsErrorState(this.error);

}
////////////////////////////get all user
class SocialGetallUserLoadingState extends SocialStates{}
class SocialGetallUserSuccessState extends SocialStates{}
class SocialGetallUserErrorState extends SocialStates{
  final String error;
  SocialGetallUserErrorState(this.error);
}
////////////////////////messgae
class SocialSendMessageSucessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}
class SocialGetMessageSucessState extends SocialStates{}
class SocialGetMessageErrorState extends SocialStates{
  final String error;
  SocialGetMessageErrorState(this.error);
}



