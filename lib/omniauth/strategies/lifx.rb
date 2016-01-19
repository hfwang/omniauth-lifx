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
        user_uuid
      }

      # extra do
      #   { :endpoints => raw_info }
      # end

      def user_uuid
        all_lights
        @user_uuid
      end

      def all_lights
        return @all_lights if @all_lights
        @all_lights = {}
        uri = URI("https://api.lifx.com/v1/lights/all")
        req = Net::HTTP::Get.new(uri)
        req["Authorization"] = "Bearer #{access_token.token}"
        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          res = http.request(req)
          @user_uuid = res["Lifx-Account-Uuid"]
          @all_lights = JSON.parse(res.body)
        end
        return @all_lights
      end
    end
  end
end
