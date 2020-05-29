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
            "amount": "783.0",
            "skus": [
                {
                    "id": 5,
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
                    ],
                    "quantity": 1
                },
                {
                    "id": 6,
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
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                    "sku_code": "AN01224236",
                    "price": "159.0",
                    "stock_quantity": 10,
                    "weight": "0.9",
                    "pics": [
                        "images/260811002.jpg",
                        "images/1336270541.jpg"
                    ],
                    "attributes": [
                        {
                            "attr_name": "规格",
                            "attr_value": "1升"
                        },
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "0W-20"
                        }
                    ],
                    "quantity": 1
                },
                {
                    "id": 7,
                    "goods": {
                        "id": 3,
                        "description": "",
                        "category": {
                            "id": 3,
                            "parent_id": 1,
                            "name": "机油滤清器"
                        },
                        "pics": [
                            "images/260811002.jpg",
                            "images/1336270541.jpg"
                        ],
                        "desc_pics": [],
                        "attributes": [
                            {
                                "attr_name": "品牌",
                                "attr_value": "马勒/MAHLE"
                            },
                            {
                                "attr_name": "规格",
                                "attr_value": "只"
                            },
                            {
                                "attr_name": "场地",
                                "attr_value": "中国"
                            },
                            {
                                "attr_name": "机滤类型",
                                "attr_value": "机油滤清器"
                            }
                        ]
                    },
                    "sku_name": "马勒/MAHLE 机油滤清器 OC1480",
                    "sku_code": "AN01224240",
                    "price": "25.0",
                    "stock_quantity": 10,
                    "weight": "0.22",
                    "pics": [
                        "images/260811002.jpg",
                        "images/1336270541.jpg"
                    ],
                    "attributes": [],
                    "quantity": 1
                }
            ]
        },
        {
            "name": "大保养推荐套餐",
            "rtype": "性价比适配",
            "amount": "783.0",
            "skus": [
                {
                    "id": 5,
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
                    ],
                    "quantity": 1
                },
                {
                    "id": 6,
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
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                    "sku_code": "AN01224236",
                    "price": "159.0",
                    "stock_quantity": 10,
                    "weight": "0.9",
                    "pics": [
                        "images/260811002.jpg",
                        "images/1336270541.jpg"
                    ],
                    "attributes": [
                        {
                            "attr_name": "规格",
                            "attr_value": "1升"
                        },
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "0W-20"
                        }
                    ],
                    "quantity": 1
                },
                {
                    "id": 7,
                    "goods": {
                        "id": 3,
                        "description": "",
                        "category": {
                            "id": 3,
                            "parent_id": 1,
                            "name": "机油滤清器"
                        },
                        "pics": [
                            "images/260811002.jpg",
                            "images/1336270541.jpg"
                        ],
                        "desc_pics": [],
                        "attributes": [
                            {
                                "attr_name": "品牌",
                                "attr_value": "马勒/MAHLE"
                            },
                            {
                                "attr_name": "规格",
                                "attr_value": "只"
                            },
                            {
                                "attr_name": "场地",
                                "attr_value": "中国"
                            },
                            {
                                "attr_name": "机滤类型",
                                "attr_value": "机油滤清器"
                            }
                        ]
                    },
                    "sku_name": "马勒/MAHLE 机油滤清器 OC1480",
                    "sku_code": "AN01224240",
                    "price": "25.0",
                    "stock_quantity": 10,
                    "weight": "0.22",
                    "pics": [
                        "images/260811002.jpg",
                        "images/1336270541.jpg"
                    ],
                    "attributes": [],
                    "quantity": 1
                }
            ]
        },
        {
            "name": "大保养推荐套餐",
            "rtype": "性能适配",
            "amount": "783.0",
            "skus": [
                {
                    "id": 1,
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
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （4L装）",
                    "sku_code": "AN01224231",
                    "price": "329.0",
                    "stock_quantity": 10,
                    "weight": "3.62",
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
                            "attr_value": "5W-30"
                        }
                    ],
                    "quantity": 1
                },
                {
                    "id": 2,
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
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）",
                    "sku_code": "AN01224232",
                    "price": "89.0",
                    "stock_quantity": 10,
                    "weight": "0.92",
                    "pics": [
                        "images/260811002.jpg",
                        "images/1336270541.jpg"
                    ],
                    "attributes": [
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "5W-30"
                        },
                        {
                            "attr_name": "规格",
                            "attr_value": "1升"
                        }
                    ],
                    "quantity": 1
                },
                {
                    "id": 7,
                    "goods": {
                        "id": 3,
                        "description": "",
                        "category": {
                            "id": 3,
                            "parent_id": 1,
                            "name": "机油滤清器"
                        },
                        "pics": [
                            "images/260811002.jpg",
                            "images/1336270541.jpg"
                        ],
                        "desc_pics": [],
                        "attributes": [
                            {
                                "attr_name": "品牌",
                                "attr_value": "马勒/MAHLE"
                            },
                            {
                                "attr_name": "规格",
                                "attr_value": "只"
                            },
                            {
                                "attr_name": "场地",
                                "attr_value": "中国"
                            },
                            {
                                "attr_name": "机滤类型",
                                "attr_value": "机油滤清器"
                            }
                        ]
                    },
                    "sku_name": "马勒/MAHLE 机油滤清器 OC1480",
                    "sku_code": "AN01224240",
                    "price": "25.0",
                    "stock_quantity": 10,
                    "weight": "0.22",
                    "pics": [
                        "images/260811002.jpg",
                        "images/1336270541.jpg"
                    ],
                    "attributes": [],
                    "quantity": 1
                }
            ]
        }
    ]
=end
  post :recommends, :provides => [:json] do
    api_rescue do
      authenticate

      @recommends = Recommend.all
      datas = []
      name_rtypes = @recommends.map{|r| [r.name, r.rtype]}.uniq
      name_rtypes.each do |nr|
        skus = []
        amount = 0
        @recommends.where(name: nr[0], rtype: nr[1]).each do |r|
          sku = Sku.find(r.sku_id)
          sku_to_api = sku.to_api
          sku_to_api['quantity'] = r.quantity
          amount += r.quantity*sku.price
          skus << sku_to_api
        end
        datas << {name: nr[0],rtype: nr[1],amount: amount, skus: skus}
      end
      { status: 'succ', data: datas}.to_json
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

  # 查找商品
  # params {"category_id": 1, "name": "美孚"}  后续上线查询支持
  # data
=begin
    [
        {
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
            ],
            "skus": [
                {
                    "id": 1,
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （4L装）",
                    "sku_code": "AN01224231",
                    "price": "329.0",
                    "stock_quantity": 10,
                    "weight": "3.62",
                    "pics": [],
                    "attributes": [
                        {
                            "attr_name": "规格",
                            "attr_value": "4升"
                        },
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "5W-30"
                        }
                    ]
                },
                {
                    "id": 2,
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）",
                    "sku_code": "AN01224232",
                    "price": "89.0",
                    "stock_quantity": 10,
                    "weight": "0.92",
                    "pics": [],
                    "attributes": [
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "5W-30"
                        },
                        {
                            "attr_name": "规格",
                            "attr_value": "1升"
                        }
                    ]
                },
                {
                    "id": 3,
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
                    "sku_code": "AN01224233",
                    "price": "329.0",
                    "stock_quantity": 10,
                    "weight": "3.58",
                    "pics": [],
                    "attributes": [
                        {
                            "attr_name": "规格",
                            "attr_value": "4升"
                        },
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "5W-40"
                        }
                    ]
                },
                {
                    "id": 4,
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （1L装）",
                    "sku_code": "AN01224234",
                    "price": "89.0",
                    "stock_quantity": 10,
                    "weight": "0.91",
                    "pics": [],
                    "attributes": [
                        {
                            "attr_name": "规格",
                            "attr_value": "1升"
                        },
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "5W-40"
                        }
                    ]
                },
                {
                    "id": 5,
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
                    "sku_code": "AN01224235",
                    "price": "599.0",
                    "stock_quantity": 10,
                    "weight": "3.56",
                    "pics": [],
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
                },
                {
                    "id": 6,
                    "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                    "sku_code": "AN01224236",
                    "price": "159.0",
                    "stock_quantity": 10,
                    "weight": "0.9",
                    "pics": [],
                    "attributes": [
                        {
                            "attr_name": "规格",
                            "attr_value": "1升"
                        },
                        {
                            "attr_name": "粘稠度",
                            "attr_value": "0W-20"
                        }
                    ]
                }
            ]
        }
    ]
=end
  post :goods, :provides => [:json] do
    api_rescue do
      authenticate

      @goods = Goods.where(category_id: @request_params['category_id']) if @request_params['category_id'].present?
      @goods = @goods.where("name like '%#{@request_params['name']}%'") if @request_params['name'].present?
      { status: 'succ', data: @goods.map(&:to_api)}.to_json
    end
  end


  # 根据sku_id，查询商品详情
  # params {"sku_id": 1}
  # data
=begin
    {
        "id": 2,
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
        "sku_name": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）",
        "sku_code": "AN01224232",
        "price": "89.0",
        "stock_quantity": 10,
        "weight": "0.92",
        "pics": [
            "images/260811002.jpg",
            "images/1336270541.jpg"
        ],
        "attributes": [
            {
                "attr_name": "粘稠度",
                "attr_value": "5W-30"
            },
            {
                "attr_name": "规格",
                "attr_value": "1升"
            }
        ]
    }
=end
  post :sku, :provides => [:json] do
    api_rescue do
      authenticate

      @sku = Sku.find(@request_params['sku_id'])
      { status: 'succ', data: @sku.to_api}.to_json
    end
  end

end
