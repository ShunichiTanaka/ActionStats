# frozen_string_literal: true

module Service
  module Devise
    class UnlocksController < ::Devise::UnlocksController
      # GET /resource/unlock/new
      def new
        # つぶす（画面から凍結解除できなくする）
        redirect_to service_root_path
      end

      # POST /resource/unlock
      def create
        # つぶす（画面から凍結解除できなくする）
        redirect_to service_root_path
      end

      # GET /resource/unlock?unlock_token=abcdef
      def show
        # つぶす（画面から凍結解除できなくする）
        redirect_to service_root_path
      end

      # protected

      # The path used after sending unlock password instructions
      # def after_sending_unlock_instructions_path_for(resource)
      #   super(resource)
      # end

      # The path used after unlocking the resource
      # def after_unlock_path_for(resource)
      #   super(resource)
      # end
    end
  end
end
