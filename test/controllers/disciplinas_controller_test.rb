require 'test_helper'

class DisciplinasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get disciplinas_index_url
    assert_response :success
  end

  test "should get new" do
    get disciplinas_new_url
    assert_response :success
  end

  test "should get show" do
    get disciplinas_show_url
    assert_response :success
  end

  test "should get edit" do
    get disciplinas_edit_url
    assert_response :success
  end

end
