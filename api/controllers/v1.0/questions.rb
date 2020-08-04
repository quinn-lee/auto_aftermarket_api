# encoding: utf-8

# 问答相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/questions' do
  before do
    load_api_request_params
  end

  # 话题列表
  # params {}
  # data [{"id": 1,"title": "维修"},{"id": 2,"title": "保养"}]
  post "/topics", :provides => [:json] do
    api_rescue do
      authenticate
      @topics = Topic.all
      { status: 'succ', data: @topics.map(&:to_api)}.to_json
    end
  end

  # 提问
  # params {"content": "", "topic_id": 1, "anonymous": 't'/'f', "sku_id": 2}
  # content--提问内容，topic_id--提问时选择的话题id，anonymous--是否匿名提问't'为是，'f'为否，sku_id--商品id
  # data {}
  post "/create", :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "所有参数都不能为空" if @request_params['content'].blank? || @request_params['topic_id'].blank? || @request_params['anonymous'].blank?
        topic = Topic.find(@request_params['topic_id'])
        @question = Question.new(content: @request_params['content'], merchant_id: @merchant.id, topic_id: topic.id, t_sku_id: @request_params['sku_id'])
        @question.customer_id = @customer.id if @request_params['anonymous'] != "t" # 不匿名时才记录提问者
        @question.save!
      end

      { status: 'succ', data: {}}.to_json
    end
  end

  # 回答
  # params {"content": "", "question_id": 1, "images": ["",""], "audio": "", "anonymous": 't'/'f'}
  # content--回答内容，question_id--问题id，images--回答所带图片支持多个，audio--回答语音， anonymous--是否匿名回答't'为是，'f'为否
  # 其中图片和语音，需要通过Base64编码
  # data {}
  post "/answer", :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "回答内容、图片、语音不能都为空" if @request_params['content'].blank? && @request_params['images'].blank? && @request_params['audio'].blank?
        question = Question.find(@request_params['question_id'])
        @answer = Answer.new(content: @request_params['content'], question_id: question.id)
        @answer.customer_id = @customer.id if @request_params['anonymous'] != "t" # 不匿名时才记录回答者
        i = 0
        images = []
        if @request_params['images'].present? # 保存图片
          @request_params['images'].each do |img|
            file_path = "public/uploads/tmp/answer#{question.id}#{Time.now.strftime('%Y%m%d%H%M%S')}#{i}"
            decode_base64_content = Base64.decode64(img)
            File.delete(file_path) if File.exists?(file_path)
            File.open(file_path, "wb"){|f| f.write decode_base64_content}
            # File.open(file_path, "rb"){|f| @answer.images = f }
            images << File.open(file_path, "rb")
            i += 1
          end
        end
        @answer.images = images
        if @request_params['audio'].present? # 保存语音
          file_path = "public/uploads/tmp/answer#{question.id}#{Time.now.strftime('%Y%m%d%H%M%S')}#{i}"
          decode_base64_content = Base64.decode64(@request_params['audio'])
          File.delete(file_path) if File.exists?(file_path)
          File.open(file_path, "wb"){|f| f.write decode_base64_content}
          File.open(file_path, "rb"){|f| @answer.audio = f }
        end
        question.update!(updated_at: Time.now)
        @answer.save!
      end

      { status: 'succ', data: {}}.to_json
    end
  end

  # 问题列表
  # params {"topic_id": 1, "self": "t"/"f", "content": "aaa", "sku_id": 2}
  # 可通过topic_id筛选，如果self为"t",只返回该用户问题，为"f"时，返回所有问题
  # data
=begin
    [
        {
            "id": 1,
            "content": "啥最好吃",  #问题内容
            "topic": {  #话题
                "id": 1,
                "title": "维修"
            },
            "customer": null,     #null时为匿名提问
            "customer_answers_num": 1, #客户回答数
            "customer_answers": [  #客户回答，已按照回答时间降序排列
                {
                    "id": 4,
                    "content": "aaaaaaaaa",   #回答内容
                    "images": [   #回答图片
                        "/uploads/answer/images/4/answer1202007072239161"
                    ],
                    "audio": "/uploads/answer/audio/4/answer1202007072239162",   #回答音频
                    "customer": {   #回答客户 null时，为匿名回答或者店家回复
                        "city": "Taizhou",
                        "gender": 1,
                        "country": "China",
                        "language": "zh_CN",
                        "nickName": "nonki",
                        "province": "Zhejiang",
                        "avatarUrl": "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwG"
                    },
                    "account": "N",  #是否为店家回复，Y为是，N为否
                    "answer_likes": 1,   #答案点赞数
                    "answer_liked": "Y", #当前请求用户是否点赞过该答案，"Y"点赞过，"N"未点赞过
                    "created_at": "2020-07-07 22:39:16"  #回答时间
                }
            ],
            "account_answers": [], #是店家回复，有回复时，内容与上面客户回复一致
            "created_at": "2020-07-07 17:50:39",
            "sku_id": 2
        },
        {
            "id": 2,
            "content": "啥最好吃!!!",
            "topic": {   # 话题
                "id": 1,
                "title": "维修"
            },
            "customer": {
                "city": "Taizhou",
                "gender": 1,
                "country": "China",
                "language": "zh_CN",
                "nickName": "nonki",
                "province": "Zhejiang",
                "avatarUrl": "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwG"
            },
            "customer_answers_num": 0,
            "customer_answers": [],
            "account_answers": [],
            "created_at": "2020-07-07 17:51:00"
        }
    ]
=end
  post "/index", :provides => [:json] do
    api_rescue do
      authenticate

      @questions = Question.where(merchant_id: @merchant.id)
      @questions = @questions.where(topic_id: @request_params['topic_id']) if @request_params['topic_id'].present?
      @questions = @questions.where(t_sku_id: @request_params['sku_id']) if @request_params['sku_id'].present?
      @questions = @questions.where(customer_id: @customer.id) if @request_params['self'] == "t"
      @questions = @questions.where("content like '%#{@request_params['content']}%'") if @request_params['content'].present?
      { status: 'succ', data: @questions.order("updated_at desc").map{|q| q.to_api(@customer)}}.to_json
    end
  end

  # 热门问题列表
  # params 空
  # data 与问题列表相同
  post "/popular", :provides => [:json] do
    api_rescue do
      authenticate

      @questions = Question.where(merchant_id: @merchant.id).joins(:answers).group("id").having("count(*) > ?", 2).order("count(*) desc")
      { status: 'succ', data: @questions.map{|q| q.to_api(@customer)}}.to_json
    end
  end

  # 问题详情
  # params {"question_id": 1}
  # data
=begin
        {
            "id": 1,
            "content": "啥最好吃",  #问题内容
            "topic": {  #话题
                "id": 1,
                "title": "维修"
            },
            "customer": null,     #null时为匿名提问
            "customer_answers_num": 1, #客户回答数
            "customer_answers": [  #客户回答，已按照回答时间降序排列
                {
                    "id": 4,
                    "content": "aaaaaaaaa",   #回答内容
                    "images": [   #回答图片
                        "/uploads/answer/images/4/answer1202007072239161"
                    ],
                    "audio": "/uploads/answer/audio/4/answer1202007072239162",   #回答音频
                    "customer": {   #回答客户 null时，为匿名回答或者店家回复
                        "city": "Taizhou",
                        "gender": 1,
                        "country": "China",
                        "language": "zh_CN",
                        "nickName": "nonki",
                        "province": "Zhejiang",
                        "avatarUrl": "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwG"
                    },
                    "account": "N",  #是否为店家回复，Y为是，N为否
                    "answer_likes": 0,   #答案点赞数
                    "answer_liked": "Y", #当前请求用户是否点赞过该答案，"Y"点赞过，"N"未点赞过
                    "created_at": "2020-07-07 22:39:16"  #回答时间
                }
            ],
            "account_answers": [], #是店家回复，有回复时，内容与上面客户回复一致
            "created_at": "2020-07-07 17:50:39"
        }
=end
  post "/show", :provides => [:json] do
    api_rescue do
      authenticate

      @question = Question.find(@request_params['question_id'])
      { status: 'succ', data: @question.to_api(@customer)}.to_json
    end
  end

  # 点赞答案
  # params {"answer_id": 1}
  # answer_id--答案id
  # data {}
  post "/answer/like", :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "问题ID不能为空" if @request_params['answer_id'].blank?
        answer = Answer.find(@request_params['answer_id'])
        if AnswerLike.where(answer_id: answer.id, customer_id: @customer.id).count == 0
          AnswerLike.create!(answer_id: answer.id, customer_id: @customer.id)
        end
      end

      { status: 'succ', data: {}}.to_json
    end
  end

  # 取消点赞答案
  # params {"answer_id": 1}
  # answer_id--答案id
  # data {}
  post "/answer/unlike", :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "问题ID不能为空" if @request_params['answer_id'].blank?
        answer = Answer.find(@request_params['answer_id'])
        if al = AnswerLike.find_by(answer_id: answer.id, customer_id: @customer.id)
          al.destroy
        end
      end

      { status: 'succ', data: {}}.to_json
    end
  end


end
