class WorkflowsController < ApplicationController

  before_filter :find_workflows, :only => :index
  before_filter :paginate, :only => :index
  before_filter :filter, :only => :index
  before_filter :find_workflow, :only => [:show, :edit, :update, :destroy]
  before_filter :check_logged_in, :except => [:show, :index]
  #before_filter :authorization, :only => [:edit, :update, :destroy]

  # GET /workflows
  # GET /workflows.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workflows }
    end
  end

  # GET /workflows/1
  # GET /workflows/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workflow }
    end
  end

  # GET /workflows/new
  # GET /workflows/new.json
  def new
    @workflow = Workflow.new
    @workflow.build_policy
    @workflow.policy.permissions.build(:for_type => 'Public', :privilege => Authorization.privilege_level(:download))
    @workflow.policy.permissions.build(:for => current_user, :privilege => Authorization.privilege_level(:manage))

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @workflow }
    end
  end

  # GET /workflows/1/edit
  def edit
  end

  # POST /workflows
  # POST /workflows.json
  def create
    @workflow = Workflow.new(params[:workflow])
    @workflow.author = current_user

    respond_to do |format|
      if @workflow.save
        format.html { redirect_to @workflow, notice: 'Workflow was successfully created.' }
        format.json { render json: @workflow, status: :created, location: @workflow }
      else
        format.html { render action: "new" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workflows/1
  # PUT /workflows/1.json
  def update
    respond_to do |format|
      if @workflow.update_attributes(params[:workflow])
        format.html { redirect_to @workflow, notice: 'Workflow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflows/1
  # DELETE /workflows/1.json
  def destroy
    @workflow.destroy

    respond_to do |format|
      format.html { redirect_to workflows_url }
      format.json { head :no_content }
    end
  end

  private

  def find_workflow
    @workflow = Workflow.find(params[:id])

    unauthorized unless @workflow.can?(current_user, action_name)
  end

  def find_workflows
    @workflows = Workflow.with_privilege(current_user, :view).includes(:author)
  end

  def paginate
    params[:page] ||= '1'
    params[:per_page] ||= '10'

    @current_page = params[:page].to_i
    @per_page = params[:per_page].to_i
    @last_page = (@workflows.count / @per_page).ceil

    @workflows = @workflows.limit(@per_page).offset((@current_page-1) * @per_page)
  end

  def filter
    @workflows = @workflows.where("workflows.title LIKE ?","%#{params[:filter]}%") unless params[:filter].blank?
  end

end
