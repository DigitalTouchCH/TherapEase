module ApplicationHelper
  def youtube_video(url)
    render :partial => 'shared/video', :locals => { :url => url }
  end

  def format_price_per_unit(price)
    if price.to_i == price.to_f
      price.to_i.to_s
    else
      number_to_currency(price)
    end
  end
end
