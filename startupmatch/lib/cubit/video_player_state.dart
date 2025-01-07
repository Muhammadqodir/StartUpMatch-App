part of 'video_player_cubit.dart';

@immutable
sealed class VideoPlayerState {}

final class VideoPlayerInitial extends VideoPlayerState {}

final class VideoPlayerResumed extends VideoPlayerState {}

final class VideoPlayerPaused extends VideoPlayerState {}
