require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  setup do
    @institution = Fabricate(:institution)
    @user = Fabricate(:user, password: '123456', roles: [:normal])
    @job = Fabricate(
      :job, user_id: @user.id, institution_id: @institution.id, job: 'teacher'
    )
    @request.host = "#{@institution.identification}.lvh.me"

    sign_in @user
  end

  test 'should get index presentation comments' do
    presentation = Fabricate(:presentation)

    get :index, params: { presentation_id: presentation }
    assert_response :success
    assert_not_nil assigns(:comments)
    assert_template 'comments/index'
  end

  test 'should create forum comment' do
    forum = Fabricate(:forum, owner_id: @institution.id)

    3.times.map { Fabricate(:job, institution_id: @institution.id) }
    counts = ['forum.comments.count', 'ActionMailer::Base.deliveries.size']

    assert_difference counts do
      post :create, params: {
          forum_id: forum.to_param,
          comment: Fabricate.attributes_for(
              :comment,
              commentable_id: nil,
              commentable_type: nil
          ),
          format: :js,
          xhr: true
      }
    end

    assert_response :success
    assert_not_nil assigns(:comment)
    assert_template 'comments/create'
  end

  test 'should create forum comment as student' do
    forum = Fabricate(:forum, owner_id: @institution.id)
    assert @job.update_attribute :job, 'student'

    assert_difference('forum.comments.count') do
      assert_no_difference 'ActionMailer::Base.deliveries.size' do
        post :create, params: {
            forum_id: forum.to_param,
            comment: Fabricate.attributes_for(
                :comment,
                commentable_id: nil,
                commentable_type: nil
            ),
            format: :js,
            xhr: true
        }
      end
    end

    assert_response :success
    assert_not_nil assigns(:comment)
    assert_template 'comments/create'
  end
end
