// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feed_cubit.dart';

class FeedState {
  List<Post> posts;
  bool isLoading;
  FeedState({
    required this.posts,
    this.isLoading = true,
  });

  List<SwipeItem> getSwipeItems() {
    List<SwipeItem> items = [];
    for (var element in posts) {
      items.add(
        SwipeItem(
          content: element,
          likeAction: () {
            print("like");
          },
          nopeAction: () {
            print("nope");
          },
        ),
      );
    }
    return items;
  }

  int getIndexOfPost(Post post) {
    return posts.indexOf(post);
  }

  FeedState copyWith({
    List<Post>? posts,
    bool? isLoading,
    int? currentIndex,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
