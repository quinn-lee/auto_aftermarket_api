# encoding: utf-8
# 答案点赞
class AnswerLike < ActiveRecord::Base
  belongs_to :answer,   :class_name => 'Answer'

end
