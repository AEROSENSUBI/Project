class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    @comment = @project.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @project, notice: 'Comment added.'
    else
      redirect_to @project, alert: 'Comment could not be added.'
    end
  end

  def destroy
    @comment = @project.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user
    redirect_to @project
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.permit(:content)
  end
end

