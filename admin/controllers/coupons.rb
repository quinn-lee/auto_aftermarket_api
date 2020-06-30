AutoAftermarketApi::Admin.controllers :coupons do
  before do
    set_coupons_title_and_local
  end

  # 新建优惠券
  get :new do
    @coupon = Coupon.new(merchant_id: current_account.merchant.id)
    render 'coupons/new'
  end

  # 新建优惠券
  post :create do
    begin
      @coupon = Coupon.new(params[:coupon])
      @coupon.created_by = current_account.id
      @coupon.status = 1
      if @coupon.save
        flash.now[:success] = "创建优惠券成功"
        redirect(url(:coupons, :new))
      else
        raise "创建优惠券失败"
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      render 'coupons/new'
    end
  end

end
