# app/helpers/charts_helper.rb
module ChartsHelper
  STATUS_COLORS = {
    "No date set" => "#DCDCDC",
    "Pending" => "#ce9a4c",
    "Confirmed" => "#40865d",
    "Cancelled" => "#464646",
    "Excused" => "#9B9B9B",
    "Done" => "#3B65A1"
  }.freeze

  def colors_for_data(data)
    data.keys.map { |status| STATUS_COLORS[status] }
  end
end
