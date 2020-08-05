# encoding: utf-8

# 评价相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/comments' do
  before do
    load_api_request_params
  end

  # 待评价商品列表
  # params 空
  # data
=begin
  [
    {
        "id": 2,
        "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-30 SN级 （1L装）",
        "sku_code": "AN01224232",
        "images": [
            "/uploads/t_sku/images/2/images/260811002.jpg",
            "/uploads/t_sku/images/2/images/1336270541.jpg"
        ],
        "order_id": 3
    }
  ]
=end
  post :to_dos, :provides => [:json] do
    api_rescue do
      authenticate

      @order_skus = OrderSku.where(comment_status: 0).where("(SELECT orders.customer_id FROM orders WHERE orders.order_no = order_skus.order_no) = #{@customer.id}")
      { status: 'succ', data: @order_skus.map(&:to_api_comment)}.to_json
    end
  end

  # 评价
  # params {"sku_id": 2, "order_id": 1, "rating": 5, "images": ["",""], "content": ""}
  # sku_id--商品id，order_id--订单id，rating--评分1-5之间的整数，content--评价内容，images--评价所带图片支持多个
  # 其中图片需要通过Base64编码
  # data {}
  post :create, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        raise "商品id不能都为空" if @request_params['sku_id'].blank?
        raise "订单id不能都为空" if @request_params['order_id'].blank?
        raise "评分不能都为空" if @request_params['rating'].blank?
        raise "评价内容或图片不能都为空" if @request_params['content'].blank? && @request_params['images'].blank?
        order = Order.find(@request_params['order_id'])
        sku = TSku.find(@request_params['sku_id'])
        order_sku = OrderSku.find_by(order_no: order.order_no, t_sku_id: @request_params['sku_id'])
        @comment = Comment.new(content: @request_params['content'], order_id: order.id, t_sku_id: sku.id, rating: @request_params['rating'], t_spu_id: sku.t_spu_id, customer_id: @customer.id)
        i = 0
        images = []
        if @request_params['images'].present? # 保存图片
          @request_params['images'].each do |img|
            file_path = "public/uploads/tmp/comment#{order_sku.id}#{Time.now.strftime('%Y%m%d%H%M%S')}#{i}"
            decode_base64_content = Base64.decode64(img)
            File.delete(file_path) if File.exists?(file_path)
            File.open(file_path, "wb"){|f| f.write decode_base64_content}
            # File.open(file_path, "rb"){|f| @answer.images = f }
            images << File.open(file_path, "rb")
            i += 1
          end
        end
        @comment.images = images

        order_sku.update!(comment_status: 1)
        @comment.save!
      end

      { status: 'succ', data: {}}.to_json
    end
  end

  # 用户评价列表，返回请求用户的评价
  # params {order_id: 1, sku_id: 1} 可根据订单id或商品id筛选
  # data
=begin
  [
      {
          "id": 2,
          "content": "哈哈哈",
          rating: 4,
          "images": [
              "/uploads/comment/images/2/comment3202008050946400",
              "/uploads/comment/images/2/comment3202008050946401"
          ],
          "order": "100000001220200716171336",
          "sku": {
              "id": 3,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
              "sku_code": "AN01224233",
              "images": [
                  "/uploads/t_sku/images/3/images/260811002.jpg",
                  "/uploads/t_sku/images/3/images/1336270541.jpg"
              ]
          }
      }
  ]
=end
  post :selfs, :provides => [:json] do
    api_rescue do
      authenticate

      @comments = @customer.comments
      @comments = @comments.where(order_id: @request_params['order_id']) if @request_params['order_id'].present?
      @comments = @comments.where(t_sku_id: @request_params['sku_id']) if @request_params['sku_id'].present?
      { status: 'succ', data: @comments.map(&:to_api)}.to_json
    end
  end

  # 商品评价列表，返回商品的评价
  # params {spu_id: 1, sku_id: 1} spu_id、sku_id不能同时为空
  # data
=begin
  [
      {
          "id": 2,
          "content": "哈哈哈",
          rating: 4,
          "images": [
              "/uploads/comment/images/2/comment3202008050946400",
              "/uploads/comment/images/2/comment3202008050946401"
          ],
          "order": "100000001220200716171336",
          "sku": {
              "id": 3,
              "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
              "sku_code": "AN01224233",
              "images": [
                  "/uploads/t_sku/images/3/images/260811002.jpg",
                  "/uploads/t_sku/images/3/images/1336270541.jpg"
              ]
          }
      }
  ]
=end
  post :index, :provides => [:json] do
    api_rescue do
      authenticate


      if @request_params['sku_id'].present?
        @comments = Comment.where(t_sku_id: @request_params['sku_id'])
      elsif @request_params['spu_id'].present?
        @comments = Comment.where(t_spu_id: @request_params['spu_id'])
      else
        @comments = Comment.where("1=2")
      end
      { status: 'succ', data: @comments.map(&:to_api)}.to_json
    end
  end

  # 评论删除
  # params {"comment_id"=>1}
  # data {"}
  post :delete, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        @comment = Comment.find(@request_params['comment_id'])
        @comment.destroy
      end

      { status: 'succ', data: {}}.to_json
    end
  end

end
