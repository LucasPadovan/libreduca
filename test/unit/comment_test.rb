require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment = Fabricate(:comment)
    @forum = @comment.forum
    @user = @comment.user
  end
  
  test 'create' do
    assert_difference 'Comment.count' do
      @comment = @forum.comments.build(
        Fabricate.attributes_for(:comment).slice(
          *Comment.accessible_attributes
        )
      )
      @comment.user = @user

      assert @comment.save
    end
  end
  
  test 'update' do
    assert_difference 'Version.count' do
      assert_no_difference 'Comment.count' do
        assert @comment.update_attributes(comment: 'Updated')
      end
    end
    
    assert_equal 'Updated', @comment.reload.comment
  end
  
  test 'destroy' do
    assert_difference 'Version.count' do
      assert_difference('Comment.count', -1) { @comment.destroy }
    end
  end
  
  test 'validates blank attributes' do
    @comment.comment = ''
    
    assert @comment.invalid?
    assert_equal 1, @comment.errors.size
    assert_equal [error_message_from_model(@comment, :comment, :blank)],
      @comment.errors[:comment]
  end
end
