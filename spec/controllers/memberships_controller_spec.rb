require 'rails_helper'

describe MembershipsController do
  before(:each) do
    @user_2 = create_user_2({admin: false})
    session[:user_id] = @user_2.id

    @project = create_project
    @membership = Membership.create!(project_id: @project.id, user_id: @user_2.id, role: "Owner")
  end


  describe "GET #index" do
    it "allows members to access memberships" do
      get :index, project_id: @project
      expect(response).to render_template(:index)
    end

    it "does not allow non-members to access memberships" do
      user = create_user({admin:false})
      session[:user_id] = user.id
      get :index, project_id: @project.id, user_id: @user_2.id
      expect(response).to_not render_template(project_memberships_path(@project.id))
      expect(response).to redirect_to projects_path
      expect(flash[:warning]).to eq "You do not have access to that project"
    end
  end

  describe "POST #create" do
    it "allows members to create memberships" do
      user = create_user({admin: false})
      expect{post :create, project_id: @project.id, membership:{user_id: user.id, role: "Owner"}}.to change{@project.memberships.all.count}.from(1).to(2)
      expect(response).to redirect_to (project_memberships_path(@project))
      expect(flash[:notice]).to eq "#{user.full_name} was successfully added"
    end

    it "does not allow non-member, non-admins to create memberships" do
      user = create_user({admin: false})
      session[:user_id] = user.id
      expect{post :create, project_id: @project.id, membership:{user_id: user.id, role: "Owner"}}.to_not change{@project.memberships.all.count}
      expect(response).to redirect_to (projects_path)
      expect(flash[:warning]).to eq "You do not have access to that project"
    end

  end

  describe "PATCH #update" do
    it "does not allow non-owners to update memberships" do
      user = create_user({admin: false})
      membership = Membership.create!(project_id: @project.id, user_id: user.id, role: "Member")
      session[:user_id] = user.id
      expect{patch :update, project_id: @project.id, id: membership.id, membership:{user_id: user.id, role: "Owner"}}.to_not change{@project.memberships.last.role}
      expect(response).to redirect_to (project_path(@project))
      expect(flash[:warning]).to eq "You do not have access"
    end

    it "allows owners/admins to update memberships" do
      user = create_user({admin: false})
      membership = Membership.create!(project_id: @project.id, user_id: user.id, role: "Member")
      expect{patch :update, project_id: @project.id, id: membership.id, membership:{user_id: user.id, role: "Owner"}}.to change{@project.memberships.last.role}.from("Member").to("Owner")
      expect(response).to redirect_to (project_memberships_path(@project))
      expect(flash[:notice]).to eq "#{user.full_name} was successfully updated"
    end

    it "does not allow the last owner to be updated to member" do
      expect{patch :update, project_id: @project.id, id: @membership.id, membership:{user_id: @user_2.id, role: "Member"}}.to_not change{@project.memberships.last.role}
      expect(response).to redirect_to (project_memberships_path(@project))
      expect(flash[:warning]).to eq "Projects must have at least one owner"
    end



  end

  describe "DELETE #destroy" do
    it "does not allow members to delete other members" do
      user = create_user({admin: false})
      user_3 = create_user({email: "joni@email.com"})
      membership = Membership.create!(project_id: @project.id, user_id: user.id, role: "Member")
      membership2 = Membership.create!(project_id: @project.id, user_id: user_3.id, role: "Member")
      session[:user_id] = user.id
      expect{delete :destroy, project_id: @project.id, id: membership2.id}.to_not change{@project.memberships.all.count}
      expect(response).to redirect_to (project_path(@project))
      expect(flash[:warning]).to eq "You do not have access"
    end

    it "allows members to delete themselves" do
      user = create_user({admin: false})
      membership = Membership.create!(project_id: @project.id, user_id: user.id, role: "Member")
      session[:user_id] = user.id
      expect{delete :destroy, project_id: @project.id, id: membership.id}.to change{@project.memberships.all.count}.by(-1)
      expect(response).to redirect_to (projects_path)
      expect(flash[:notice]).to eq "#{user.full_name} was successfully removed"
    end

    it "allows owners/admins to delete members/owners" do
      user = create_user
      membership = Membership.create!(project_id: @project.id, user_id: user.id, role: "Owner")
      session[:user_id] = user.id
      expect{delete :destroy, project_id: @project.id, id: @membership.id}.to change{@project.memberships.all.count}.by(-1)
      expect(response).to redirect_to (project_memberships_path(@project))
      expect(flash[:notice]).to eq "#{@user_2.full_name} was successfully removed"
    end

    it "does not allow the last owner to be deleted by anyone" do
      expect{delete :destroy, project_id: @project.id, id: @membership.id}.to_not change{@project.memberships.all.count}
      expect(response).to redirect_to (project_memberships_path(@project))
      expect(flash[:warning]).to eq "Projects must have at least one owner"
    end
  end
end
