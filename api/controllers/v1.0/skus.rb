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
          "amount": "1047.0",
          "skus": [
              {
                  "id": 5,
                  "spus": {
                      "id": 1,
                      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
                      "category": {
                          "id": 7,
                          "parent_id": 1,
                          "name": "机油"
                      },
                      "brand": {
                          "id": 1,
                          "name": "美孚",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": "新老包装更替中，实物包装可能与图片略有差别"
                  },
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
                  "sku_code": "AN01224235",
                  "price": "559.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "4L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "4L",
                      "毛重": 3.5,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  },
                  "quantity": 1
              },
              {
                  "id": 6,
                  "spus": {
                      "id": 1,
                      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
                      "category": {
                          "id": 7,
                          "parent_id": 1,
                          "name": "机油"
                      },
                      "brand": {
                          "id": 1,
                          "name": "美孚",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": "新老包装更替中，实物包装可能与图片略有差别"
                  },
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                  "sku_code": "AN01224236",
                  "price": "159.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "1L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "1L",
                      "毛重": 0.9,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  },
                  "quantity": 1
              },
              {
                  "id": 7,
                  "spus": {
                      "id": 2,
                      "title": "马勒/MAHLE 机油滤清器",
                      "category": {
                          "id": 10,
                          "parent_id": 1,
                          "name": "机油滤清"
                      },
                      "brand": {
                          "id": 10,
                          "name": "马勒",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": ""
                  },
                  "title": "马勒/MAHLE 机油滤清器 OC1480",
                  "sku_code": "AN01224241",
                  "price": "329.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {},
                  "attrs": {
                      "产地": "见瓶身",
                      "毛重": 3.5
                  },
                  "quantity": 1
              }
          ]
      },
      {
          "name": "大保养推荐套餐",
          "rtype": "性价比适配",
          "amount": "1047.0",
          "skus": [
              {
                  "id": 5,
                  "spus": {
                      "id": 1,
                      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
                      "category": {
                          "id": 7,
                          "parent_id": 1,
                          "name": "机油"
                      },
                      "brand": {
                          "id": 1,
                          "name": "美孚",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": "新老包装更替中，实物包装可能与图片略有差别"
                  },
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
                  "sku_code": "AN01224235",
                  "price": "559.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "4L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "4L",
                      "毛重": 3.5,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  },
                  "quantity": 1
              },
              {
                  "id": 6,
                  "spus": {
                      "id": 1,
                      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
                      "category": {
                          "id": 7,
                          "parent_id": 1,
                          "name": "机油"
                      },
                      "brand": {
                          "id": 1,
                          "name": "美孚",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": "新老包装更替中，实物包装可能与图片略有差别"
                  },
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                  "sku_code": "AN01224236",
                  "price": "159.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "1L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "1L",
                      "毛重": 0.9,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  },
                  "quantity": 1
              },
              {
                  "id": 7,
                  "spus": {
                      "id": 2,
                      "title": "马勒/MAHLE 机油滤清器",
                      "category": {
                          "id": 10,
                          "parent_id": 1,
                          "name": "机油滤清"
                      },
                      "brand": {
                          "id": 10,
                          "name": "马勒",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": ""
                  },
                  "title": "马勒/MAHLE 机油滤清器 OC1480",
                  "sku_code": "AN01224241",
                  "price": "329.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {},
                  "attrs": {
                      "产地": "见瓶身",
                      "毛重": 3.5
                  },
                  "quantity": 1
              }
          ]
      },
      {
          "name": "大保养推荐套餐",
          "rtype": "性能适配",
          "amount": "1047.0",
          "skus": [
              {
                  "id": 5,
                  "spus": {
                      "id": 1,
                      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
                      "category": {
                          "id": 7,
                          "parent_id": 1,
                          "name": "机油"
                      },
                      "brand": {
                          "id": 1,
                          "name": "美孚",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": "新老包装更替中，实物包装可能与图片略有差别"
                  },
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
                  "sku_code": "AN01224235",
                  "price": "559.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "4L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "4L",
                      "毛重": 3.5,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  },
                  "quantity": 1
              },
              {
                  "id": 6,
                  "spus": {
                      "id": 1,
                      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
                      "category": {
                          "id": 7,
                          "parent_id": 1,
                          "name": "机油"
                      },
                      "brand": {
                          "id": 1,
                          "name": "美孚",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": "新老包装更替中，实物包装可能与图片略有差别"
                  },
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                  "sku_code": "AN01224236",
                  "price": "159.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "1L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "1L",
                      "毛重": 0.9,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  },
                  "quantity": 1
              },
              {
                  "id": 7,
                  "spus": {
                      "id": 2,
                      "title": "马勒/MAHLE 机油滤清器",
                      "category": {
                          "id": 10,
                          "parent_id": 1,
                          "name": "机油滤清"
                      },
                      "brand": {
                          "id": 10,
                          "name": "马勒",
                          "detail": null,
                          "image": null,
                          "letter": "M"
                      },
                      "detail": ""
                  },
                  "title": "马勒/MAHLE 机油滤清器 OC1480",
                  "sku_code": "AN01224241",
                  "price": "329.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {},
                  "attrs": {
                      "产地": "见瓶身",
                      "毛重": 3.5
                  },
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
          sku = TSku.find(r.t_sku_id)
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
            "name": "维修保养",
            "brands": [],
            "attributes": [],
            "sub": [
                {
                    "id": 7,
                    "parent_id": 1,
                    "name": "机油",
                    "brands": [
                        {
                            "id": 1,
                            "name": "美孚",
                            "detail": null,
                            "image": null,
                            "letter": "M"
                        },
                        {
                            "id": 2,
                            "name": "壳牌",
                            "detail": null,
                            "image": null,
                            "letter": "Q"
                        },
                        {
                            "id": 3,
                            "name": "嘉实多",
                            "detail": null,
                            "image": null,
                            "letter": "J"
                        },
                        {
                            "id": 4,
                            "name": "道达尔",
                            "detail": null,
                            "image": null,
                            "letter": "D"
                        },
                        {
                            "id": 5,
                            "name": "本田",
                            "detail": null,
                            "image": null,
                            "letter": "B"
                        },
                        {
                            "id": 6,
                            "name": "力魔",
                            "detail": null,
                            "image": null,
                            "letter": "L"
                        },
                        {
                            "id": 7,
                            "name": "丰田",
                            "detail": null,
                            "image": null,
                            "letter": "F"
                        },
                        {
                            "id": 8,
                            "name": "长城",
                            "detail": null,
                            "image": null,
                            "letter": "C"
                        },
                        {
                            "id": 9,
                            "name": "昆仑",
                            "detail": null,
                            "image": null,
                            "letter": "K"
                        }
                    ],
                    "attributes": [
                        {
                            "name": "容量",
                            "numeric": true,
                            "generic": true,
                            "selling": true,
                            "searching": true,
                            "unit": "升",
                            "values": [
                                "6",
                                "5",
                                "4",
                                "1"
                            ]
                        },
                        {
                            "name": "粘度",
                            "numeric": false,
                            "generic": true,
                            "selling": true,
                            "searching": true,
                            "unit": null,
                            "values": [
                                "0W-30",
                                "0W-40",
                                "1W-30",
                                "10W-40",
                                "10W-50",
                                "10W-60",
                                "15W-40",
                                "20W-40",
                                "5W-30",
                                "5W-40",
                                "5W-50",
                                "0W-20",
                                "20W-50",
                                "5W-20",
                                "20W-60",
                                "15W-50",
                                "0W-16",
                                "85W-140"
                            ]
                        },
                        {
                            "name": "机油种类",
                            "numeric": false,
                            "generic": true,
                            "selling": false,
                            "searching": true,
                            "unit": null,
                            "values": [
                                "全合成机油",
                                "半合成机油",
                                "矿物质机油",
                                "PAO类全合成基础油"
                            ]
                        },
                        {
                            "name": "毛重",
                            "numeric": true,
                            "generic": true,
                            "selling": false,
                            "searching": false,
                            "unit": "千克",
                            "values": []
                        },
                        {
                            "name": "产地",
                            "numeric": false,
                            "generic": true,
                            "selling": false,
                            "searching": false,
                            "unit": null,
                            "values": []
                        },
                        {
                            "name": "机油等级",
                            "numeric": false,
                            "generic": true,
                            "selling": false,
                            "searching": false,
                            "unit": null,
                            "values": []
                        },
                        {
                            "name": "建议更换周期",
                            "numeric": true,
                            "generic": true,
                            "selling": false,
                            "searching": false,
                            "unit": "公里",
                            "values": []
                        },
                        {
                            "name": "保质期",
                            "numeric": true,
                            "generic": true,
                            "selling": false,
                            "searching": false,
                            "unit": "年",
                            "values": []
                        }
                    ]
                },
                {
                    "id": 8,
                    "parent_id": 1,
                    "name": "添加剂",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 9,
                    "parent_id": 1,
                    "name": "防冻液",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 10,
                    "parent_id": 1,
                    "name": "机油滤清",
                    "brands": [
                        {
                            "id": 7,
                            "name": "丰田",
                            "detail": null,
                            "image": null,
                            "letter": "F"
                        },
                        {
                            "id": 10,
                            "name": "马勒",
                            "detail": null,
                            "image": null,
                            "letter": "M"
                        },
                        {
                            "id": 11,
                            "name": "博世",
                            "detail": null,
                            "image": null,
                            "letter": "B"
                        },
                        {
                            "id": 12,
                            "name": "曼牌滤清器",
                            "detail": null,
                            "image": null,
                            "letter": "M"
                        }
                    ],
                    "attributes": [
                        {
                            "name": "毛重",
                            "numeric": true,
                            "generic": true,
                            "selling": false,
                            "searching": false,
                            "unit": "千克",
                            "values": []
                        },
                        {
                            "name": "产地",
                            "numeric": false,
                            "generic": true,
                            "selling": false,
                            "searching": false,
                            "unit": null,
                            "values": []
                        }
                    ]
                },
                {
                    "id": 11,
                    "parent_id": 1,
                    "name": "空气滤清",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 12,
                    "parent_id": 1,
                    "name": "空调滤清",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 13,
                    "parent_id": 1,
                    "name": "燃油滤清",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 14,
                    "parent_id": 1,
                    "name": "汽车照明",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 15,
                    "parent_id": 1,
                    "name": "雨刷",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 16,
                    "parent_id": 1,
                    "name": "空调制冷剂",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 17,
                    "parent_id": 1,
                    "name": "火花塞",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 18,
                    "parent_id": 1,
                    "name": "蓄电池",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 19,
                    "parent_id": 1,
                    "name": "刹车油",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 20,
                    "parent_id": 1,
                    "name": "刹车盘",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 21,
                    "parent_id": 1,
                    "name": "刹车片",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 22,
                    "parent_id": 1,
                    "name": "变速箱油",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 23,
                    "parent_id": 1,
                    "name": "减震器",
                    "brands": [],
                    "attributes": []
                }
            ]
        },
        {
            "id": 2,
            "parent_id": null,
            "name": "轮胎配件",
            "brands": [],
            "attributes": [],
            "sub": [
                {
                    "id": 24,
                    "parent_id": 2,
                    "name": "轮胎",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 25,
                    "parent_id": 2,
                    "name": "轮毂",
                    "brands": [],
                    "attributes": []
                }
            ]
        },
        {
            "id": 3,
            "parent_id": null,
            "name": "车载电器",
            "brands": [],
            "attributes": [],
            "sub": [
                {
                    "id": 26,
                    "parent_id": 3,
                    "name": "行车记录仪",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 27,
                    "parent_id": 3,
                    "name": "车载吸尘器",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 28,
                    "parent_id": 3,
                    "name": "车载冰箱",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 29,
                    "parent_id": 3,
                    "name": "车载充电器",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 30,
                    "parent_id": 3,
                    "name": "车载净化器",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 31,
                    "parent_id": 3,
                    "name": "胎压监测",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 32,
                    "parent_id": 3,
                    "name": "充气泵",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 33,
                    "parent_id": 3,
                    "name": "应急电源",
                    "brands": [],
                    "attributes": []
                }
            ]
        },
        {
            "id": 4,
            "parent_id": null,
            "name": "汽车装饰",
            "brands": [],
            "attributes": [],
            "sub": [
                {
                    "id": 34,
                    "parent_id": 4,
                    "name": "坐垫座套",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 35,
                    "parent_id": 4,
                    "name": "汽车脚垫",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 36,
                    "parent_id": 4,
                    "name": "车载支架",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 37,
                    "parent_id": 4,
                    "name": "汽车香水",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 38,
                    "parent_id": 4,
                    "name": "头枕腰靠",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 39,
                    "parent_id": 4,
                    "name": "车内除味",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 40,
                    "parent_id": 4,
                    "name": "挂件摆件",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 41,
                    "parent_id": 4,
                    "name": "汽车钥匙包/扣",
                    "brands": [],
                    "attributes": []
                }
            ]
        },
        {
            "id": 5,
            "parent_id": null,
            "name": "美容清洗",
            "brands": [],
            "attributes": [],
            "sub": [
                {
                    "id": 42,
                    "parent_id": 5,
                    "name": "洗车机",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 43,
                    "parent_id": 5,
                    "name": "清洁剂",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 44,
                    "parent_id": 5,
                    "name": "汽车贴膜",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 45,
                    "parent_id": 5,
                    "name": "玻璃水",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 46,
                    "parent_id": 5,
                    "name": "补漆笔",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 47,
                    "parent_id": 5,
                    "name": "车蜡",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 48,
                    "parent_id": 5,
                    "name": "镀晶",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 49,
                    "parent_id": 5,
                    "name": "镀膜",
                    "brands": [],
                    "attributes": []
                }
            ]
        },
        {
            "id": 6,
            "parent_id": null,
            "name": "安全自驾",
            "brands": [],
            "attributes": [],
            "sub": [
                {
                    "id": 50,
                    "parent_id": 6,
                    "name": "灭火器",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 51,
                    "parent_id": 6,
                    "name": "防滑链",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 52,
                    "parent_id": 6,
                    "name": "安全锤",
                    "brands": [],
                    "attributes": []
                },
                {
                    "id": 53,
                    "parent_id": 6,
                    "name": "拖车绳",
                    "brands": [],
                    "attributes": []
                }
            ]
        }
    ]
=end
  post :categories, :provides => [:json] do
    api_rescue do
      authenticate

      { status: 'succ', data: TCategory.all_categories}.to_json
    end
  end

  # 查找子目录
  # params {"category_id": 1}
  # data
=begin
  [
        {
            "id": 24,
            "parent_id": 2,
            "name": "轮胎",
            "brands": [],
            "attributes": []
        },
        {
            "id": 25,
            "parent_id": 2,
            "name": "轮毂",
            "brands": [],
            "attributes": []
        }
    ]
=end
  post :sub_categories, :provides => [:json] do
    api_rescue do
      authenticate
      @categories = TCategory.where(parent_id: @request_params['category_id'])
      { status: 'succ', data: @categories.map(&:to_api)}.to_json
    end
  end

  # 查找商品
  # params {"category_id": 1, "title": "美孚"}  后续上线查询支持
  # data
=begin
  [
      {
          "id": 1,
          "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
          "category": {
              "id": 7,
              "parent_id": 1,
              "name": "机油"
          },
          "detail": "新老包装更替中，实物包装可能与图片略有差别",
          "brand": {
              "id": 1,
              "name": "美孚",
              "detail": null,
              "image": null,
              "letter": "M"
          },
          "skus": [
              {
                  "id": 1,
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （4L装）",
                  "sku_code": "AN01224231",
                  "price": "329.0",
                  "service_fee": {
                        "到店安装": 50,
                        "无需安装": 0
                    },
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "4L",
                      "粘度": "5W-30"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "4L",
                      "毛重": 3.5,
                      "粘度": "5W-30",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  }
              },
              {
                  "id": 2,
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）",
                  "sku_code": "AN01224232",
                  "price": "89.0",
                  "service_fee": {
                        "到店安装": 50,
                        "无需安装": 0
                    },
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "1L",
                      "粘度": "5W-30"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "1L",
                      "毛重": 0.9,
                      "粘度": "5W-30",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  }
              },
              {
                  "id": 3,
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
                  "sku_code": "AN01224233",
                  "price": "329.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
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
                  }
              },
              {
                  "id": 4,
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （1L装）",
                  "sku_code": "AN01224234",
                  "price": "89.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
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
                  }
              },
              {
                  "id": 5,
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
                  "sku_code": "AN01224235",
                  "price": "559.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "4L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "4L",
                      "毛重": 3.5,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  }
              },
              {
                  "id": 6,
                  "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                  "sku_code": "AN01224236",
                  "price": "159.0",
                  "stock_num": 100,
                  "images": [
                      "images/260811002.jpg",
                      "images/1336270541.jpg"
                  ],
                  "sale_attrs": {
                      "容量": "1L",
                      "粘度": "0W-20"
                  },
                  "attrs": {
                      "产地": "见瓶身",
                      "容量": "1L",
                      "毛重": 0.9,
                      "粘度": "0W-20",
                      "保质期": "5年",
                      "机油种类": "全合成机油",
                      "机油等级": "SN",
                      "建议更换周期": "10000公里"
                  }
              }
          ]
      }
  ]
=end
  post :spus, :provides => [:json] do
    api_rescue do
      authenticate

      @t_spus = TSpu.where(t_category_id: @request_params['category_id']) if @request_params['category_id'].present?
      @t_spus = @t_spus.where("name like '%#{@request_params['title']}%'") if @request_params['title'].present?
      { status: 'succ', data: @t_spus.map(&:to_api)}.to_json
    end
  end

  # 根据spu_id查找单个商品
  # params {"spu_id": 1}
  # data
=begin
{
      "id": 1,
      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
      "category": {
          "id": 7,
          "parent_id": 1,
          "name": "机油"
      },
      "detail": "新老包装更替中，实物包装可能与图片略有差别",
      "brand": {
          "id": 1,
          "name": "美孚",
          "detail": null,
          "image": null,
          "letter": "M"
      },
      "skus": [
          {
              "id": 1,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （4L装）",
              "sku_code": "AN01224231",
              "price": "329.0",
              "service_fee": {
                        "到店安装": 50,
                        "无需安装": 0
                    },
              "stock_num": 100,
              "images": [
                  "images/260811002.jpg",
                  "images/1336270541.jpg"
              ],
              "sale_attrs": {
                  "容量": "4L",
                  "粘度": "5W-30"
              },
              "attrs": {
                  "产地": "见瓶身",
                  "容量": "4L",
                  "毛重": 3.5,
                  "粘度": "5W-30",
                  "保质期": "5年",
                  "机油种类": "全合成机油",
                  "机油等级": "SN",
                  "建议更换周期": "10000公里"
              }
          },
          {
              "id": 2,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）",
              "sku_code": "AN01224232",
              "price": "89.0",
              "stock_num": 100,
              "images": [
                  "images/260811002.jpg",
                  "images/1336270541.jpg"
              ],
              "sale_attrs": {
                  "容量": "1L",
                  "粘度": "5W-30"
              },
              "attrs": {
                  "产地": "见瓶身",
                  "容量": "1L",
                  "毛重": 0.9,
                  "粘度": "5W-30",
                  "保质期": "5年",
                  "机油种类": "全合成机油",
                  "机油等级": "SN",
                  "建议更换周期": "10000公里"
              }
          },
          {
              "id": 3,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
              "sku_code": "AN01224233",
              "price": "329.0",
              "stock_num": 100,
              "images": [
                  "images/260811002.jpg",
                  "images/1336270541.jpg"
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
              }
          },
          {
              "id": 4,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （1L装）",
              "sku_code": "AN01224234",
              "price": "89.0",
              "stock_num": 100,
              "images": [
                  "images/260811002.jpg",
                  "images/1336270541.jpg"
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
              }
          },
          {
              "id": 5,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
              "sku_code": "AN01224235",
              "price": "559.0",
              "stock_num": 100,
              "images": [
                  "images/260811002.jpg",
                  "images/1336270541.jpg"
              ],
              "sale_attrs": {
                  "容量": "4L",
                  "粘度": "0W-20"
              },
              "attrs": {
                  "产地": "见瓶身",
                  "容量": "4L",
                  "毛重": 3.5,
                  "粘度": "0W-20",
                  "保质期": "5年",
                  "机油种类": "全合成机油",
                  "机油等级": "SN",
                  "建议更换周期": "10000公里"
              }
          },
          {
              "id": 6,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
              "sku_code": "AN01224236",
              "price": "159.0",
              "stock_num": 100,
              "images": [
                  "images/260811002.jpg",
                  "images/1336270541.jpg"
              ],
              "sale_attrs": {
                  "容量": "1L",
                  "粘度": "0W-20"
              },
              "attrs": {
                  "产地": "见瓶身",
                  "容量": "1L",
                  "毛重": 0.9,
                  "粘度": "0W-20",
                  "保质期": "5年",
                  "机油种类": "全合成机油",
                  "机油等级": "SN",
                  "建议更换周期": "10000公里"
              }
          }
      ]
  }
=end
  post :spu, :provides => [:json] do
    api_rescue do
      authenticate

      @t_spu = TSpu.find(@request_params['spu_id'])
      { status: 'succ', data: @t_spu.to_api}.to_json
    end
  end


  # 根据sku_id，查询商品详情
  # params {"sku_id": 1}
  # data
=begin
  {
      "id": 1,
      "spu": {
          "id": 1,
          "title": "【正品授权】美孚/Mobil 美孚1号全合成机油",
          "category": {
              "id": 7,
              "parent_id": 1,
              "name": "机油"
          },
          "brand": {
              "id": 1,
              "name": "美孚",
              "detail": null,
              "image": null,
              "letter": "M"
          },
          "detail": "新老包装更替中，实物包装可能与图片略有差别"
      },
      "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （4L装）",
      "sku_code": "AN01224231",
      "price": "329.0",
      "service_fee": {
                        "到店安装": 50,
                        "无需安装": 0
                    },
      "stock_num": 100,
      "images": [
          "images/260811002.jpg",
          "images/1336270541.jpg"
      ],
      "sale_attrs": {
          "容量": "4L",
          "粘度": "5W-30"
      },
      "attrs": {
          "产地": "见瓶身",
          "容量": "4L",
          "毛重": 3.5,
          "粘度": "5W-30",
          "保质期": "5年",
          "机油种类": "全合成机油",
          "机油等级": "SN",
          "建议更换周期": "10000公里"
      }
  }
=end
  post :sku, :provides => [:json] do
    api_rescue do
      authenticate

      @sku = TSku.find(@request_params['sku_id'])
      { status: 'succ', data: @sku.to_api}.to_json
    end
  end

end
