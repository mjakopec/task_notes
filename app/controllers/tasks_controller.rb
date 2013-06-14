class TasksController < ApplicationController
before_filter :login_required
  # GET /tasks
  # GET /tasks.json
  def index
      @user  = User.find_by_email(session[:email])
      
        list = @user.linup.split(",").map { |s| s.to_i }
        @tasks = Task.find_all_by_id(list).sort_by{|x| list.index(x.id)}
          
    
    @task  = Task.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  def reorder_by(order, &key_proc)
    index_to_obj = inject({}) do |hash, obj|
      hash[key_proc.call(obj)] = obj
      hash
    end
    order.map do |x|
      index_to_obj[x]
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
        format.js
      else
        format.html { render action: "index" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task]) 
        format.html { redirect_to tasks, notice: 'Task was successfully updated.' }
        format.json { render json: @task, status: :updated, location: @task }
        format.js
      else
        format.html { render action: "index" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
      format.js
    end
  end

  def ordering_list
      User.find(:all, "email='#{params[:who]}'")
      User.update_all("linup = '#{params[:list_of]}'")
      head :ok #must know about redirect for ajax stay there
  end
end
