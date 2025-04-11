module Api
    module V1
      class MobilesController < ApplicationController
        before_action :set_mobile, only: [:show]
  
        def index
          @mobiles = Mobile.all
          render json: @mobiles
        end
  
        def show
          render json: @mobile
        end
  
        def compare
          mobile1 = Mobile.find(params[:mobile1_id])
          mobile2 = Mobile.find(params[:mobile2_id])
          
          render json: {
            mobile1: mobile1,
            mobile2: mobile2
          }
        end
  
        def search
          query = params[:query].downcase
          @mobiles = Mobile.where("LOWER(brand) LIKE ? OR LOWER(model) LIKE ?", "%#{query}%", "%#{query}%")
          render json: @mobiles
        end
  
        private
  
        def set_mobile
          @mobile = Mobile.find(params[:id])
        end
      end
    end
end