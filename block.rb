# frozen_string_literal: true

require 'digest'
require 'pp'

class Block
  attr_reader :data
  attr_reader :prev # prev block hash
  attr_reader :difficulty
  attr_reader :time
  attr_reader :nonce # lucky number

  def hash
    Digest::SHA256.hexdigest("#{nonce}#{time}#{difficulty}#{prev}#{data}")
  end

  def initialize(data, prev, difficulty: '0000')
    @data = data
    @prev = prev
    @difficulty = difficulty
    @nonce, @time = compute_hash_with_proof_of_work(difficulty)
  end

  def compute_hash_with_proof_of_work(difficulty = '00')
    nonce = 0
    time = Time.now.to_i
    loop do
      hash = Digest::SHA256.hexdigest("#{nonce}#{time}#{difficulty}#{prev}#{data}")
      return [nonce, time] if hash.start_with?(difficulty)

      nonce += 1
    end
  end
end

b0 = Block.new('One', '0000000000000000000000000000000000000000000000000000000')
b1 = Block.new('Two', b0.hash)
b2 = Block.new('Three', b1.hash)
b3 = Block.new('Four', b2.hash)

blockchain = [b0, b1, b2, b3]

pp blockchain
