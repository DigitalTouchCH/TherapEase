# app/helpers/charts_helper.rb
module ChartsHelper
  STATUS_COLORS = {
    "No date set" => "#DCDCDC",
    "Pending" => "#ff6b35",
    "Confirmed" => "#023e7d",
    "Cancelled" => "#9B9B9B",
    "Excused" => "#9B9B9B",
    "Done" => "#023e7d"
  }.freeze

  def colors_for_data(data)
    data.keys.map { |status| STATUS_COLORS[status] }
  end
end
