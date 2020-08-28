AutoAftermarketApi::Admin.controllers :purchases do
  before do
    set_purchases_title
  end

  # 采购列表
  get :index do
    @purchases = current_account.merchant.purchases
    @purchases = @purchases.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'purchases/index'
  end

  # 采购详情
  get :show, :with => :id do
    @purchase = Purchase.find(params[:id])
    render 'purchases/show'
  end

  # 新增采购
  get :new do
    render 'purchases/new'
  end

  # 采购预览
  post :preview do
    begin
      raise "请填写采购说明" if params[:summary].blank?
      unless params[:upload_file] &&
           (tempfile = params[:upload_file][:tempfile]) &&
           (filename = params[:upload_file][:filename])
        raise "请上传文件"
      end
      @summary = params[:summary]
      # 保存文件
      uploaded_io = params[:upload_file]
      file_path = "public/uploads/tmp/purchases_uploaded#{Time.now.strftime('%Y%m%d%H%M%S')}#{filename}"
      File.open(file_path, 'wb') do |file|
        file.write(tempfile.read)
        file.close
        @file_path = file.path
      end
      # 获取文件内容
      File.open(@file_path, "r") do |f|
        xlsx = Roo::Spreadsheet.open(f)
        @spreadsheet = xlsx.sheet(0)
      end
      raise "采购信息文件内容不能为空" if @spreadsheet.last_row < 2
      render 'purchases/preview'
    rescue=>e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:purchases, :new))
    end
  end

  # 采购确认
  post :create do
    begin
      # 获取文件内容
      File.open(params[:file_path], "r") do |f|
        xlsx = Roo::Spreadsheet.open(f)
        @spreadsheet = xlsx.sheet(0)
        raise "采购信息文件内容不能为空" if @spreadsheet.last_row < 2
      end
      @purchase = Purchase.new(summary: params[:summary])
      @purchase.purchase_no = @purchase.gen_purchase_no
      code_info = []
      (2..@spreadsheet.last_row).each do |i|
        row = @spreadsheet.row(i)
        code_info << {sku_code: row[0].to_s.strip, quantity: row[1].to_s.strip}
      end
      @purchase.code_info = code_info
      @purchase.merchant_id = current_account.merchant_id
      @purchase.account_id = current_account.id
      ActiveRecord::Base.transaction do
        @purchase.save!
        @purchase.update_lack_orders!
      end
      flash[:success] = "新增采购成功"
      redirect(url(:purchases, :index))
    rescue=>e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:purchases, :new))
    end
  end
end
