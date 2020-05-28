# encoding: utf-8

#汽车商品相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/skus' do
  before do
    load_api_request_params
  end

  # 根据车型和里程数 返回推荐套餐
  # params {"car_id": 1}
  # data
=begin
    [
      {
          "name": "大保养推荐套餐",
          "rtype": "默认适配",
          "quantity": 1,
          "sku": {
              "goods": {
                  "id": 2,
                  "description": "新老包装更替中，实物包装可能与图片略有差别",
                  "category": {
                      "id": 2,
                      "parent_id": 1,
                      "name": "机油"
                  },
                  "pics": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "desc_pics": [],
                  "attributes": [
                      {
                          "attr_name": "品牌",
                          "attr_value": "美孚/Mobil"
                      },
                      {
                          "attr_name": "基础油级别",
                          "attr_value": "全合成机油"
                      },
                      {
                          "attr_name": "机油等级",
                          "attr_value": "SN"
                      },
                      {
                          "attr_name": "适配发动机",
                          "attr_value": "汽油发动机"
                      }
                  ]
              },
              "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
              "sku_code": "AN01224235",
              "price": "599.0",
              "stock_quantity": 10,
              "weight": "3.56",
              "pics": [
                  "images/260811002.jpg",
                  "images/1336270541.jpg"
              ],
              "attributes": [
                  {
                      "attr_name": "规格",
                      "attr_value": "4升"
                  },
                  {
                      "attr_name": "粘稠度",
                      "attr_value": "0W-20"
                  }
              ]
          }
      }
    ]
=end
  post :recommends, :provides => [:json] do
    api_rescue do
      authenticate

      @recommends = Recommend.order(:rtype => :asc)
      { status: 'succ', data: @recommends.map(&:to_api)}.to_json
    end
  end

  # 返回目录结构
  # params 空
  # data
=begin
  [
    {
        "id": 1,
        "parent_id": null,
        "name": "常规保养",
        "sub": [
            {
                "id": 2,
                "parent_id": 1,
                "name": "机油"
            },
            {
                "id": 3,
                "parent_id": 1,
                "name": "机油滤清器"
            },
            {
                "id": 4,
                "parent_id": 1,
                "name": "空气滤清器"
            },
            {
                "id": 5,
                "parent_id": 1,
                "name": "燃油滤清器"
            },
            {
                "id": 6,
                "parent_id": 1,
                "name": "燃油系统养护"
            }
        ]
    },
    {
        "id": 7,
        "parent_id": null,
        "name": "刹车养护",
        "sub": [
            {
                "id": 8,
                "parent_id": 7,
                "name": "刹车油"
            },
            {
                "id": 9,
                "parent_id": 7,
                "name": "刹车片"
            },
            {
                "id": 10,
                "parent_id": 7,
                "name": "刹车盘"
            }
        ]
    }
  ]
=end
  post :categories, :provides => [:json] do
    api_rescue do
      authenticate

      { status: 'succ', data: Category.all_categories}.to_json
    end
  end

  # 查找子目录
  # params {"category_id": 1}
  # data
=begin
  [
      {
          "id": 2,
          "parent_id": 1,
          "name": "机油"
      },
      {
          "id": 3,
          "parent_id": 1,
          "name": "机油滤清器"
      },
      {
          "id": 4,
          "parent_id": 1,
          "name": "空气滤清器"
      },
      {
          "id": 5,
          "parent_id": 1,
          "name": "燃油滤清器"
      },
      {
          "id": 6,
          "parent_id": 1,
          "name": "燃油系统养护"
      }
  ]
=end
  post :sub_categories, :provides => [:json] do
    api_rescue do
      authenticate
      @categories = Category.where(parent_id: @request_params['category_id'])
      { status: 'succ', data: @categories.map(&:to_api)}.to_json
    end
  end

  

end
