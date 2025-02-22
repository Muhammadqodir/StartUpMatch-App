// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feed_cubit.dart';

abstract class FeedState {}

class FeedLoading extends FeedState {}

class FeedInitial extends FeedState {}

class FeedError extends FeedState {
  final String title;
  final String message;
  FeedError({
    required this.title,
    required this.message,
  });
}

class FeedSuccess extends FeedState {
  List<Post> posts;
  int currentIndex = 0;
  FeedSuccess({
    required this.posts,
    required this.currentIndex,
  });

  List<SwipeItem> getSwipeItems(
      {required Function(int) onLike, required Function(int) onNope}) {
    List<SwipeItem> items = [];
    for (var element in posts) {
      items.add(
        SwipeItem(
          content: element,
          likeAction: () {
            onLike(element.id);
          },
          nopeAction: () {
            onNope(element.id);
          },
        ),
      );
    }
    return items;
  }

  int getIndexOfPost(Post post) {
    return posts.indexOf(post);
  }

  FeedSuccess copyWith({
    List<Post>? posts,
    int? currentIndex,
  }) {
    return FeedSuccess(
      posts: posts ?? this.posts,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
