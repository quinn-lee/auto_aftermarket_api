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

    end

    helpers AdminHelper
  end
end
