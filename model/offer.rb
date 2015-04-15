require 'digest/sha1'


class Offer < ActiveResource::Base
  self.site = "http://api.sponsorpay.com/feed/v1"
  @@params = {
      format: "json",
      locale: "de",
      offer_types: 112,
      timestamp: Time.now.to_time.to_i,
      apple_idfa:"",
      apple_idfa_tracking_enabled: true
    }
  @@api_key = ""

  def self.config_params( key, params = {} )
    @@api_key = key
    @@params = @@params.merge params
  end

  def self.params
    @@params.merge( hashkey: calculate_hash_key() )
  end

  def self.calculate_hash_query()
    @@params.sort{|a,b| a[0]<=>b[0]}.map{ |pair| pair.join("=") }.join("&") << "&#{@@api_key}"
  end

  def self.calculate_hash_key()
    Digest::SHA1.hexdigest calculate_hash_query()
  end

end