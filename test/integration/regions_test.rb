require 'test_helper'

class RegionsTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
  end
  
  test 'should add districts to region' do
    login
    
    visit new_region_path
    
    fill_in 'region_name', with: Fabricate.attributes_for(:region)['name']
    fill_in 'region_districts_attributes_0_name',
      with: Fabricate.attributes_for(:district)['name']
    
    click_link I18n.t('view.regions.new_district')
    
    page.has_css?('tbody > tr:nth-child(2)')
    
    within 'tbody > tr:nth-child(2)' do
      fill_in find('input[name$="[name]"]')[:id],
        with: Fabricate.attributes_for(:district)['name']
    end
    
    assert_difference 'Region.count' do
      assert_difference 'District.count', 2 do
        find('.btn.btn-primary').click
      end
    end
    
    assert_page_has_no_errors!
    assert page.has_css?('footer.alert')
    
    within 'footer.alert' do
      assert page.has_content?(I18n.t('view.regions.correctly_created'))
    end
  end
end