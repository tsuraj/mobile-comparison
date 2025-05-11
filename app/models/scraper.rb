
    # //div[@class='st-text']//following::h4[normalize-space()='Popular reviews']
    # //tbody/tr[2]/td[1]/a[1]/../../..//a[normalize-space()='Acer']
    # //div[@class='st-text']/..//div[@class='st-text']


    require 'nokogiri'
    require 'open-uri'
    require 'byebug'
    require "httparty" 
    require 'active_support/core_ext/object/blank'
    
    class Scraper 
        def get_brand_urls
            p "processing brand urls**********************************************************************************"
            url = "https://www.gsmarena.com/makers.php3"
            base_url = "https://www.gsmarena.com/"
            html_content = URI.open(url)
            #response = HTTParty.get(url)
    
            doc = Nokogiri::HTML(html_content)
            brand_urls = []
            brand_urls_content = doc.xpath("//div[@class='st-text']").xpath("//tr/td//@href")
            brand_urls_content.each do |href|
                next if not href
                brand_urls << base_url + href.value
            end
            brand_urls[0...1]
        end
    
        def get_mobile_url_list
            p "processing mobiles urls**********************************************************************************"
            # need to uncomment this code while using main urls
            #results_url = get_brand_urls
            results_url = [] #["https://www.gsmarena.com/samsung-phones-9.php"]
            (14..28).each do |page_no|
                results_url << "https://www.gsmarena.com/samsung-phones-f-9-0-p#{page_no}.php"
            end
            base_url = "https://www.gsmarena.com/"
            mobile_urls = []
            results_url.each_with_index do |result_url, ind|
                p "page_url: #{result_url} *******************************************************88"

                next if not result_url
                html_content = URI.open(result_url)
                doc = Nokogiri::HTML(html_content)
                mobile_urls_content = doc.xpath("//div[@class='makers']/ul/li/a/@href")
                image_urls = doc.xpath("//div[@class='makers']/ul/li/a/img/@src")
                len = mobile_urls_content.length
                (0...len).each do |ind|
                    href = mobile_urls_content[ind]
                    next if not href
                    img = image_urls[ind]
                    mobile_urls << "#{base_url}#{href.value}|#{img}"
                end
                
            end
            mobile_urls
        end
    
        def get_mobile_details
            mobile_urls = get_mobile_url_list
            p "processing mobiles data **********************************************************************************"
            count = 0
            mobile_urls.each do |mobile_url|
                next if  not mobile_url
                mobile_url, img_url= mobile_url.split("|")
                html_content = URI.open(mobile_url)
                doc = Nokogiri::HTML(html_content)
                columns = []
        
        
                features = doc.xpath("//div[@id='specs-list']/table")
                res = {}

                features.each do |feature|
                        
                    key = feature.css("th").first.content
                    values = feature.css("td")
                    sub_hash = {}
                    last_key = " "
        
                    values.each_with_index do |ele,ind|
                        next if ind%2!=0
                        if ele.content.strip.blank?
                            key_ele = last_key
                            sub_hash[key_ele] = "#{sub_hash[key_ele]}, #{values[ind+1].content.strip}"
                        else
                            key_ele = ele.content.strip
                            sub_hash[key_ele] = values[ind+1].content
                            last_key = key_ele
                        end
                        
                        
                    end

                    res[key] = sub_hash
                end
                data_hash = {}
                data_hash[:brand] = mobile_url.split("/").last.split("_").first
                
                model_cont = doc.xpath("//h1").first
                model = model_cont.content if model
                unless model.present?
                   model =  doc.xpath("//h1[@data-spec='modelname']").first.content
                end
                data_hash[:model] = model
                data_hash[:processor] = res["Platform"]["Chipset"] rescue nil
                data_hash[:release_date] = Date.parse(res["Launch"]["Announced"]) rescue Date.parse(res["Launch"]["Announced"].split(",").first) rescue nil
                data_hash[:display_size] = res["Display"]["Size"]  rescue nil
                data_hash[:resolution]  = res["Display"]["Resolution"]  rescue nil
                data_hash[:ram] =  res["Memory"]["Internal"] rescue nil
                data_hash[:storage] = res["Memory"]["Internal"] rescue nil
                data_hash[:camera_main] = res["Main Camera"]["Dual"] || res["Main Camera"]["Triple"] rescue nil
                data_hash[:camera_front] = res["Selfie camera"]["Single"] rescue nil
                data_hash[:battery] = res["Battery"]["Type"] rescue nil
                data_hash[:os_version] = res["Platform"]["OS"] rescue nil
                data_hash[:price] = res["Misc"]["Price"] rescue nil
                data_hash[:image_url] = img_url #"https://fdn2.gsmarena.com/vv/pics/oneplus/oneplus-nord-2t-5g-2.jpg" #doc.xpath("//div[@class='specs-photo-main']/a/@href").first.content
                Mobile.find_or_create_by(data_hash)
                count = count + 1
                if count%20 == 0
                    sleep 15
                end
                p "done with data #{count}**********************************************************"
            end

        end
    
    
end
    
    
# mobile_url =  "https://www.gsmarena.com/xiaomi_mix_flip-13221.php" #"https://www.gsmarena.com/acer_acerone_liquid_s272e4-13757.php"
# res = Scraper.new.get_mobile_details(mobile_url)