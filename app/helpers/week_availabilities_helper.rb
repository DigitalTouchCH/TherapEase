# app/helpers/week_availabilities_helper.rb

module WeekAvailabilitiesHelper
  # Méthode pour afficher un tableau de cartes de time blocks
  def render_time_blocks_table(week_availability)
    content_tag(:table, class: 'table') do
      concat(content_tag(:thead) do
        concat(content_tag(:tr) do
          concat(content_tag(:th, 'Day'))
          concat(content_tag(:th, 'Start Time'))
          concat(content_tag(:th, 'End Time'))
          concat(content_tag(:th, 'Actions'))
        end)
      end)

      concat(content_tag(:tbody) do
        week_availability.time_blocks.each do |time_block|
          concat(render_time_block_row(time_block))
        end
      end)
    end
  end

  # Méthode pour afficher une ligne de tableau de time block
  def render_time_block_row(time_block)
    content_tag(:tr) do
      concat(content_tag(:td, time_block.week_day))
      concat(content_tag(:td, time_block.start_time))
      concat(content_tag(:td, time_block.end_time))
      concat(content_tag(:td) do
        concat(link_to('Edit', edit_time_block_path(time_block), class: 'btn btn-warning btn-sm'))
        concat(link_to('Delete', time_block_path(time_block), method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-danger btn-sm'))
      end)
    end
  end

  TOTAL_HOURS = 18.0

  def height_percentage(start_time, end_time)
    hours = (end_time - start_time).seconds.to_i / 3600.0
    (hours / TOTAL_HOURS) * 100
  end

  def top_position(start_time)
    start_hours_from_5_am = (start_time.seconds_since_midnight / 3600.0) - 5.0
    start_hours_from_5_am = 0 if start_hours_from_5_am < 0
    (start_hours_from_5_am / TOTAL_HOURS) * 100
end


end
