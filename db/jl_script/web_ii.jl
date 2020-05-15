using HTTP, Gumbo, Cascadia, JSON
using LibPQ,Tables
using Dates
# 页面获取
function fetchpage(url)
  try
    headers = Dict("User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36")
    response = HTTP.get(url, headers=headers)
    if response.status == 200 && parse(Int, Dict(response.headers)["Content-Length"]) > 0
      String(response.body)
    else
      ""
    end
  catch e
    ""
  end
end

# 获取所有品牌数据
function fetch_brands()
  try
    url = "http://api.car.bitauto.com/CarInfo/getlefttreejson.ashx?tagtype=chexing&pagetype=masterbrand&objid=0"
    resp_body = fetchpage(url)
    if isempty(resp_body)
      return []
    end
    reg = r"type:.+?(},\{|}])"
    m = eachmatch(reg,resp_body)
    reg_name = r"name:\".+?\""
    reg_url = r"url:\".+?\""
    [Dict(:name=>split(match(reg_name, brand.match).match, "\"")[2], :url=>split(match(reg_url, brand.match).match, "\"")[2]) for brand in collect(m)]
  catch e
    []
  end
end

# url = "http://car.bitauto.com/tree_chexing/mb_9/"
# url = "http://car.bitauto.com/tree_chexing/mb_26/"
# 根据品牌页面，获取每个品牌下的所有车型名称和链接
function extract_models(url)
  try
    resp_body = fetchpage(url)
    models = []
    if isempty(resp_body)
      return models
    end
    dom = parsehtml(resp_body)
    s=Selector(".p-list .name")
    tags = eachmatch(s, dom.root)
    # return [Dict(:href => eachmatch(Selector("a:not(.ico)"), tag)[1].attributes["href"], :title => eachmatch(Selector("a:not(.ico)"), tag)[1].attributes["title"]) for tag in tags]
    for tag in tags
      try
        link = eachmatch(Selector("a:not(.ico)"), tag)[1]
        href = link.attributes["href"]
        title = link.attributes["title"]
        push!(models, Dict(:href=>href, :title=>title))
      catch e
        println("extract_models error!!!")
      end
    end
    return models
  catch e
    []
  end
end

# models = extract_models(url)

# url = "http://car.bitauto.com/siyucivic/"
# 根据车型详情页面，获取这个车型下的所有在售和停售年款
function extract_years(url)
  try
    resp_body = fetchpage(url)
    if isempty(resp_body)
      return []
    end
    dom = parsehtml(resp_body)
    s=Selector(".brand-info .list-gapline")
    years = eachmatch(s, dom.root)
    if isempty(years)
      return []
    end
    tag_year = years[1]
    s=Selector("a[href^='/']:not(#carYearList_all)")
    return [Dict(:year=>nodeText(tag), :href=>tag.attributes["href"]) for tag in eachmatch(s, tag_year)]
  catch e
    []
  end
end

# years = extract_years(url)

# url = "http://car.bitauto.com/siyucivic/peizhi/2020/"
# 获取车型配置数据
function extract_config(url)
  try
    resp_body = fetchpage(url)
    reg = r"\[\[\[.+]]]"
    m = match(reg,resp_body,1)
    return JSON.parse(replace(m.match, "\t"=>""))
  catch e
    println("extract_config error!!!")
    return []
  end
end

# configs = extract_config(url)



conn = LibPQ.Connection("host=127.0.0.1 port=5432 dbname=europe_time_logistics_development user=fuyuan password=fuyuan")

brands = fetch_brands()
brand_id = 1
year_id = 1
model_id = 1
detail_id = 1
for brand in brands
  execute(conn, "begin;")
  # 先跑一个品牌
  # if brand_id > 1
  #   break
  # end
  car_brands_id, car_brands_brand, car_brands_models, car_brands_abc, car_brands_created_at, car_brands_updated_at = [], [], [], [], [], [], []
  push!(car_brands_id, brand_id)
  push!(car_brands_brand, brand[:name])
  push!(car_brands_abc, "")
  push!(car_brands_created_at, now())
  push!(car_brands_updated_at, now())

  global brand_id += 1

  # 获取所有车型
  model_url = "http://car.bitauto.com"*brand[:url]
  models = extract_models(model_url)
  for model in models
    push!(car_brands_models, model[:title])
    println(model)
    # 获取所有年份
    year_url = "http://car.bitauto.com"*model[:href]
    years = extract_years(year_url)
    car_year_id, year_brand, year_models, year_year, year_created_at, year_updated_at = [],[],[],[],[],[]
    for yy in years
      println(yy)
      push!(car_year_id, year_id)
      push!(year_brand, brand[:name])
      push!(year_models, model[:title])
      push!(year_year, yy[:year])
      push!(year_created_at, now())
      push!(year_updated_at, now())

      config_href = split(strip(yy[:href], '/'), "/")
      config_url = join(["http://car.bitauto.com/", config_href[1], "/peizhi/", config_href[2]])
      configs = extract_config(config_url)
      car_model_id, car_model_year_id, car_model_name, car_model_version, car_model_created_at, car_model_updated_at = [],[],[],[],[],[]
      car_detail_id, detail_model_id, detail_engine_capacity, detail_intake_type, detail_engine_max_power, detail_engine_max_torque, detail_gearbox,detail_length,detail_width,detail_height,detail_front_tire_size,detail_rear_tire_size, detail_ca, detail_ua = [],[],[],[],[],[],[],[],[],[],[],[],[],[]
      for config in configs
        println(config[1][2])
        push!(car_model_id, model_id)
        push!(car_model_year_id, year_id)
        push!(car_model_name, model[:title]*" "*yy[:year])
        push!(car_model_version, config[1][2])
        push!(car_model_created_at, now())
        push!(car_model_updated_at, now())

        engine_capacity = config[2][5]
        intake_type = config[2][6]
        engine_max_power = config[4][3]
        engine_max_torque = config[4][6]
        gearbox = config[2][8]*"档"*config[2][9]
        length = tryparse(Int64, isempty(config[3][1]) ? "0" : config[3][1])
        width = tryparse(Int64, isempty(config[3][2]) ? "0" : config[3][2])
        height = tryparse(Int64, isempty(config[3][3]) ? "0" : config[3][3])
        front_tire_size = config[3][9]
        rear_tire_size = config[3][10]

        push!(car_detail_id, detail_id)
        push!(detail_model_id, model_id)
        push!(detail_engine_capacity, engine_capacity)
        push!(detail_intake_type, intake_type)
        push!(detail_engine_max_power, engine_max_power)
        push!(detail_engine_max_torque, engine_max_torque)
        push!(detail_gearbox, gearbox)
        push!(detail_length, length)
        push!(detail_width, width)
        push!(detail_height, height)
        push!(detail_front_tire_size, front_tire_size)
        push!(detail_rear_tire_size, rear_tire_size)
        push!(detail_ca, now())
        push!(detail_ua, now())

        global model_id += 1
        global detail_id += 1
      end
      LibPQ.load!((id=car_model_id,car_year_id=car_model_year_id,model_name=car_model_name,model_version=car_model_version,created_at=car_model_created_at,updated_at=car_model_updated_at),conn, "insert into car_models (id,car_year_id,model_name,model_version,created_at,updated_at) values (\$1,\$2,\$3,\$4,\$5,\$6);")

      LibPQ.load!((id=car_detail_id,car_model_id=detail_model_id,engine_capacity=detail_engine_capacity,intake_type=detail_intake_type,engine_max_power=detail_engine_max_power,engine_max_torque=detail_engine_max_torque,gearbox=detail_gearbox, lenght=detail_length, width=detail_width, height=detail_height, front_tire_size=detail_front_tire_size, rear_tire_size=detail_rear_tire_size,created_at=detail_ca,updated_at=detail_ua),conn, "insert into car_model_details (id,car_model_id,engine_capacity,intake_type,engine_max_power,engine_max_torque,gearbox, lenght, width, height, front_tire_size, rear_tire_size,created_at,updated_at) values (\$1,\$2,\$3,\$4,\$5,\$6,\$7,\$8,\$9,\$10,\$11,\$12,\$13,\$14);")
      global year_id += 1
    end
    LibPQ.load!((id=car_year_id,brand=year_brand,models=year_models,year=year_year,created_at = year_created_at,updated_at = year_updated_at),conn, "insert into car_years (id,brand,models,year,created_at,updated_at) values (\$1,\$2,\$3,\$4,\$5,\$6);")
  end
  println(car_brands_models)
  LibPQ.load!((id=car_brands_id,brand=car_brands_brand,models=[[model for model in car_brands_models]],abc=car_brands_abc,created_at = car_brands_created_at,updated_at = car_brands_updated_at),conn, "insert into car_brands (id,brand,models,abc,created_at,updated_at) values (\$1,\$2,\$3,\$4,\$5,\$6);")
  execute(conn, "commit;")
end

close(conn)
