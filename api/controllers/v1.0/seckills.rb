# encoding: utf-8

# 秒杀相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/seckills' do
  before do
    load_api_request_params
  end

  # 秒杀商品列表
  # params 空
  # data
=begin
    [
        {
            "id": 1,
            "title": "bbb",  #秒杀标题
            "detail": "cccc",  #秒杀描述
            "num": 10,   #秒杀商品数量
            "status": "下架",  #状态： 发布（可正常秒杀），下架（不可秒杀），结束（不可秒杀）
            "begin_time": "2020-07-04 19:00:00",  #秒杀开始时间
            "end_time": "2020-08-14 22:00:00",  #秒杀结束时间
            "seckill_price": "59.0",    #秒杀价格
            "remaining_num": 10,    #剩余可秒杀数量
            "sku": {  #商品信息
                "id": 4,
                "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （1L装）",
                "sku_code": "AN01224234",
                "price": "89.0",
                "service_fee": null,
                "stock_num": 100,
                "images": [
                    "/uploads/t_sku/images/4/images/260811002.jpg",
                    "/uploads/t_sku/images/4/images/1336270541.jpg"
                ],
                "sale_attrs": {
                    "容量": "1L",
                    "粘度": "5W-40"
                },
                "attrs": {
                    "产地": "见瓶身",
                    "容量": "1L",
                    "毛重": 0.9,
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

      { status: 'succ', data: @merchant.seckills.map(&:to_api)}.to_json
    end
  end


  # 根据seckill_id，查询秒杀商品详情
  # params {"seckill_id": 1}
  # data
=begin
{
    "id": 1,
    "title": "bbb",  #秒杀标题
    "detail": "cccc",  #秒杀描述
    "num": 10,   #秒杀商品数量
    "status": "下架",  #状态： 发布（可正常秒杀），下架（不可秒杀），结束（不可秒杀）
    "begin_time": "2020-07-04 19:00:00",  #秒杀开始时间
    "end_time": "2020-08-14 22:00:00",  #秒杀结束时间
    "seckill_price": "59.0",    #秒杀价格
    "remaining_num": 10,    #剩余可秒杀数量
    "sku": {  #商品信息
        "id": 4,
        "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （1L装）",
        "sku_code": "AN01224234",
        "price": "89.0",
        "service_fee": null,
        "stock_num": 100,
        "images": [
            "/uploads/t_sku/images/4/images/260811002.jpg",
            "/uploads/t_sku/images/4/images/1336270541.jpg"
        ],
        "sale_attrs": {
            "容量": "1L",
            "粘度": "5W-40"
        },
        "attrs": {
            "产地": "见瓶身",
            "容量": "1L",
            "毛重": 0.9,
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
  post :seckill, :provides => [:json] do
    api_rescue do
      authenticate

      @group = @merchant.seckills.find(@request_params['seckill_id'])
      { status: 'succ', data: @group.to_api}.to_json
    end
  end
end
