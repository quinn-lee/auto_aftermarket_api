# encoding: utf-8

# 拼团相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/groups' do
  before do
    load_api_request_params
  end

  # 团购商品列表
  # params 空
  # data
=begin
    [
        {
            "id": 1,
            "title": "aaa",  #拼团标题
            "detail": "bb",  #拼团描述
            "group_price": "100.0",  #团购价格
            "status": "下架",  #状态： 发布（到时间后可开始购买），下架（不可购买），成团（不可购买），未成团（不可购买）
            "begin_time": "2020-06-30 20:00:00",  #团购开始时间
            "end_time": "2020-07-02 20:00:00",  #团购结束时间
            "min_num": 5,  #最小成团人数
            "max_num": 15,  #最大成团人数
            "purchased_num": 0,  #已购买人数
            "sku": {  #商品信息
                "id": 3,
                "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
                "sku_code": "AN01224233",
                "price": "329.0",
                "service_fee": null,
                "stock_num": 100,
                "images": [
                    "/uploads/t_sku/images/3/images/260811002.jpg",
                    "/uploads/t_sku/images/3/images/1336270541.jpg"
                ],
                "sale_attrs": {
                    "容量": "4L",
                    "粘度": "5W-40"
                },
                "attrs": {
                    "产地": "见瓶身",
                    "容量": "4L",
                    "毛重": 3.5,
                    "粘度": "5W-40",
                    "保质期": "5年",
                    "机油种类": "全合成机油",
                    "机油等级": "SN",
                    "建议更换周期": "10000公里"
                },
                "detail": []
            }
        }
    ]
=end
  post "/", :provides => [:json] do
    api_rescue do
      authenticate

      { status: 'succ', data: @merchant.groups.map(&:to_api)}.to_json
    end
  end


  # 根据group_id，查询团购商品详情
  # params {"group_id": 1}
  # data
=begin
{
    "id": 1,
    "title": "aaa",  #拼团标题
    "detail": "bb",  #拼团描述
    "group_price": "100.0",  #团购价格
    "status": "下架",  #状态： 发布（到时间后可开始购买），下架（不可购买），成团（不可购买），未成团（不可购买）
    "begin_time": "2020-06-30 20:00:00",  #团购开始时间
    "end_time": "2020-07-02 20:00:00",  #团购结束时间
    "min_num": 5,  #最小成团人数
    "max_num": 15,  #最大成团人数
    "purchased_num": 0,  #已购买人数
    "sku": {  #商品信息
        "id": 3,
        "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
        "sku_code": "AN01224233",
        "price": "329.0",
        "service_fee": null,
        "stock_num": 100,
        "images": [
            "/uploads/t_sku/images/3/images/260811002.jpg",
            "/uploads/t_sku/images/3/images/1336270541.jpg"
        ],
        "sale_attrs": {
            "容量": "4L",
            "粘度": "5W-40"
        },
        "attrs": {
            "产地": "见瓶身",
            "容量": "4L",
            "毛重": 3.5,
            "粘度": "5W-40",
            "保质期": "5年",
            "机油种类": "全合成机油",
            "机油等级": "SN",
            "建议更换周期": "10000公里"
        },
        "detail": []
    }
}
=end
  post :group, :provides => [:json] do
    api_rescue do
      authenticate

      @group = @merchant.groups.find(@request_params['group_id'])
      { status: 'succ', data: @group.to_api}.to_json
    end
  end
end
