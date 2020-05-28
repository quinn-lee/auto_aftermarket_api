SkuAttribute.all.each{|sa| sa.update!(sku_code: Sku.find(sa.sku_code).sku_code)}
Recommend.all.update_all(quantity: 1)
