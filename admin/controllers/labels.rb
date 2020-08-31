AutoAftermarketApi::Admin.controllers :labels do
  before do
    set_questions_title_and_local
  end

  # 优选标签列表
  get :preferred_labels do
    @labels = Label.all.where(ltype: 1).order("created_at asc")
    @labels_event = Label.all.where("ltype > 1").order("created_at asc")
    render "labels/preferred_labels"
  end

  # 创建标签
  post :create_preferred_label do
    begin
      @label = Label.new(params[:label])
      @label.ltype = 1
      if @label.save
        flash[:success] = "标签创建成功"
        redirect(url(:labels, :preferred_labels))
      else
        raise "标签创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:labels, :preferred_labels))
    end
  end

  # 修改标签名称
  post :update_preferred_label, :with => :label_id do
    begin
      @label = Label.find(params[:label_id])
      if @label.update!(params[:label])
        flash[:success] = "标签修改成功"
        redirect(url(:labels, :preferred_labels))
      else
        raise "标签修改失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:labels, :preferred_labels))
    end
  end

  post :update_event_label do
    begin
      @label = Label.find(params[:label_id])
      if @label.update!(params[:label])
        flash[:success] = "标签修改成功"
        redirect(url(:labels, :preferred_labels))
      else
        raise "标签修改失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:labels, :preferred_labels))
    end
  end

end
