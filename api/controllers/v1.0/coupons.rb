# encoding: utf-8

# 优惠券相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/coupons' do
  before do
    load_api_request_params
  end

  # 优惠券列表
  # params 空
  # data
=begin
    [
        {
            "id": 1,
            "title": "保养专用优惠券",   #优惠券标题
            "remarks": "满1000元可用",   #优惠券说明
            "ctype": "满减券", # 满减券或折扣券
            "end_time": "2020-06-25 21:00:00",  #优惠券结束时间
            "money": "100.0",   #优惠券金额，满减券时，该字段有值
            "full_money": "2000.0",   #优惠券使用条件，订单金额满多少可使用，每个订单只可使用一张优惠券，满减券时，该字段有值
            "discount": null,  # 折扣券时，该字段有值，0-10之间
            "max_num": 10, # 可领取数量
            "received_num": 0,  # 已领取数量
            "spus": [  # 绑定spu 的id列表
                "1"
            ],
            "status": "下架",  #状态： 可领取，下架，已结束； 只有状态是可领取的，客户才能领取
            "img_path": "public/uploads/coupon/1.png" #图片位置
        }
    ]
=end
  post "/", :provides => [:json] do
    api_rescue do
      authenticate

      { status: 'succ', data: @merchant.coupons.where.not(title: "分享有礼优惠券").map(&:to_api)}.to_json
    end
  end

  # 优惠券详情
  # params {"id": 1}
  # data
=begin
    {
      "id": 1,
      "title": "保养专用优惠券",   #优惠券标题
      "remarks": "满1000元可用",   #优惠券说明
      "ctype": "满减券", # 满减券或折扣券
      "end_time": "2020-06-25 21:00:00",  #优惠券结束时间
      "money": "100.0",   #优惠券金额，满减券时，该字段有值
      "full_money": "2000.0",   #优惠券使用条件，订单金额满多少可使用，每个订单只可使用一张优惠券，满减券时，该字段有值
      "discount": null,  # 折扣券时，该字段有值，0-10之间
      "max_num": 10, # 可领取数量
      "received_num": 0,  # 已领取数量
      "spus": [  # 绑定spu 的id列表
          "1"
      ],
      "status": "下架",  #状态： 可领取，下架，已结束； 只有状态是可领取的，客户才能领取
      "img_path": "public/uploads/coupon/1.png" #图片位置
    }
=end
  post :show, :provides => [:json] do
    api_rescue do
      authenticate
      @coupon = @merchant.coupons.find(@request_params['id'])
      { status: 'succ', data: @coupon.to_api }.to_json
    end
  end

  # 分享有礼优惠券详情
  # params 空
  # data
=begin
    {
      "id": 1,
      "title": "分享有礼优惠券",   #优惠券标题
      "remarks": "满1000元可用",   #优惠券说明
      "ctype": "满减券", # 满减券或折扣券
      "end_time": "2020-06-25 21:00:00",  #优惠券结束时间
      "money": "100.0",   #优惠券金额，满减券时，该字段有值
      "full_money": "2000.0",   #优惠券使用条件，订单金额满多少可使用，每个订单只可使用一张优惠券，满减券时，该字段有值
      "discount": null,  # 折扣券时，该字段有值，0-10之间
      "max_num": 10, # 可领取数量
      "received_num": 0,  # 已领取数量
      "spus": [  # 绑定spu 的id列表
          "1"
      ],
      "status": "下架",  #状态： 可领取，下架，已结束； 只有状态是可领取的，客户才能领取
      "img_path": "public/uploads/coupon/1.png" #图片位置
    }
=end
  post :share_gift, :provides => [:json] do
    api_rescue do
      authenticate
      @coupon = @merchant.coupons.find_by(title: "分享有礼优惠券")
      { status: 'succ', data: @coupon.try{|c| c.to_api} }.to_json
    end
  end



  # 客户优惠券领取
  # params {"coupon_ids"=>[1,2,3]}
  # data 空
  post :receive, :provides => [:json] do
    api_rescue do
      ActiveRecord::Base.transaction do
        authenticate
        @request_params['coupon_ids'].each do |coupon_id|
          @coupon = Coupon.find(coupon_id)
          raise "该优惠券已过结束时间" if @coupon.end_time < Time.now
          raise "该优惠券不可领取" if @coupon.status != 1
          raise "该优惠券已被抢光" if @coupon.max_num.present? && @coupon.coupon_receives.count > @coupon.max_num
          raise "该客户已领取过该优惠券" if @coupon.coupon_receives.where(account_id: @customer.id).count > 0
          CouponReceive.create!(account_id: @customer.id, coupon_id: @coupon.id, coupon_money: @coupon.money, full_money: @coupon.full_money, discount: @coupon.discount, status: 0)
        end
      end
      { status: 'succ', data: {}}.to_json
    end
  end


  # 客户已领取优惠券
  # params {status: 0} #0表示已领取未使用，1表示已使用，2表示已过期； 为空时返回所有的优惠券
  # data
=begin
  [
      {
          "id": 1,
          "status": "已领取未使用", #状态： 已领取未使用，已使用，已过期;   优惠券是否可使用 需要同时满足状态为'已领取未使用'和时间未截止
          "coupon": {  # 优惠券信息
              "id": 1,
              "title": "ggg",
              "remarks": "gggggg",
              "end_time": "2020-07-01 12:00:00",
              "money": "100.0",
              "full_money": "2000.0",
              "status": "可领取"
          }
      }
  ]
=end
  post :received, :provides => [:json] do
    api_rescue do
      authenticate
      @coupon_receives = @customer.coupon_receives
      @coupon_receives = @coupon_receives.where(status: @request_params['status']) if @request_params['status'].present?
      { status: 'succ', data: @coupon_receives.map(&:to_api)}.to_json
    end
  end
end
