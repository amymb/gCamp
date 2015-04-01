class PivotalApiController < PrivateController

  def show
    @pivotal_project_stories = PivotalApi.new.stories(current_user.tracker_token, params[:id])
    @project_name = params[:project_name]
  end
end
