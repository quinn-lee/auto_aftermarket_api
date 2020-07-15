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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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
                  available_num: 100, #可销售数量
                  preferred: '优选', #是否优选商品
                  "preferred_slogan": "", #优选商品广告语
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

  # 目录详情
  # params {"category_id": 1}
  # data
=begin
  {
        "id": 11,
        "parent_id": 1,
        "parent_name": "维修保养",
        "name": "空气滤清",
        "brands": [],
        "attributes": []
    }
=end
  post :category, :provides => [:json] do
    api_rescue do
      authenticate
      @category = TCategory.find(@request_params['category_id'])
      { status: 'succ', data: @category.to_api}.to_json
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

  # 查找商品 返回sku列表 category_id必须输入
  # params {"category_id": 1, "title": "美孚", "brand_id": [1,2], preferred: 1,  #preferred=1表示查询优选商品，=0表示查询普通商品
    #  "attrs": {"规格": ['255/55R18','235/60R18'], "轮胎性能": ['SUV/越野型']}}
  # data
=begin
    [
        {
            "id": 8,
            "spu": {
                "id": 3,
                "title": "米其林轮胎Michelin汽车轮胎",
                "category": {
                    "id": 24,
                    "parent_id": 2,
                    "name": "轮胎"
                },
                "brand": {
                    "id": 13,
                    "name": "米其林（MICHELIN）",
                    "detail": null,
                    "image": null,
                    "letter": "M"
                },
                "detail": ""
            },
            "title": "米其林轮胎Michelin汽车轮胎 235/60R18 107W 竞驰 PILOT SPORT 4 SUV 适配奥迪Q5/奔驰GLC级/雷克萨斯RX",
            "sku_code": "AN01224291",
            "price": "1029.0",
            "service_fee": {
                "到店安装": 50,
                "无需安装": 0
            },
            "stock_num": 100,
            available_num: 100, #可销售数量
            preferred: '优选', #是否优选商品
            "preferred_slogan": "", #优选商品广告语
            "images": [
                "images/e878635ad3af97aa.jpg",
                "images/f8238c37ec858c0b.jpg"
            ],
            "sale_attrs": {
                "规格": "235/60R18",
                "轮胎性能": "SUV/越野型",
                "轮胎花纹": "竞驰 PILOT SPORT 4 SUV"
            },
            "attrs": {
                "产地": "其他",
                "尺寸": "18英寸",
                "毛重": "13.06kg",
                "规格": "235/60R18",
                "扁平比": "60",
                "胎面宽度": "235",
                "轮胎性能": "SUV/越野型",
                "轮胎花纹": "竞驰 PILOT SPORT 4 SUV"
            }
        },
        {
            "id": 9,
            "spu": {
                "id": 3,
                "title": "米其林轮胎Michelin汽车轮胎",
                "category": {
                    "id": 24,
                    "parent_id": 2,
                    "name": "轮胎"
                },
                "brand": {
                    "id": 13,
                    "name": "米其林（MICHELIN）",
                    "detail": null,
                    "image": null,
                    "letter": "M"
                },
                "detail": ""
            },
            "title": "米其林轮胎Michelin汽车轮胎255/55 R18 109Y PILOT SPORT 4 SUV 适配保时捷卡宴/奥迪Q7/大众途锐等",
            "sku_code": "AN01224292",
            "price": "1249.0",
            "service_fee": {
                "到店安装": 50,
                "无需安装": 0
            },
            "stock_num": 100,
            available_num: 100, #可销售数量
            preferred: '普通', #是否优选商品
            "preferred_slogan": "", #优选商品广告语
            "images": [
                "images/e878635ad3af97aa.jpg",
                "images/f8238c37ec858c0b.jpg"
            ],
            "sale_attrs": {
                "规格": "255/55R18",
                "轮胎性能": "SUV/越野型",
                "轮胎花纹": "竞驰 PILOT SPORT 4 SUV"
            },
            "attrs": {
                "产地": "其他",
                "尺寸": "18英寸",
                "毛重": "14.48kg",
                "规格": "255/55R18",
                "扁平比": "55",
                "胎面宽度": "255",
                "轮胎性能": "SUV/越野型",
                "轮胎花纹": "竞驰 PILOT SPORT 4 SUV"
            }
        }
    ]
=end
  post :skus, :provides => [:json] do
    api_rescue do
      authenticate
      raise "category_id 必须指定" unless @request_params['category_id'].present?
      @t_spus = TSpu.where(t_category_id: @request_params['category_id'], merchant_id: @merchant.id, saleable: true)
      @t_spus = TSpu.where(t_brand_id: @request_params['brand_id']) if @request_params['brand_id'].present?
      @t_skus = TSku.where(t_spu_id: @t_spus.map(&:id), saleable: true).where("available_num > 0")
      @t_skus = @t_skus.where("title like '%#{@request_params['title']}%'") if @request_params['title'].present?
      @t_skus = @t_skus.where(preferred: @request_params['preferred']) if @request_params['preferred'].present?
      if @request_params['attrs'].present?
        @request_params['attrs'].each do |k, v|
          instr = "("
          v.each{|s| instr << "'#{s}',"}
          instr = instr.chop << ")"
          @t_skus = @t_skus.where("attrs ->> '#{k}' in #{instr}")
        end
      end
      { status: 'succ', data: @t_skus.map(&:to_api)}.to_json
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
              available_num: 100, #可销售数量
              preferred: '优选', #是否优选商品
              "preferred_slogan": "", #优选商品广告语
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
              available_num: 100, #可销售数量
              preferred: '优选', #是否优选商品
              "preferred_slogan": "", #优选商品广告语
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
              available_num: 100, #可销售数量
              preferred: '优选', #是否优选商品
              "preferred_slogan": "", #优选商品广告语
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
              available_num: 100, #可销售数量
              preferred: '优选', #是否优选商品
              "preferred_slogan": "", #优选商品广告语
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
              available_num: 100, #可销售数量
              preferred: '优选', #是否优选商品
              "preferred_slogan": "", #优选商品广告语
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
              available_num: 100, #可销售数量
              preferred: '优选', #是否优选商品
              "preferred_slogan": "", #优选商品广告语
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
      available_num: 100, #可销售数量
      preferred: '优选', #是否优选商品
      "preferred_slogan": "", #优选商品广告语
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
      if sv = SkuView.find_by(customer_id: @customer.id, t_sku_id: @sku.id)
        sv.update(visit_time: Time.now)
      else
        SkuView.create(customer_id: @customer.id, t_sku_id: @sku.id, visit_time: Time.now)
      end
      { status: 'succ', data: @sku.to_api}.to_json
    end
  end


  # 优选商品列表
  # params {"category_id": 1, "title": "美孚", "brand_id": [1,2]
    #  "attrs": {"规格": ['255/55R18','235/60R18'], "轮胎性能": ['SUV/越野型']}}
  # data 与skus同
  post :preferred, :provides => [:json] do
    api_rescue do
      authenticate
      @t_spus = TSpu.where(merchant_id: @merchant.id, saleable: true)
      @t_spus = TSpu.where(t_category_id: @request_params['category_id']) if @request_params['category_id'].present?
      @t_spus = TSpu.where(t_brand_id: @request_params['brand_id']) if @request_params['brand_id'].present?
      @t_skus = TSku.where(t_spu_id: @t_spus.map(&:id), saleable: true).where("available_num > 0").where.not(preferred: 0)
      @t_skus = @t_skus.where("title like '%#{@request_params['title']}%'") if @request_params['title'].present?

      if @request_params['attrs'].present?
        @request_params['attrs'].each do |k, v|
          instr = "("
          v.each{|s| instr << "'#{s}',"}
          instr = instr.chop << ")"
          @t_skus = @t_skus.where("attrs ->> '#{k}' in #{instr}")
        end
      end
      { status: 'succ', data: @t_skus.order("preferred desc").map(&:to_api)}.to_json
    end
  end

  # 收藏商品列表
  # params 空
  # data 与skus同
  post :favorites, :provides => [:json] do
    api_rescue do
      authenticate
      @favorites = Favorite.where(merchant_id: @merchant.id, customer_id: @customer.id)
      { status: 'succ', data: @favorites.order("created_at desc").map{|f| f.t_sku.to_api}}.to_json
    end
  end

  # 收藏商品
  # params {sku_id: 1}
  # data {}
  post :favour, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "sku ID不能为空" if @request_params['sku_id'].blank?
        sku = TSku.find(@request_params['sku_id'])
        if Favorite.where(merchant_id: @merchant.id, customer_id: @customer.id, t_sku_id: sku.id).count == 0
          Favorite.create!(merchant_id: @merchant.id, customer_id: @customer.id, t_sku_id: sku.id)
        end
      end
      { status: 'succ', data: {}}.to_json
    end
  end

  # 取消收藏
  # params {sku_id: 1}
  # data {}
  post :cancel_favour, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "sku ID不能为空" if @request_params['sku_id'].blank?
        sku = TSku.find(@request_params['sku_id'])
        if favorite = Favorite.find_by(merchant_id: @merchant.id, customer_id: @customer.id, t_sku_id: sku.id)
          favorite.destroy
        end
      end
      { status: 'succ', data: {}}.to_json
    end
  end

  # 商品是否收藏过
  # params {sku_id: 1}
  # data {"favorite": true}
  post :is_favorite, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "sku ID不能为空" if @request_params['sku_id'].blank?
        sku = TSku.find(@request_params['sku_id'])
        @data = {"favorite": false}
        if favorite = Favorite.find_by(merchant_id: @merchant.id, customer_id: @customer.id, t_sku_id: sku.id)
          @data = {"favorite": true}
        end
      end
      { status: 'succ', data: @data}.to_json
    end
  end


  # 保养套餐替换商品
  # 有匹配的商品时返回同一个目录下匹配的商品，没有匹配的商品时返回同一个目录下通用的商品
  # params {car_model_id: 1, sku_id: 7}
  # car_model_id是当前车型的汽车型号id，sku_id是需要替换的商品sku_id
  # data 与skus/skus 接口相同
  post :sub_skus, :provides => [:json] do
    api_rescue do
      authenticate
      raise "参数不能为空" if @request_params['car_model_id'].blank? || @request_params['sku_id'].blank?
      @sku = TSku.find(@request_params['sku_id'])
      @t_skus = TSku.where(id: CarModelSku.where(merchant_id: @merchant.id, car_model_id: @request_params['car_model_id'], t_category_id: @sku.t_spu.t_category_id).map(&:t_sku_id)).where.not(id: @sku.id).where(saleable: true).where("available_num > 0")
      if @t_skus.count == 0 #不存在匹配商品时，返回同一个目录下的通用商品
        @t_spus = TSpu.where(t_category_id: @sku.t_spu.t_category_id, merchant_id: @merchant.id, saleable: true)
        @t_skus = TSku.where(t_spu_id: @t_spus.map(&:id), saleable: true).where("available_num > 0").where.not(id: CarModelSku.where(merchant_id: @merchant.id, t_category_id: @sku.t_spu.t_category_id).where.not(car_model_id: @request_params['car_model_id']).map(&:t_sku_id)).where.not(id: @sku.id)
      end
      { status: 'succ', data: @t_skus.map(&:to_api)}.to_json
    end
  end

end
