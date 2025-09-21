import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/CustomTextField.dart';

class CommentsReviewsPage extends StatefulWidget {
  final String recipeTitle;

  const CommentsReviewsPage({super.key, required this.recipeTitle});

  @override
  State<CommentsReviewsPage> createState() => _CommentsReviewsPageState();
}

class _CommentsReviewsPageState extends State<CommentsReviewsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  int _rating = 0;
  bool _isSubmittingReview = false;

  // Sample data
  final List<Comment> _comments = [
    Comment(
      id: '1',
      author: 'John Doe',
      authorImage: 'assets/pancake.png',
      content:
          'This recipe is amazing! I made it for dinner last night and my family loved it.',
      timestamp: '2 hours ago',
      likes: 12,
      isLiked: false,
    ),
    Comment(
      id: '2',
      author: 'Jane Smith',
      authorImage: 'assets/pancake.png',
      content:
          'Great recipe! I added some extra spices and it turned out perfect.',
      timestamp: '5 hours ago',
      likes: 8,
      isLiked: true,
    ),
    Comment(
      id: '3',
      author: 'Mike Johnson',
      authorImage: 'assets/pancake.png',
      content:
          'The instructions were very clear and easy to follow. Will definitely make again!',
      timestamp: '1 day ago',
      likes: 15,
      isLiked: false,
    ),
  ];

  final List<Review> _reviews = [
    Review(
      id: '1',
      author: 'Sarah Wilson',
      authorImage: 'assets/pancake.png',
      rating: 5,
      content:
          'Absolutely delicious! This recipe exceeded my expectations. The flavors are perfectly balanced and the instructions are easy to follow.',
      timestamp: '3 days ago',
      likes: 20,
      isLiked: false,
    ),
    Review(
      id: '2',
      author: 'David Brown',
      authorImage: 'assets/pancake.png',
      rating: 4,
      content:
          'Very good recipe. I made a few modifications based on what I had available, but it still turned out great.',
      timestamp: '1 week ago',
      likes: 14,
      isLiked: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Comments & Reviews',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTextStyles.body,
          tabs: const [
            Tab(text: 'Comments'),
            Tab(text: 'Reviews'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildCommentsTab(), _buildReviewsTab()],
      ),
    );
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [
        // Add Comment Section
        _buildAddCommentSection(),

        // Comments List
        Expanded(child: _buildCommentsList()),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      children: [
        // Add Review Section
        _buildAddReviewSection(),

        // Reviews List
        Expanded(child: _buildReviewsList()),
      ],
    );
  }

  Widget _buildAddCommentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add a Comment',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: '',
                  controller: _commentController,
                  hintText: 'Write a comment...',
                  maxLines: 3,
                  borderColor: AppColors.border,
                  focusedBorderColor: AppColors.primary,
                  borderradius: 12,
                ),
              ),
              const SizedBox(width: 12),
              CustomButton(
                text: 'Post',
                onPressed: _addComment,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                height: 40,
                borderradius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddReviewSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write a Review',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // Rating Section
          Row(
            children: [
              Text(
                'Rating: ',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              ...List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = index + 1),
                  child: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: AppColors.primary,
                    size: 24,
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 12),

          // Review Text
          CustomTextField(
            label: '',
            controller: _reviewController,
            hintText: 'Write your review...',
            maxLines: 4,
            borderColor: AppColors.border,
            focusedBorderColor: AppColors.primary,
            borderradius: 12,
          ),
          const SizedBox(height: 12),

          // Submit Button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: _isSubmittingReview ? 'Submitting...' : 'Submit Review',
                onPressed: _isSubmittingReview ? null : _addReview,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                height: 40,
                borderradius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsList() {
    if (_comments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.chat_bubble_outline,
        title: 'No Comments',
        subtitle: 'Be the first to comment on this recipe!',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _comments.length,
      itemBuilder: (context, index) {
        return _buildCommentCard(_comments[index]);
      },
    );
  }

  Widget _buildReviewsList() {
    if (_reviews.isEmpty) {
      return _buildEmptyState(
        icon: Icons.star_outline,
        title: 'No Reviews',
        subtitle: 'Be the first to review this recipe!',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        return _buildReviewCard(_reviews[index]);
      },
    );
  }

  Widget _buildCommentCard(Comment comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(comment.authorImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.author,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      comment.timestamp,
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Comment Content
          Text(comment.content, style: AppTextStyles.body),
          const SizedBox(height: 12),

          // Like Button
          Row(
            children: [
              GestureDetector(
                onTap: () => _toggleCommentLike(comment),
                child: Row(
                  children: [
                    Icon(
                      comment.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: comment.isLiked
                          ? Colors.red
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${comment.likes}',
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(review.authorImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.author,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      review.timestamp,
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Rating
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    color: AppColors.primary,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Review Content
          Text(review.content, style: AppTextStyles.body),
          const SizedBox(height: 12),

          // Like Button
          Row(
            children: [
              GestureDetector(
                onTap: () => _toggleReviewLike(review),
                child: Row(
                  children: [
                    Icon(
                      review.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: review.isLiked
                          ? Colors.red
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${review.likes}',
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textSecondary),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      author: 'You',
      authorImage: 'assets/pancake.png',
      content: _commentController.text.trim(),
      timestamp: 'Just now',
      likes: 0,
      isLiked: false,
    );

    setState(() {
      _comments.insert(0, newComment);
      _commentController.clear();
    });
  }

  void _addReview() {
    if (_reviewController.text.trim().isEmpty || _rating == 0) return;

    setState(() {
      _isSubmittingReview = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      final newReview = Review(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: 'You',
        authorImage: 'assets/pancake.png',
        rating: _rating,
        content: _reviewController.text.trim(),
        timestamp: 'Just now',
        likes: 0,
        isLiked: false,
      );

      setState(() {
        _reviews.insert(0, newReview);
        _reviewController.clear();
        _rating = 0;
        _isSubmittingReview = false;
      });
    });
  }

  void _toggleCommentLike(Comment comment) {
    setState(() {
      comment.isLiked = !comment.isLiked;
      comment.likes += comment.isLiked ? 1 : -1;
    });
  }

  void _toggleReviewLike(Review review) {
    setState(() {
      review.isLiked = !review.isLiked;
      review.likes += review.isLiked ? 1 : -1;
    });
  }
}

class Comment {
  final String id;
  final String author;
  final String authorImage;
  final String content;
  final String timestamp;
  int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.author,
    required this.authorImage,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.isLiked,
  });
}

class Review {
  final String id;
  final String author;
  final String authorImage;
  final int rating;
  final String content;
  final String timestamp;
  int likes;
  bool isLiked;

  Review({
    required this.id,
    required this.author,
    required this.authorImage,
    required this.rating,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.isLiked,
  });
}
