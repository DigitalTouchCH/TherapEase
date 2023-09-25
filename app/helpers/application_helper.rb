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

  def status_class(status)
    case status
    when "No date set"
      "status-no-date"
    when "Pending"
      "status-pending"
    when "Confirmed"
      "status-confirmed"
    when "Cancelled"
      "status-cancelled"
    when "Excused"
      "status-excused"
    when "Done"
      "status-done"
    else
      ""
    end
  end

  FACTOR = 1
  START_TIME = 8.0
  END_TIME = 17.0
  TOTAL_HOURS = END_TIME - START_TIME
  INTERVAL = 15.minutes

  def calculate_top_position(event)
    start_hours_from_START_TIME = (event.start_time.seconds_since_midnight / 3600.0) - START_TIME
    start_hours_from_START_TIME = 0 if start_hours_from_START_TIME < 0
    top_position = (start_hours_from_START_TIME / TOTAL_HOURS) * 100
    top_position*FACTOR
  end


  def calculate_height_for_meeting(event)
    start_time = event.start_time

    if event.respond_to?(:package) && event.package&.service&.duration_per_unit
      duration = event.package.service.duration_per_unit.minutes
    elsif event.respond_to?(:start_time) && event.respond_to?(:end_time)
      duration = event.end_time - event.start_time
    else
      duration = 29*60
    end

    end_time = start_time + duration
    hours = (end_time - start_time).seconds.to_i / 3600.0
    height_for_event = (hours / TOTAL_HOURS) * 100
    height_for_event*FACTOR
  end

  def time_slots()
    start_time = Time.now.beginning_of_day + START_TIME.to_i.hours
    end_time = Time.now.beginning_of_day + END_TIME.to_i.hours
    (start_time.to_i..end_time.to_i).step(INTERVAL).map { |time| Time.at(time) }
  end

  def calculate_top_position_for_time_slot(time_slot)
    start_hours_from_START_TIME = (time_slot.seconds_since_midnight / 3600.0) - START_TIME
    start_hours_from_START_TIME = 0 if start_hours_from_START_TIME < 0
    top_position = (start_hours_from_START_TIME / TOTAL_HOURS) * 100
    top_position * FACTOR
  end

  def calculate_height_for_time_slot
    0.1
  end



end
