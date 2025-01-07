import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());

  void resume() {
    emit(VideoPlayerResumed());
  }

  void pause() {
    emit(VideoPlayerPaused());
  }
}
