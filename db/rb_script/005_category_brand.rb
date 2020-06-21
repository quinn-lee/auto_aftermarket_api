tc1 = TCategory.create(name: "维修保养", parent_id: nil, if_parent: true, sort: 1)
tc2 = TCategory.create(name: "轮胎配件", parent_id: nil, if_parent: true, sort: 1)
tc3 = TCategory.create(name: "车载电器", parent_id: nil, if_parent: true, sort: 1)
tc4 = TCategory.create(name: "汽车装饰", parent_id: nil, if_parent: true, sort: 1)
tc5 = TCategory.create(name: "美容清洗", parent_id: nil, if_parent: true, sort: 1)
tc6 = TCategory.create(name: "安全自驾", parent_id: nil, if_parent: true, sort: 1)

tc11 = TCategory.create(name: "机油", parent_id: tc1.id, if_parent: false, sort: 1)
tc12 = TCategory.create(name: "添加剂", parent_id: tc1.id, if_parent: false, sort: 1)
tc13 = TCategory.create(name: "防冻液", parent_id: tc1.id, if_parent: false, sort: 1)
tc14 = TCategory.create(name: "机油滤清", parent_id: tc1.id, if_parent: false, sort: 1)
tc15 = TCategory.create(name: "空气滤清", parent_id: tc1.id, if_parent: false, sort: 1)
tc16 = TCategory.create(name: "空调滤清", parent_id: tc1.id, if_parent: false, sort: 1)
tc17 = TCategory.create(name: "燃油滤清", parent_id: tc1.id, if_parent: false, sort: 1)
tc18 = TCategory.create(name: "汽车照明", parent_id: tc1.id, if_parent: false, sort: 1)
tc19 = TCategory.create(name: "雨刷", parent_id: tc1.id, if_parent: false, sort: 1)
tc110 = TCategory.create(name: "空调制冷剂", parent_id: tc1.id, if_parent: false, sort: 1)
tc111 = TCategory.create(name: "火花塞", parent_id: tc1.id, if_parent: false, sort: 1)
tc112 = TCategory.create(name: "蓄电池", parent_id: tc1.id, if_parent: false, sort: 1)
tc113 = TCategory.create(name: "刹车油", parent_id: tc1.id, if_parent: false, sort: 1)
tc114 = TCategory.create(name: "刹车盘", parent_id: tc1.id, if_parent: false, sort: 1)
tc115 = TCategory.create(name: "刹车片", parent_id: tc1.id, if_parent: false, sort: 1)
tc116 = TCategory.create(name: "变速箱油", parent_id: tc1.id, if_parent: false, sort: 1)
tc117 = TCategory.create(name: "减震器", parent_id: tc1.id, if_parent: false, sort: 1)

tc21 = TCategory.create(name: "轮胎", parent_id: tc2.id, if_parent: false, sort: 1)
tc22 = TCategory.create(name: "轮毂", parent_id: tc2.id, if_parent: false, sort: 1)

tc31 = TCategory.create(name: "行车记录仪", parent_id: tc3.id, if_parent: false, sort: 1)
tc32 = TCategory.create(name: "车载吸尘器", parent_id: tc3.id, if_parent: false, sort: 1)
tc33 = TCategory.create(name: "车载冰箱", parent_id: tc3.id, if_parent: false, sort: 1)
tc34 = TCategory.create(name: "车载充电器", parent_id: tc3.id, if_parent: false, sort: 1)
tc35 = TCategory.create(name: "车载净化器", parent_id: tc3.id, if_parent: false, sort: 1)
tc36 = TCategory.create(name: "胎压监测", parent_id: tc3.id, if_parent: false, sort: 1)
tc37 = TCategory.create(name: "充气泵", parent_id: tc3.id, if_parent: false, sort: 1)
tc38 = TCategory.create(name: "应急电源", parent_id: tc3.id, if_parent: false, sort: 1)

tc41 = TCategory.create(name: "坐垫座套", parent_id: tc4.id, if_parent: false, sort: 1)
tc42 = TCategory.create(name: "汽车脚垫", parent_id: tc4.id, if_parent: false, sort: 1)
tc43 = TCategory.create(name: "车载支架", parent_id: tc4.id, if_parent: false, sort: 1)
tc44 = TCategory.create(name: "汽车香水", parent_id: tc4.id, if_parent: false, sort: 1)
tc45 = TCategory.create(name: "头枕腰靠", parent_id: tc4.id, if_parent: false, sort: 1)
tc46 = TCategory.create(name: "车内除味", parent_id: tc4.id, if_parent: false, sort: 1)
tc47 = TCategory.create(name: "挂件摆件", parent_id: tc4.id, if_parent: false, sort: 1)
tc48 = TCategory.create(name: "汽车钥匙包/扣", parent_id: tc4.id, if_parent: false, sort: 1)

tc51 = TCategory.create(name: "洗车机", parent_id: tc5.id, if_parent: false, sort: 1)
tc52 = TCategory.create(name: "清洁剂", parent_id: tc5.id, if_parent: false, sort: 1)
tc53 = TCategory.create(name: "汽车贴膜", parent_id: tc5.id, if_parent: false, sort: 1)
tc54 = TCategory.create(name: "玻璃水", parent_id: tc5.id, if_parent: false, sort: 1)
tc55 = TCategory.create(name: "补漆笔", parent_id: tc5.id, if_parent: false, sort: 1)
tc56 = TCategory.create(name: "车蜡", parent_id: tc5.id, if_parent: false, sort: 1)
tc57 = TCategory.create(name: "镀晶", parent_id: tc5.id, if_parent: false, sort: 1)
tc58 = TCategory.create(name: "镀膜", parent_id: tc5.id, if_parent: false, sort: 1)

tc61 = TCategory.create(name: "灭火器", parent_id: tc6.id, if_parent: false, sort: 1)
tc62 = TCategory.create(name: "防滑链", parent_id: tc6.id, if_parent: false, sort: 1)
tc63 = TCategory.create(name: "安全锤", parent_id: tc6.id, if_parent: false, sort: 1)
tc64 = TCategory.create(name: "拖车绳", parent_id: tc6.id, if_parent: false, sort: 1)

tb11 = TBrand.create(name: "美孚", letter: "M")
tb12 = TBrand.create(name: "壳牌", letter: "Q")
tb13 = TBrand.create(name: "嘉实多", letter: "J")
tb14 = TBrand.create(name: "道达尔", letter: "D")
tb15 = TBrand.create(name: "本田", letter: "B")
tb16 = TBrand.create(name: "力魔", letter: "L")
tb17 = TBrand.create(name: "丰田", letter: "F")
tb18 = TBrand.create(name: "长城", letter: "C")
tb19 = TBrand.create(name: "昆仑", letter: "K")

TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb11.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb12.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb13.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb14.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb15.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb16.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb17.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb18.id)
TCategoryBrand.create(t_category_id: tc11.id,t_brand_id: tb19.id)

tb21 = TBrand.create(name: "马勒", letter: "M")
tb22 = TBrand.create(name: "博世", letter: "B")
tb23 = TBrand.create(name: "曼牌滤清器", letter: "M")

TCategoryBrand.create(t_category_id: tc14.id,t_brand_id: tb21.id)
TCategoryBrand.create(t_category_id: tc14.id,t_brand_id: tb22.id)
TCategoryBrand.create(t_category_id: tc14.id,t_brand_id: tb23.id)
TCategoryBrand.create(t_category_id: tc14.id,t_brand_id: tb17.id)

ta1 = TAttribute.create(t_category_id: tc11.id, name: "容量", numeric: true, generic: true, selling: true, searching: true, unit: "L")
ta2 = TAttribute.create(t_category_id: tc11.id, name: "粘度", numeric: false, generic: true, selling: true, searching: true, unit: nil)
ta3 = TAttribute.create(t_category_id: tc11.id, name: "机油种类", numeric: false, generic: true, selling: false, searching: true, unit: nil)
ta4 = TAttribute.create(t_category_id: tc11.id, name: "毛重", numeric: true, generic: true, selling: false, searching: false, unit: "千克")
ta5 = TAttribute.create(t_category_id: tc11.id, name: "产地", numeric: false, generic: true, selling: false, searching: false, unit: nil)
ta6 = TAttribute.create(t_category_id: tc11.id, name: "机油等级", numeric: false, generic: true, selling: false, searching: false, unit: nil)
ta7 = TAttribute.create(t_category_id: tc11.id, name: "建议更换周期", numeric: true, generic: true, selling: false, searching: false, unit: '公里')
ta8 = TAttribute.create(t_category_id: tc11.id, name: "保质期", numeric: true, generic: true, selling: false, searching: false, unit: '年')


TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta1.id, value: 6, is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta1.id, value: 5, is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta1.id, value: 4, is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta1.id, value: 1, is_valid: true)

TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "0W-30", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "0W-40", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "1W-30", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "10W-40", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "10W-50", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "10W-60", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "15W-40", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "20W-40", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "5W-30", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "5W-40", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "5W-50", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "0W-20", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "20W-50", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "5W-20", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "20W-60", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "15W-50", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "0W-16", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta2.id, value: "85W-140", is_valid: true)

TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta3.id, value: "全合成机油", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta3.id, value: "半合成机油", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta3.id, value: "矿物质机油", is_valid: true)
TAttrvalue.create(t_category_id: tc11.id, t_attribute_id: ta3.id, value: "PAO类全合成基础油", is_valid: true)

TAttribute.create(t_category_id: tc14.id, name: "毛重", numeric: true, generic: true, selling: false, searching: false, unit: "千克")
TAttribute.create(t_category_id: tc14.id, name: "产地", numeric: false, generic: true, selling: false, searching: false, unit: nil)


m1 = Merchant.create(name: "EuropeTime", appid: "wx8617e1f397b74930", appsecret: "e3314799cc97fe67b68df4ffdfcb46e8", mch_id: "1494422632", mch_key: "uH372sXm3dR8KFD9LScN61Aj4f59D31W")

s1 = Shop.create(merchant_id: m1.id, name: "东升汽车养护店（石泉路店）", address: "上海市普陀区石泉路22号", contact_name: "李富元", contact_phone: "13917050000")

tspu1 = TSpu.create(t_category_id: tc11.id, t_brand_id: tb11.id, merchant_id: m1.id, title: "【正品授权】美孚/Mobil 美孚1号全合成机油", \
  detail: "新老包装更替中，实物包装可能与图片略有差别", saleable: true,is_valid: true)
tsku11 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224231",title: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （4L装）",images: ["images/260811002.jpg", "images/1336270541.jpg"],\
  price: 329, sale_attrs: {"容量": "4L", "粘度": "5W-30"}, attrs: {"容量": "4L", "粘度": "5W-30", "机油种类": "全合成机油", "毛重": 3.5, "产地": "见瓶身", "机油等级": "SN", "建议更换周期": "10000公里", "保质期": "5年"},saleable: true,is_valid: true, stock_num: 100)
tsku12 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224232",title: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）",images: ["images/260811002.jpg", "images/1336270541.jpg"],\
  price: 89, sale_attrs: {"容量": "1L", "粘度": "5W-30"}, attrs: {"容量": "1L", "粘度": "5W-30", "机油种类": "全合成机油", "毛重": 0.9, "产地": "见瓶身", "机油等级": "SN", "建议更换周期": "10000公里", "保质期": "5年"},saleable: true,is_valid: true, stock_num: 100)
tsku13 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224233",title: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",images: ["images/260811002.jpg", "images/1336270541.jpg"],\
  price: 329, sale_attrs: {"容量": "4L", "粘度": "5W-40"},attrs: {"容量": "4L", "粘度": "5W-40", "机油种类": "全合成机油", "毛重": 3.5, "产地": "见瓶身", "机油等级": "SN", "建议更换周期": "10000公里", "保质期": "5年"},saleable: true,is_valid: true, stock_num: 100)
tsku14 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224234",title: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （1L装）",images: ["images/260811002.jpg", "images/1336270541.jpg"],\
  price: 89, sale_attrs: {"容量": "1L", "粘度": "5W-40"},attrs: {"容量": "1L", "粘度": "5W-40", "机油种类": "全合成机油", "毛重": 0.9, "产地": "见瓶身", "机油等级": "SN", "建议更换周期": "10000公里", "保质期": "5年"},saleable: true,is_valid: true, stock_num: 100)
tsku15 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224235",title: "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",images: ["images/260811002.jpg", "images/1336270541.jpg"],\
  price: 559, sale_attrs: {"容量": "4L", "粘度": "0W-20"},attrs: {"容量": "4L", "粘度": "0W-20", "机油种类": "全合成机油", "毛重": 3.5, "产地": "见瓶身", "机油等级": "SN", "建议更换周期": "10000公里", "保质期": "5年"},saleable: true,is_valid: true, stock_num: 100)
tsku16 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224236",title: "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",images: ["images/260811002.jpg", "images/1336270541.jpg"],\
  price: 159, sale_attrs: {"容量": "1L", "粘度": "0W-20"},attrs: {"容量": "1L", "粘度": "0W-20", "机油种类": "全合成机油", "毛重": 0.9, "产地": "见瓶身", "机油等级": "SN", "建议更换周期": "10000公里", "保质期": "5年"},saleable: true,is_valid: true, stock_num: 100)


tspu2 = TSpu.create(t_category_id: tc14.id, t_brand_id: tb21.id, merchant_id: m1.id, title: "马勒/MAHLE 机油滤清器", \
  detail: "", saleable: true,is_valid: true)
tsku21 = TSku.create(t_spu_id: tspu2.id, merchant_id: m1.id, sku_code: "AN01224241",title: "马勒/MAHLE 机油滤清器 OC1480",images: ["images/260811002.jpg", "images/1336270541.jpg"],\
  price: 329, sale_attrs: {}, attrs: {"毛重": 3.5, "产地": "见瓶身"},saleable: true,is_valid: true, stock_num: 100)


Recommend.create(name: "大保养推荐套餐", rtype: "默认适配", t_category_id: tc11.id, t_spu_id: tspu1.id, t_sku_id: tsku15.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "默认适配", t_category_id: tc11.id, t_spu_id: tspu1.id, t_sku_id: tsku16.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "默认适配", t_category_id: tc14.id, t_spu_id: tspu2.id, t_sku_id: tsku21.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "性价比适配", t_category_id: tc11.id, t_spu_id: tspu1.id, t_sku_id: tsku15.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "性价比适配", t_category_id: tc11.id, t_spu_id: tspu1.id, t_sku_id: tsku16.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "性价比适配", t_category_id: tc14.id, t_spu_id: tspu2.id, t_sku_id: tsku21.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "性能适配", t_category_id: tc11.id, t_spu_id: tspu1.id, t_sku_id: tsku15.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "性能适配", t_category_id: tc11.id, t_spu_id: tspu1.id, t_sku_id: tsku16.id, quantity: 1)
Recommend.create(name: "大保养推荐套餐", rtype: "性能适配", t_category_id: tc14.id, t_spu_id: tspu2.id, t_sku_id: tsku21.id, quantity: 1)
