module TimeBlocksHelper

  def time_block_for_day(week_availability, day)
    time_block = week_availability.time_blocks.find_by(week_day: day)
    time_block || week_availability.time_blocks.build(week_day: day)
  end

  def render_card(week_availability, day)
    time_block = time_block_for_day(week_availability, day)
    content_tag(:div, class: 'card') do
      content_tag(:div, class: 'card-header') do
        "Time Block for #{day.capitalize}"
      end +
      content_tag(:div, class: 'card-body') do
        content_tag(:p, "Start Time: #{time_block.start_time}")
        content_tag(:p, "End Time: #{time_block.end_time}")
      end
    end
  end
end
