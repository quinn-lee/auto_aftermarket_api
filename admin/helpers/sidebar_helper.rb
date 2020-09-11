# encoding: utf-8
module AutoAftermarketApi
  class Admin
    module SidebarHelper
      def sidebar_menu
        # 商品
        nav_commodities = {
          :label => '商品', :icon => 'gears', :field => 'nav_commodities',
          :options => [
            { :label => '目录', :icon => '', :url => url(:categories, :index) },
            { :label => '商品', :icon => '', :url => url(:spus, :index) },
            { :label => '商品榜单', :icon => '', :url => '' }
          ]
        }
        nav_customers = {
          :label => '客户', :icon => 'users', :field => 'nav_customers',
          :options => [
            { :label => '客户列表', :icon => '', :url => url(:customers, :index) },
            { :label => '更换专属客服申请', :icon => '', :url => url(:agent_changes, :index) },
            { :label => '客户画像', :icon => '', :url => '' },
            { :label => '客户活跃度', :icon => '', :url => '' },
            { :label => '客户行为统计', :icon => '', :url => '' },
            { :label => '标签管理', :icon => '', :url => '' }
          ]
        }
        nav_staffs = {
          :label => '员工', :icon => 'user', :field => 'nav_staffs',
          :options => [
            { :label => 'BOSS雷达', :icon => '', :url => '' },
            { :label => '员工列表', :icon => '', :url => url(:accounts, :index) }
          ]
        }
        nav_car_data = {
          :label => '汽车基础数据', :icon => 'car', :field => 'nav_car_data',
          :options => [
            { :label => '汽车品牌', :icon => '', :url => '' },
            { :label => '车型', :icon => '', :url => '' }
          ]
        }
        nav_orders = {
          :label => '订单管理', :icon => 'file-text-o', :field => 'nav_orders',
          :options => [
            { :label => '订单列表', :icon => '', :url => url(:orders, :index) },
            { :label => '待采购', :icon => '', :url => url(:orders, :purchases) },
            { :label => '待发货', :icon => '', :url => url(:orders, :deliveries) },
            { :label => '取消审核', :icon => '', :url => url(:orders, :cancelling) },
            { :label => '预约时间表', :icon => '', :url => url(:orders, :reservations) },
            { :label => '预约时间表(gantt)', :icon => '', :url => url(:orders, :reservations_gantt) },
            { :label => '预约时间表(calendar)', :icon => '', :url => url(:orders, :reservations_calendar) },
            { :label => '员工订单统计', :icon => '', :url => '' },
            { :label => '员工佣金统计', :icon => '', :url => '' },
            { :label => '特权折扣', :icon => '', :url => '' }
          ]
        }
        nav_purchases = {
          :label => '采购管理', :icon => 'cart-plus', :field => 'nav_purchase_data',
          :options => [
            { :label => '采购列表', :icon => '', :url => url(:purchases, :index) }
          ]
        }
        nav_activities = {
          :label => '营销活动', :icon => 'tags', :field => 'nav_activities',
          :options => [
            { :label => '秒杀', :icon => '', :url => url(:seckills, :index) },
            { :label => '团购', :icon => '', :url => url(:groups, :index) },
            { :label => '优惠券', :icon => '', :url => url(:coupons, :index) },
            { :label => '优选标签', :icon => '', :url => url(:labels, :preferred_labels) },
            { :label => '优选商品', :icon => '', :url => url(:skus, :preferred) }
          ]
        }
        nav_dist = {
          :label => '分销', :icon => 'link', :field => 'nav_dist',
          :options => [
            { :label => '分销设置', :icon => '', :url => url(:dist_settings, :new) },
            { :label => '分销角色', :icon => '', :url => url(:dist_settings, :dist_roles) },
            { :label => '营销活动', :icon => '', :url => url(:activities, :index) },
            { :label => '销售/分销员审核', :icon => '', :url => url(:customers, :agents) },
            { :label => '提现申请处理', :icon => '', :url => url(:withdraws, :index ) }
          ]
        }
        nav_questions = {
          :label => '问答', :icon => 'comments-o', :field => 'nav_questions',
          :options => [
            { :label => '话题', :icon => '', :url => url(:questions, :topics) },
            { :label => '问答', :icon => '', :url => url(:questions, :index) }
          ]
        }
        nav_finance = {
          :label => '财务', :icon => 'table', :field => 'nav_finance',
          :options => [
            { :label => '应收信息', :icon => '', :url => url(:finance, :incomes)},
            { :label => '应付信息', :icon => '', :url => url(:finance, :outlays)},
            { :label => '财务对账', :icon => '', :url => ''}
          ]
        }
        nav_miniprogram = {
          :label => '小程序设置', :icon => 'mobile', :field => 'miniprogram',
          :options => [
            { :label => '聊天设置', :icon => '', :url => '' },
            { :label => '首页栏目', :icon => '', :url => '' },
            { :label => '手机号授权', :icon => '', :url => '' }
          ]
        }
        nav_css_demo = {
          :label => 'CSS DEMO', :icon => 'css3', :field => 'nav_css_demo',
          :options => [
            { :label => '基础样式', :icon => '', :url => url(:css_demo, :index) },
            { :label => '预约时间表样式', :icon => '', :url => url(:css_demo, :schedule) }
          ]
        }

        menu = []
        menu << nav_commodities
        menu << nav_customers
        menu << nav_staffs
        menu << nav_car_data
        menu << nav_orders
        menu << nav_purchases
        menu << nav_activities
        menu << nav_dist
        menu << nav_questions
        menu << nav_finance
        menu << nav_miniprogram
        menu << nav_css_demo
        menu # return
      end

      def sidebar_menu_active
        @active_path ||= request.path  # 如需激活指定menu选项, 请赋值实例变量 @active_path
        @sidebar_menu = sidebar_menu
        @sidebar_menu.each do |item|
          item[:options].each do |option|
            if option[:url] == @active_path
              item[:active] = true
              option[:active] = true
            end
          end
        end
        @sidebar_menu
      end
    end
    helpers SidebarHelper
  end
end
