class PivotalApiController < PrivateController

  def show
    tracker = PivotalApi.new
    #@project_name = tracker.pivotal_tracker_project_name(tracker.projects(current_user.tracker_token), params[:id])
    @pivotal_project_stories = tracker.stories(current_user.tracker_token, params[:id])
    @project_name = params[:project_name]

  end
end
