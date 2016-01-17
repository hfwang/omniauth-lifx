# encoding: UTF-8

require 'omniauth-oauth2'
require 'json'
require 'net/http'

module OmniAuth
  module Strategies
    class Lifx < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://cloud.lifx.com',
        :authorize_url => '/oauth/authorize',
        :token_url => '/oauth/token'
      }
      option :scope, "remote_control:all"

      uid {
        access_token.token
      }

      # extra do
      #   { :endpoints => raw_info }
      # end

      # def raw_info
      #   return @raw_info if @raw_info
      #   @raw_info = {}
      #   uri = URI("https://graph.api.smartthings.com/api/smartapps/endpoints")
      #   req = Net::HTTP::Get.new(uri)
      #   req["Authorization"] = "Bearer #{access_token.token}"
      #   Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      #     res = http.request(req)
      #     @raw_info = JSON.parse(res.body)
      #     puts res.body
      #   end
      #   return @raw_info
      # end
    end
  end
end
