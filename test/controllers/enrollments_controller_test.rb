require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
  setup do
    sign_in Fabricate(:user)
  end

  test 'should send email summary' do
    enrollment = Fabricate(:enrollment)
    Fabricate(:kinship, user_id: enrollment.enrollable.id)

    assert_difference 'ActionMailer::Base.deliveries.size' do
      post :send_email_summary,
           user_id: enrollment.enrollable.id,
           id: enrollment.id,
           xhr: true
    end

    assert_response :success
    assert_template 'enrollments/send_email_summary'
  end
end
