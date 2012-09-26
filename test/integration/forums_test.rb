# encoding: utf-8

require 'test_helper'

class ForumsTest < ActionDispatch::IntegrationTest
  test 'should create a new forum' do
    institution = Fabricate(:institution)
    forum = Fabricate.build(:forum, owner_id: institution.id, owner_type: 'Institution')

    login_into_institution institution: institution, as: 'janitor'
    
    visit new_institution_forum_path(institution)
    
    fill_in Forum.human_attribute_name('name'), with: forum.name
    fill_in Forum.human_attribute_name('topic'), with: forum.topic
    fill_in Forum.human_attribute_name('info'), with: forum.info

    assert_difference ['institution.forums.count', 'ActionMailer::Base.deliveries.size'] do
      find('.btn.btn-primary').click
    end
  end
  
  test 'should create a comment' do
    institution = Fabricate(:institution)
    forum = Fabricate(:forum, owner_id: institution.id, owner_type: 'Institution')
    comment = Fabricate.build(:comment, forum_id: forum.id, user_id: nil)

    login_into_institution institution: institution
    
    visit institution_forum_path(institution, forum)
    
    assert_difference ['forum.comments.count', 'ActionMailer::Base.deliveries.size'] do
      within '#new_comment' do
        fill_in 'comment_comment', with: comment.comment

        find('.btn').click
      end

      assert page.has_no_css?('#new_comment')
    end
  end
end
