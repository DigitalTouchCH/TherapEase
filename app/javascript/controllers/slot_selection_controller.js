import { Controller } from "@hotwired/stimulus"
import moment from 'moment';
import 'moment-timezone';

export default class extends Controller {
  static targets = ["slot", "startTime", "endTime", "status"]

  connect() {
    console.log("Slot controller connected!")
    this.slotTargets.forEach(slot => slot.classList.remove('selected-slot'));
  }

  select(event) {
    console.log("Slot selected!");

    const duration = parseInt(this.data.get('duration'));

    const selectedTimeMoment = moment.tz(event.currentTarget.getAttribute('data-time'), 'UTC');
    this.startTimeTarget.value = selectedTimeMoment.format('D MMMM YYYY [from] HH:mm');

    const endTimeMoment = selectedTimeMoment.clone().add(duration, 'minutes');
    this.endTimeTarget.value = endTimeMoment.format('HH:mm');

    this.statusTarget.value = "Pending";

    this.slotTargets.forEach(slot => slot.classList.remove('selected-slot'));
    event.currentTarget.classList.add('selected-slot');
  }
}
