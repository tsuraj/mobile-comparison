module Api
    module V1
      class MobilesController < ApplicationController
        before_action :set_mobile, only: [:show]
  
        def index
          mobiles = Mobile.all
          @mobiles = []
          mobiles.each do |mobile|
            next if not mobile
            mobile.storage =  mobile.storage.split(" ").first.to_i if mobile.storage.present?
           # mobile.ram =    mobile.ram.match?(/^\d+$/) ?  mobile.ram : (mobile.ram.present? && mobile.ram.split(" ")[1].present?) ?  mobile.ram.split(" ")[1].to_i : mobile.ram.split(" ").first.to_i
            mobile.ram = if mobile.ram.present? 
                            if mobile.ram.match?(/^\d+$/)
                                  mobile.ram
                            else 
                              if mobile.ram.split(" ")[1].present?
                                  mobile.ram.split(" ")[1].to_i
                              else
                                mobile.ram.split(" ").first.to_i
                              end
                            end
                          end


            mobile.display_size = mobile.display_size.split(" ").first unless mobile.display_size.nil?
            @mobiles << mobile
          end

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

        def mobile_scrape 
          mobile_url =  "https://www.gsmarena.com/xiaomi_mix_flip-13221.php" #"https://www.gsmarena.com/acer_acerone_liquid_s272e4-13757.php"
          res = Scraper.new.get_mobile_details
        end
  
        private
  
        def set_mobile
          @mobile = Mobile.find(params[:id])
        end
      end
    end
end