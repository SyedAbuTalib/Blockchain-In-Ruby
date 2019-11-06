# frozen_string_literal: true

require 'digest'
require 'pp'

class Block
  attr_reader :data
  attr_reader :hash
  attr_reader :nonce

  def initialize(data)
    @data = data
    @nonce, @hash = compute_hash_with_proof_of_work
  end

  def compute_hash_with_proof_of_work(difficulty = '00000')
    nonce = 0
    loop do
      hash = Digest::SHA256.hexdigest("#{nonce}#{data}")
      return [nonce, hash] if hash.start_with?(difficulty)

      nonce += 1
    end
  end
end

pp Block.new('Hello, Cryptos!')

pp Block.new('Hello Hello Hello')
