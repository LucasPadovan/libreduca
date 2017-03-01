require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  setup do
    @institution = Fabricate(:institution)
    @image = Fabricate(:image, institution_id: @institution.id)
    user = Fabricate(:user, password: '123456', roles: [:normal])
    job = Fabricate(
      :job, job: 'teacher', user_id: user.id, institution_id: @institution.id
    )
    @request.host = "#{@institution.identification}.lvh.me"

    sign_in user
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:images)
    assert_template 'images/index'
  end

  test 'should get new' do
    get :new
    assert_response :success
    assert_not_nil assigns(:image)
    assert_template 'images/new'
  end

  test 'should create image' do
    assert_difference('Image.count') do
      post :create, params: {
          image: Fabricate.attributes_for(
              :image, institution_id: @institution.id
          )
      }
    end

    assert_redirected_to image_url(assigns(:image))
  end

  test 'should create image with response in js' do
    assert_difference('Image.count') do
      post :create, params: {
          format: :js,
          image: Fabricate.attributes_for(
              :image, institution_id: @institution.id
          ),
          xhr: true
      }
    end

    assert_template 'images/create'
  end


  test 'should show image' do
    get :show, params: { id: @image }
    assert_response :success
    assert_not_nil assigns(:image)
    assert_template 'images/show'
  end

  test 'should get edit' do
    get :edit, params: { id: @image }
    assert_response :success
    assert_not_nil assigns(:image)
    assert_template 'images/edit'
  end

  test 'should update image' do
    assert_no_difference 'Image.count' do
      patch :update, params: { id: @image, image: { name: 'Updated' } }
    end

    assert_redirected_to image_url(assigns(:image))
    assert_equal 'Updated', @image.reload.name
  end

  test 'should destroy image' do
    assert_difference('Image.count', -1) do
      delete :destroy, params: { id: @image }
    end

    assert_redirected_to images_url
  end
end
