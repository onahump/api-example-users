module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /api/v1/pets
      def index
        @users = User.all

        render json: @users
      end

      # GET /api/v1/pets/1
      def show
        if @user
          render json: @user.to_json(only: [:id, :name, :password])
        end
      end

      # POST /api/v1/pets
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user.to_json(only: [:id, :name, :password])
        end
      end

      # PATCH/PUT /api/v1/pets/1
      def update
        if @user.update(user_params)
          render json: @user
        end
      end

      # DELETE /api/v1/pets/1
      def destroy
        @user.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        end

        # Only allow a trusted parameter "white list" through.
        def user_params
          params.fetch(:user).permit(:name, :password)
          # .permit(:name, :status, :photo_url)
        end
      end
    end
  end