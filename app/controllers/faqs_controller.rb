class FaqsController < ApplicationController
  def index
    @common_questions = CommonQuestion.all
end

def CommonQuestion_params
  params[:commonquestion][:question]
  params[:commonquestion][:answer]
  params.require(:commonquestion).permit(:question, :answer)
end
end
