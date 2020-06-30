# encoding: utf-8
module AutoAftermarketApi
  class Admin
    module AdminHelper
      def set_spus_title_and_local
        @title = "商品"
        @local = "商品"
      end

      def set_accounts_title_and_local
        @title = "用户"
        @local = "用户"
      end

      def set_categories_title_and_local
        @title = "目录"
        @local = "目录"
      end

      def set_groups_title_and_local
        @title = "团购"
        @local = "团购"
      end

      def set_seckills_title_and_local
        @title = "秒杀"
        @local = "秒杀"
      end

      def set_coupons_title_and_local
        @title = "优惠券"
        @local = "优惠券"
      end

    end

    helpers AdminHelper
  end
end
