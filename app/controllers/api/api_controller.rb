# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    before_action :authorize_user

    def authorize_user
      unless request.headers['Authorization'].present?
        return render json: { error: 'Unauthorized Request' }, status: :unauthorized
      end

      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').second,
                                  Rails.application.credentials.fetch(:secret_key_base)).first

        @user = User.find(jwt_payload['sub'])
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        render json: { error: 'Invalid Token' }, status: :unauthorized
      end
    end
  end
end
