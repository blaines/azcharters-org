#
# Tiny
#
# A reversible base62 ID obfuscater
#
# Authors:
#  Jacob DeHart (original PHP version) and Kyle Bragger (Ruby port)
#
# Usage:
#  obfuscated_id = Tiny::tiny(123)
#  original_id = Tiny::untiny(obfuscated_id)
#
# Configuration:
#  * You must run Tiny::generate_set() from console to generate your TINY_SET
#    Do *not* change this once you start using Tiny, as you won't be able to untiny()
#    any values tiny()'ed with another set.
#  * generate_set() will also print a value for TINY_EPOCH; once set, this shouldn't be
#    changed either.
#
module Tiny
  TINY_SET   = "nsZJ3A6vYCoi9tg2eGSzXNqhWcdEUrub8BkwOF4MKxljfI0yT175DmRpPHLaVQ"
  TINY_EPOCH = 1284101592
  
  class << self
    def tiny(id)
      hex_n = ''
      id    = id.to_i.abs.floor
      radix = TINY_SET.length
      while true
        r     = id % radix
        hex_n = TINY_SET[r,1] + hex_n
        id    = (id - r) / radix
        break if id == 0
      end
      return hex_n
    end

    def untiny(str)
      radix  = TINY_SET.length
      strlen = str.length
      n      = 0
      (0..strlen - 1).each do |i|
        n += TINY_SET.index(str[i,1]) * (radix ** (strlen - i - 1))
      end
      return n.to_s
    end
    
    # Same as tiny() but use the current UNIX timestamp - TINY_EPOCH (hat tip: Nir Yariv)
    def tiny_from_timestamp
      tiny(Time.now.to_f - TINY_EPOCH)
    end
    
    def generate_set
      base_set = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
      base_set = base_set.sort_by{ rand }.to_s
      puts "generate_set()"
      puts base_set
      puts "TINY_EPOCH = #{Time.now.to_i}"
    end
  end
end