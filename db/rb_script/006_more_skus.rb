tc = TCategory.find_by_name("轮胎")

tb11 = TBrand.create(name: "米其林（MICHELIN）", letter: "M")
tb12 = TBrand.create(name: "马牌（Continental）", letter: "M")
tb13 = TBrand.create(name: "邓禄普（DUNLOP）", letter: "D")
tb14 = TBrand.create(name: "普利司通（Bridgestone）", letter: "P")
tb15 = TBrand.create(name: "倍耐力（Pirelli）", letter: "B")
tb16 = TBrand.create(name: "韩泰（Hankook）", letter: "H")
tb17 = TBrand.create(name: "固特异（Goodyear）", letter: "G")
tb18 = TBrand.create(name: "佳通轮胎（Giti）", letter: "J")
tb19 = TBrand.create(name: "玛吉斯", letter: "M")
tb20 = TBrand.create(name: "优科豪马（yokohama）", letter: "Y")
tb21 = TBrand.create(name: "锦湖", letter: "J")

TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb11.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb12.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb13.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb14.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb15.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb16.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb17.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb18.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb19.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb20.id)
TCategoryBrand.create(t_category_id: tc.id,t_brand_id: tb21.id)

ta1 = TAttribute.create(t_category_id: tc.id, name: "尺寸", numeric: true, generic: true, selling: false, searching: true, unit: "英寸")
ta2 = TAttribute.create(t_category_id: tc.id, name: "轮胎性能", numeric: false, generic: true, selling: true, searching: true, unit: nil)
ta3 = TAttribute.create(t_category_id: tc.id, name: "轮胎花纹", numeric: false, generic: true, selling: true, searching: true, unit: nil)
ta4 = TAttribute.create(t_category_id: tc.id, name: "毛重", numeric: true, generic: true, selling: false, searching: false, unit: "千克")
ta5 = TAttribute.create(t_category_id: tc.id, name: "产地", numeric: false, generic: true, selling: false, searching: false, unit: nil)
ta6 = TAttribute.create(t_category_id: tc.id, name: "轮胎特性", numeric: false, generic: true, selling: false, searching: false, unit: nil)
ta7 = TAttribute.create(t_category_id: tc.id, name: "扁平比", numeric: true, generic: true, selling: false, searching: false, unit: nil)
ta8 = TAttribute.create(t_category_id: tc.id, name: "胎面宽度", numeric: true, generic: true, selling: false, searching: false, unit: nil)
ta9 = TAttribute.create(t_category_id: tc.id, name: "规格", numeric: false, generic: true, selling: true, searching: false, unit: nil)


TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta1.id, value: 14, is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta1.id, value: 15, is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta1.id, value: 16, is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta1.id, value: 17, is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta1.id, value: 18, is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta1.id, value: 19, is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta1.id, value: 20, is_valid: true)

TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta2.id, value: "静音舒适型", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta2.id, value: "经济耐用型", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta2.id, value: "运动操控型", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta2.id, value: "SUV/越野型", is_valid: true)

TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta9.id, value: "215/55R17", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta9.id, value: "215/55R18", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta9.id, value: "215/45R17", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta9.id, value: "215/45R18", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta9.id, value: "225/55R17", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta9.id, value: "235/55R17", is_valid: true)
TAttrvalue.create(t_category_id: tc.id, t_attribute_id: ta9.id, value: "205/55R17", is_valid: true)

m1 = Merchant.first

tspu1 = TSpu.create(t_category_id: tc.id, t_brand_id: tb11.id, merchant_id: m1.id, title: "米其林轮胎Michelin汽车轮胎", \
  detail: "", saleable: true,is_valid: true)
tsku11 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224291",title: "米其林轮胎Michelin汽车轮胎 235/60R18 107W 竞驰 PILOT SPORT 4 SUV 适配奥迪Q5/奔驰GLC级/雷克萨斯RX",images: ["images/e878635ad3af97aa.jpg", "images/f8238c37ec858c0b.jpg"],\
  price: 1029, sale_attrs: {"轮胎性能": "SUV/越野型", "轮胎花纹": "竞驰 PILOT SPORT 4 SUV", "规格": "235/60R18"}, attrs: {"轮胎性能": "SUV/越野型", "轮胎花纹": "竞驰 PILOT SPORT 4 SUV", "规格": "235/60R18", "尺寸": "18英寸", "毛重": "13.06kg", "产地": "其他", "扁平比": "60", "胎面宽度": "235"},saleable: true,is_valid: true, stock_num: 100, service_fee: {"到店安装": 50, "无需安装": 0})
tsku12 = TSku.create(t_spu_id: tspu1.id, merchant_id: m1.id, sku_code: "AN01224292",title: "米其林轮胎Michelin汽车轮胎255/55 R18 109Y PILOT SPORT 4 SUV 适配保时捷卡宴/奥迪Q7/大众途锐等",images: ["images/e878635ad3af97aa.jpg", "images/f8238c37ec858c0b.jpg"],\
  price: 1249, sale_attrs: {"轮胎性能": "SUV/越野型", "轮胎花纹": "竞驰 PILOT SPORT 4 SUV", "规格": "255/55R18"}, attrs: {"轮胎性能": "SUV/越野型", "轮胎花纹": "竞驰 PILOT SPORT 4 SUV", "规格": "255/55R18", "尺寸": "18英寸", "毛重": "14.48kg", "产地": "其他", "扁平比": "55", "胎面宽度": "255"},saleable: true,is_valid: true, stock_num: 100, service_fee: {"到店安装": 50, "无需安装": 0})
