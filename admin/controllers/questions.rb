AutoAftermarketApi::Admin.controllers :questions do
  before do
    set_questions_title_and_local
  end

  # 话题列表
  get :topics do
    @topics = Topic.all
    render "questions/topics"
  end

  # 创建话题
  post :create_topic do
    begin
      @topic = Topic.new(params[:topic])
      if @topic.save
        flash[:success] = "话题创建成功"
        redirect(url(:questions, :topics))
      else
        raise "话题创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:questions, :topics))
    end
  end

  # 修改话题名称
  post :update_topic, :with => :topic_id do
    begin
      @topic = Topic.find(params[:topic_id])
      if @topic.update!(params[:topic])
        flash[:success] = "话题修改成功"
        redirect(url(:questions, :topics))
      else
        raise "话题修改失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:questions, :topics))
    end
  end

  # 问题列表
  get :index do
    @questions = current_account.merchant.questions
    @topics = Topic.all
    @questions = @questions.where(topic_id: params[:topic_id]) if params[:topic_id].present?
    @questions = @questions.where("content like '%#{params[:content]}%'") if params[:content].present?
    @questions = @questions.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render "questions/index"
  end

  # 回复详情
  get :answers, :with => :id do
    @question = Question.find(params[:id])
    render "questions/answers"
  end

  # 回复详情
  get :answers, :with => :id do
    @question = Question.find(params[:id])
    render "questions/answers"
  end

  # 回复
  get :new_answer, :with => :id do
    @question = Question.find(params[:id])
    @answer = Answer.new(question_id: @question.id, account_id: current_account.id)
    render "questions/new_answer"
  end

  # 商家回复
  post :answer, :with => :id  do
    begin
      @question = Question.find(params[:id])
      @answer = Answer.new(params[:answer])
      raise "回复内容不能都为空" if @answer.content.blank? && @answer.images.blank?
      if @answer.save
        flash[:success] = "回复成功"
        redirect(url(:questions, :answers, :id => @question.id))
      else
        raise "回复失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render "questions/new_answer"
    end
  end


end
