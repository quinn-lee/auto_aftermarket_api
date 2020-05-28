module RandomCode
  class << self
    # 产生随机token
    def generate_token len = 8
      seed = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a
      token = ""
      len.times { |t| token << seed.sample.to_s }
      token
    end
  end
end
