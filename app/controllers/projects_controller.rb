class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :update_status]

  def index
    @projects = Project.all.presence || [Project.create(name: "Sample project")]
  end

  def show
    @comments = @project.comments.order(created_at: :desc)
    @status_changes = @project.status_changes.order(created_at: :desc)
  end

  def update_status
    @project.update(status: params[:status])
    StatusChange.create!(user: current_user, project: @project, status: params[:status])
    redirect_to @project
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
