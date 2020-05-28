c1 = Category.create(name: "常规保养")
c2 = Category.create(name: "机油", parent_id: c1.id)
c3 = Category.create(name: "机油滤清器", parent_id: c1.id)
c4 = Category.create(name: "空气滤清器", parent_id: c1.id)
c5 = Category.create(name: "燃油滤清器", parent_id: c1.id)
c6 = Category.create(name: "燃油系统养护", parent_id: c1.id)

c7 = Category.create(name: "刹车养护")
c8 = Category.create(name: "刹车油", parent_id: c7.id)
c9 = Category.create(name: "刹车片", parent_id: c7.id)
c10 = Category.create(name: "刹车盘", parent_id: c7.id)


g1 = Goods.create(name: "【正品授权】美孚/Mobil 美孚1号全合成机油", description: "新老包装更替中，实物包装可能与图片略有差别", category_id: c2.id)
s1 = Sku.create(sku_name: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （4L装）", sku_code: "AN01224231", price: 329, goods_id: g1.id, stock_quantity: 10, weight: 3.62)
s2 = Sku.create(sku_name: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）", sku_code: "AN01224232", price: 89, goods_id: g1.id, stock_quantity: 10, weight: 0.92)
s3 = Sku.create(sku_name: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）", sku_code: "AN01224233", price: 329, goods_id: g1.id, stock_quantity: 10, weight: 3.58)
s4 = Sku.create(sku_name: "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （1L装）", sku_code: "AN01224234", price: 89, goods_id: g1.id, stock_quantity: 10, weight: 0.91)
s5 = Sku.create(sku_name: "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）", sku_code: "AN01224235", price: 599, goods_id: g1.id, stock_quantity: 10, weight: 3.56)
s6 = Sku.create(sku_name: "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）", sku_code: "AN01224236", price: 159, goods_id: g1.id, stock_quantity: 10, weight: 0.9)

a1 = Attribute.create(attr_name: "品牌", attr_value: "美孚/Mobil")
a2 = Attribute.create(attr_name: "规格", attr_value: "4升")
a3 = Attribute.create(attr_name: "基础油级别", attr_value: "全合成机油")
a4 = Attribute.create(attr_name: "粘稠度", attr_value: "5W-30")
a5 = Attribute.create(attr_name: "机油等级", attr_value: "SN")
a6 = Attribute.create(attr_name: "适配发动机", attr_value: "汽油发动机")
a7 = Attribute.create(attr_name: "规格", attr_value: "1升")
a8 = Attribute.create(attr_name: "粘稠度", attr_value: "5W-40")
a9 = Attribute.create(attr_name: "粘稠度", attr_value: "0W-20")

GoodsAttribute.create(goods_id: g1.id, attribute_id: a1.id)
GoodsAttribute.create(goods_id: g1.id, attribute_id: a3.id)
GoodsAttribute.create(goods_id: g1.id, attribute_id: a5.id)
GoodsAttribute.create(goods_id: g1.id, attribute_id: a6.id)
SkuAttribute.create(sku_code: s1.id, attribute_id: a2.id)
SkuAttribute.create(sku_code: s1.id, attribute_id: a4.id)
SkuAttribute.create(sku_code: s2.id, attribute_id: a7.id)
SkuAttribute.create(sku_code: s2.id, attribute_id: a4.id)
SkuAttribute.create(sku_code: s3.id, attribute_id: a2.id)
SkuAttribute.create(sku_code: s3.id, attribute_id: a8.id)
SkuAttribute.create(sku_code: s4.id, attribute_id: a7.id)
SkuAttribute.create(sku_code: s4.id, attribute_id: a8.id)
SkuAttribute.create(sku_code: s5.id, attribute_id: a2.id)
SkuAttribute.create(sku_code: s5.id, attribute_id: a9.id)
SkuAttribute.create(sku_code: s6.id, attribute_id: a7.id)
SkuAttribute.create(sku_code: s6.id, attribute_id: a9.id)


g2 = Goods.create(name: "马勒/MAHLE 机油滤清器", description: "", category_id: c3.id)
s7 = Sku.create(sku_name: "马勒/MAHLE 机油滤清器 OC1480", sku_code: "AN01224240", price: 25, goods_id: g2.id, stock_quantity: 10, weight: 0.22)
a10 = Attribute.create(attr_name: "品牌", attr_value: "马勒/MAHLE")
a11 = Attribute.create(attr_name: "规格", attr_value: "只")
a12 = Attribute.create(attr_name: "场地", attr_value: "中国")
a13 = Attribute.create(attr_name: "机滤类型", attr_value: "机油滤清器")
GoodsAttribute.create(goods_id: g2.id, attribute_id: a10.id)
GoodsAttribute.create(goods_id: g2.id, attribute_id: a11.id)
GoodsAttribute.create(goods_id: g2.id, attribute_id: a12.id)
GoodsAttribute.create(goods_id: g2.id, attribute_id: a13.id)


g3 = Goods.create(name: "菲罗多/FERODO 刹车片前片", description: "低铜配方，更安全环保。百年悠久历史，世界知名制动品牌", category_id: c9.id)
s8 = Sku.create(sku_name: "菲罗多/FERODO 刹车片前片 FDB4044-D 套/4片装", sku_code: "AN01224250", price: 429, goods_id: g3.id, stock_quantity: 10, weight: 2.83)
a20 = Attribute.create(attr_name: "品牌", attr_value: "菲罗多/FERODO")
a21 = Attribute.create(attr_name: "规格", attr_value: "套")
a22 = Attribute.create(attr_name: "位置", attr_value: "前")
a23 = Attribute.create(attr_name: "刹车类型", attr_value: "片")
GoodsAttribute.create(goods_id: g3.id, attribute_id: a20.id)
GoodsAttribute.create(goods_id: g3.id, attribute_id: a21.id)
GoodsAttribute.create(goods_id: g3.id, attribute_id: a22.id)
GoodsAttribute.create(goods_id: g3.id, attribute_id: a23.id)

Recommend.create(name: "大保养推荐套餐", rtype: "默认适配", category_id: c2.id, goods_id: g1.id, sku_id: s5.id)
Recommend.create(name: "大保养推荐套餐", rtype: "默认适配", category_id: c2.id, goods_id: g1.id, sku_id: s6.id)
Recommend.create(name: "大保养推荐套餐", rtype: "默认适配", category_id: c3.id, goods_id: g2.id, sku_id: s7.id)
Recommend.create(name: "大保养推荐套餐", rtype: "性价比适配", category_id: c2.id, goods_id: g1.id, sku_id: s5.id)
Recommend.create(name: "大保养推荐套餐", rtype: "性价比适配", category_id: c2.id, goods_id: g1.id, sku_id: s6.id)
Recommend.create(name: "大保养推荐套餐", rtype: "性价比适配", category_id: c3.id, goods_id: g2.id, sku_id: s7.id)
Recommend.create(name: "大保养推荐套餐", rtype: "性能适配", category_id: c2.id, goods_id: g1.id, sku_id: s1.id)
Recommend.create(name: "大保养推荐套餐", rtype: "性能适配", category_id: c2.id, goods_id: g1.id, sku_id: s2.id)
Recommend.create(name: "大保养推荐套餐", rtype: "性能适配", category_id: c3.id, goods_id: g2.id, sku_id: s7.id)
