class MobileDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def storage 
    object.storage.split(" ").first.to_i
  end

  def ram 
    object.storage.split(" ")[1].to_i
  end

  def display_size 
    object.display_size.split(" ").first
  end



end
