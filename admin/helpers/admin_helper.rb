# encoding: utf-8
module AutoAftermarketApi
  class Admin
    module AdminHelper
      def set_spus_title_and_local
        @title = "商品"
      end

      def set_accounts_title_and_local
        @title = "用户"
      end

      def set_categories_title_and_local
        @title = "目录"
      end

      def set_groups_title_and_local
        @title = "团购"
      end

      def set_seckills_title_and_local
        @title = "秒杀"
      end

      def set_coupons_title_and_local
        @title = "优惠券"
      end

      def set_skus_title_and_local
        @title = "优选"
      end

      def set_orders_title_and_local
        @title = "订单"
      end

      def set_questions_title_and_local
        @title = "问答"
      end

      def set_activities_title_and_local
        @title = "营销活动"
      end

      def set_customers_title_and_local
        @title = "用户"
      end

      def set_withdraws_title_and_local
        @title = "提现"
      end

      def set_dist_settings_title_and_local
        @title = "分销设置"
      end

      def set_agent_changes_title_and_local
        @title = "更换专属客服"
      end

      def set_purchases_title
        @title = "采购"
      end

    end

    helpers AdminHelper
  end
end
