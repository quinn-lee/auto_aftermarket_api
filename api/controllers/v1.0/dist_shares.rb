# encoding: utf-8

# 分销分享相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/dist_shares' do
  before do
    load_api_request_params
  end

  # 创建分享信息
  # params {"parent_id"=> 1, "activity_id"=>1, "coupon_id"=>1, "sku_id"=>1 }
  # 如果分享的是其他人分享的内容，则parent_id=别人分享的dist_share_id，如果是分销商第一次分享，则parent_id=null
  # activity_id 分享的活动id，coupon_id 分享的优惠券id， sku_id 分享的商品id
  # data {"dist_share_id": 1}
  post "/create", :provides => [:json] do
    api_rescue do
      authenticate
      if @request_params['activity_id'].blank? && @request_params['coupon_id'].blank? && @request_params['sku_id'].blank?
        raise "分享内容不能为空"
      end
      if @request_params['parent_id'].present?
        DistShare.find(@request_params['parent_id'])
      end
      @ds = DistShare.create!(account_id: @customer.id, parent_id: @request_params['parent_id'], activity_id: @request_params['activity_id'], coupon_id: @request_params['coupon_id'], sku_id: @request_params['sku_id'], merchant_id: @merchant.id)
      { status: 'succ', data: {dist_share_id: @ds.id}}.to_json
    end
  end
end
