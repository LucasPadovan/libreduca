require 'test_helper'

class FilesControllerTest < ActionController::TestCase
  setup do
    @document = Fabricate(
      :document, file: fixture_file_upload('files/test.txt', 'text/plain')
    )
    job = Fabricate(:job, school_id: @document.school.id)
    user = job.user
    @school = @document.school

    sign_in user
  end
  
  test 'should download file' do
    get :download, path: @document.file.current_path.sub("#{PRIVATE_PATH}/", '')
    assert_response :success
    assert_equal(
      File.open(@document.file.current_path, encoding: 'ASCII-8BIT').read,
      @response.body
    )
  end
  
  test 'should not download file' do
    get :download, path: 'wrong/path.txt'
    assert_redirected_to root_url
    assert_equal I18n.t('view.documents.non_existent'), flash.notice
  end

  test 'should download for the owners school' do
    @request.host = "#{@school.identification}.lvh.me"

    get :download, path: @document.file.current_path.sub("#{PRIVATE_PATH}/", '')
    assert_response :success
    assert_equal(
      File.open(@document.file.current_path, encoding: 'ASCII-8BIT').read,
      @response.body
    )
  end

  test 'should not download for another school' do
    school = Fabricate(:school)
    @request.host = "#{school.identification}.lvh.me"

    get :download, path: @document.file.current_path.sub("#{PRIVATE_PATH}/", '')
    assert_redirected_to root_url
    assert_equal I18n.t('view.documents.non_existent'), flash.notice
  end
end
