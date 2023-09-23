class AvailableSlotsCalculator
  def initialize(therapist, package)
    @therapist = therapist
    @package = package
    @service = @package.service
  end

  def call
    calculate_available_slots_for_package
  end

  private

  def calculate_available_slots_for_package
    service_duration = @service.duration_per_unit.minutes
    final_available_slots = {}

    (Date.today + 1..Date.today + 60.days).each do |date|
      all_slots_for_day = get_all_slots_for_day(date)
      meetings_slots = get_meeting_slots_for(date)
      absences_slots = get_absence_slots_for(date)

      final_slots_for_day = filter_final_available_slots(all_slots_for_day, meetings_slots, absences_slots)
      final_available_slots[date] = final_slots_for_day
    end

    final_available_slots
  end

  def get_valid_week_availability_for(date)
    @therapist.week_availabilities.where("valid_from <= ? AND valid_until >= ?", date, date).first
  end

  def get_slots_from_time_blocks(time_blocks, date)
    day_of_week = date.wday
    relevant_time_blocks = time_blocks.select { |tb| week_day_to_integer(tb.week_day) == day_of_week }

    relevant_time_blocks.map do |time_block|
      slots = []
      time_slot = date.to_datetime.change({hour: time_block.start_time.hour, min: time_block.start_time.min})
      while time_slot + 15.minutes <= date.to_datetime.change({hour: time_block.end_time.hour, min: time_block.end_time.min})
        slots << time_slot
        time_slot += 15.minutes
      end
      slots
    end.flatten
  end

  def week_day_to_integer(week_day)
    days = %w[sunday monday tuesday wednesday thursday friday saturday]
    days.index(week_day)
  end

  def get_meeting_slots_for(date)
    # Chercher tous les meetings du therapist pour la date spécifiée
    Meeting.joins(:package).where(packages: { therapist_id: @therapist.id }).where("start_time::date = ?", date).flat_map do |meeting|
      slots = []
      meeting_start = meeting.start_time

      while meeting_start < meeting.end_time
        slots << meeting_start
        meeting_start += 15.minutes
      end
      slots
    end
  end


  def get_absence_slots_for(date)
    @therapist.absences.where("start_time::date = ?", date).flat_map do |absence|
      slots = []
      absence_start = absence.start_time
      while absence_start < absence.end_time
        slots << absence_start
        absence_start += 15.minutes
      end
      slots
    end
  end

  def get_all_slots_for_day(date)
    valid_week_availability = get_valid_week_availability_for(date)
    return [] unless valid_week_availability

    get_slots_from_time_blocks(valid_week_availability.time_blocks, date)
  end

  def filter_final_available_slots(all_available_slots, meetings_slots, absences_slots)
    blocked_slots = meetings_slots + absences_slots
    final_slots = all_available_slots.reject { |slot| blocked_slots.include?(slot) }
    filter_slots(final_slots)

  end

  def filter_slots(slots)
    slots.reject { |slot| slot.min == 15 || slot.min == 45 }
  end
end












  # Collect all packages for @therapist
  # for each package
  # collect the service duration (service)
  #   for each day until today to the next 2 weeks (date)
  #     collect all week availabilities form the therapist
  #     select the week availabilities that are valid for the date (with valid_from and valid_until) should only return one
  #     collect all time blocks from this week availability
  #       for each time block
  #         create array of time slots each 15 minutes long includes start and end time of the time block
    #         stock the time slots in an array
    #       for each meeting of the therapist
    #         create array of time slots each 15 minutes long includes start but not end time of the meeting
    #         stock the time slots in an array
    #       for each absence of the therapist
    #         create array of time slots each 15 minutes long includes start but not end time of the absence
    #         stock the time slots in an array
    #       for each time slot from the time block
    #         if the time slot is not included in the array of time slots from meetings and absences, stock the time slot in an array of available time slots
    #       for each available time slot
    #         if the available time slot + service duration is included in the time block and not included in the array of time slots from meetings and absences, stock the available time slot in an array of available time slots
    #       stock the array of available time slots in a hash with the package as key


#     # Initialisation
#     available_time_slots_per_package = {}
#     # Parcourir tous les packages pour le thérapeute
#     @therapist.packages.each do |package|
#       service_duration = package.service.duration_per_unit.minutes
#       all_available_slots = []
#       # Pour chaque jour depuis aujourd'hui jusqu'à 2 semaines plus tard
#       (Date.today..Date.today + 14.days).each do |date|
#         # Sélectionner la week_availability valide pour cette date
#         valid_week_availability = @therapist.week_availabilities.where("valid_from <= ? AND valid_until >= ?", date, date).first
#         if valid_week_availability
#           # Pour chaque time_block de cette week_availability
#           valid_week_availability.time_blocks.each do |time_block|
#             # Créer un tableau de créneaux horaires par tranche de 15 minutes
#             time_slot = time_block.start_time
#             while time_slot + 15.minutes <= time_block.end_time
#               all_available_slots << time_slot
#               time_slot += 15.minutes
#             end
#           end
#         end
#         meetings_slots = Meeting.joins(:package).where(packages: { therapist_id: @therapist.id }).where("start_time::date = ?", date).map do |meeting|
#           meeting_start = meeting.start_time
#           slots = []
#           while meeting_start < meeting.end_time
#             slots << meeting_start
#             meeting_start += 15.minutes
#           end
#           slots
#         end.flatten
#         absences_slots = @therapist.absences.where("start_time::date = ?", date).map do |absence|
#           absence_start = absence.start_time
#           slots = []
#           while absence_start < absence.end_time
#             slots << absence_start
#             absence_start += 15.minutes
#           end
#           slots
#         end.flatten
#         # Supprimer les créneaux horaires qui se chevauchent avec des rendez-vous ou des absences
#         final_available_slots = all_available_slots - meetings_slots - absences_slots
#         # Filtrer les créneaux horaires en fonction de la durée du service
#         final_available_slots.select! do |slot|
#           (all_available_slots.include?(slot + service_duration)) &&
#           !meetings_slots.include?(slot + service_duration) &&
#           !absences_slots.include?(slot + service_duration)
#         end
#         available_time_slots_per_package[package] ||= {}
#         available_time_slots_per_package[package][date] = final_available_slots
#       end
#     end
#     # Le hash available_time_slots_per_package contient maintenant les créneaux horaires disponibles pour chaque package du thérapeute
