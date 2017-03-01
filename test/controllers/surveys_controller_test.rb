require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  setup do
    @survey = Fabricate(:survey)
    @teach = @survey.teach
    @content = @survey.content
    @user = Fabricate(:user)

    sign_in @user
  end

  test 'should get teach index' do
    get :index, params: { teach_id: @teach }
    assert_response :success
    assert_not_nil assigns(:surveys)
    assert_not_nil assigns(:teach)
    assert_template 'surveys/index'
  end

  test 'should get content index' do
    get :index, params: { content_id: @content }
    assert_response :success
    assert_not_nil assigns(:surveys)
    assert_not_nil assigns(:content)
    assert_template 'surveys/index'
  end

  test 'should get teach index in csv' do
    get :index, params: { teach_id: @teach, format: :csv }
    assert_response :success
    assert_not_nil assigns(:surveys)

    assert CSV.parse(@response.body).size > 0
  end

  test 'should get new' do
    get :new, params: { content_id: @content }
    assert_response :success
    assert_not_nil assigns(:survey)
    assert_template 'surveys/new'
  end

  test 'should create survey' do
    assert_difference('Survey.count') do
      post :create, params: {
          content_id: @content,
          survey: Fabricate.attributes_for(:survey, content_id: nil)
      }
    end

    assert_redirected_to content_survey_url(@content, assigns(:survey))
  end

  test 'should show survey' do
    3.times do
      Fabricate(:question, survey_id: @survey.id).tap do |question|
        3.times { Fabricate(:answer, question_id: question.id) } unless question.text?
      end
    end

    get :show, params: { content_id: @content, id: @survey }
    assert_response :success
    assert_not_nil assigns(:survey)
    assert_template 'surveys/show'
  end

  test 'should show survey in csv' do
    get :show, params: { content_id: @content, id: @survey, format: :csv }
    assert_response :success
    assert_not_nil assigns(:survey)

    assert CSV.parse(@response.body).size > 0
  end

  test 'should get edit' do
    get :edit, params: { content_id: @content, id: @survey }
    assert_response :success
    assert_not_nil assigns(:survey)
    assert_template 'surveys/edit'
  end

  test 'should update survey' do
    patch :update, params: {
        content_id: @content,
        id: @survey,
        survey: Fabricate.attributes_for(:survey, content_id: nil).except(:content_id)
    }

    assert_redirected_to content_survey_url(@content, assigns(:survey))
  end

  test 'should destroy survey' do
    assert_difference('Survey.count', -1) do
      delete :destroy, params: { id: @survey, content_id: @content }
    end

    assert_redirected_to content_surveys_url(@content)
  end
end
