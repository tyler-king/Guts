require 'test_helper'

module Guts
  class GroupsControllerTest < ActionController::TestCase
    setup do
      @group  = guts_groups :test_group
      @routes = Engine.routes
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:groups)
    end

    test 'should get new' do
      get :new
      assert_response :success
    end

    test 'should create group' do
      assert_difference('Group.count') do
        post :create, group: { slug: 'group-test', title: 'Group Test' }
      end

      assert_redirected_to groups_path
      assert_equal 'Group was successfully created.', flash[:notice]
    end
    
    test 'should fail to create group and send back to new' do
      post :create, group: { title: '' }
      assert_template 'guts/groups/new'
    end

    test 'should show group' do
      get :show, id: @group
      assert_response :success
    end

    test 'should get edit' do
      get :edit, id: @group
      assert_response :success
    end

    test 'should update group' do
      patch :update, id: @group, group: { slug: @group.slug, title: @group.title }
      assert_redirected_to groups_path
      assert_equal 'Group was successfully updated.', flash[:notice]
    end
    
    test 'should fail to update group and send back to edit' do
      patch :update, id: @group, group: { title: '' }
      assert_template 'guts/groups/edit'
    end

    test 'should destroy group' do
      assert_difference('Group.count', -1) do
        delete :destroy, id: @group
      end

      assert_redirected_to groups_path
      assert_equal 'Group was successfully destroyed.', flash[:notice]
    end
  end
end
