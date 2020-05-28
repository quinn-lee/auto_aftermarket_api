m1 = Merchant.create(name: "EuropeTime", password: "1qaz2wsx", email: "et@quaie.com", mobile: "13917000000", appid: "wxb5ebd7edf0437cdb", appsecret: "986dfb559ebb15402628db871ba6f608", mch_id: "1494422632", mch_key: "uH372sXm3dR8KFD9LScN61Aj4f59D31W")

s1 = Shop.create(merchant_id: m1.id, name: "东升汽车养护店（石泉路店）", address: "上海市普陀区石泉路22号", contact_name: "李富元", contact_phone: "13917050000")
