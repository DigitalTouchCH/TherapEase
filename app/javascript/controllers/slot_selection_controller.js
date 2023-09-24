import { Controller } from "@hotwired/stimulus"
import moment from 'moment';
import 'moment-timezone';

export default class extends Controller {
  static targets = ["slot", "startTime", "endTime", "status"]

  connect() {
    console.log("Slot controller connected!")
  }

  select(event) {
    console.log("Slot selected!");

    const duration = parseInt(this.data.get('duration'));

    // Mise à jour de startTime avec correction du décalage horaire
    const selectedTimeMoment = moment.tz(event.currentTarget.getAttribute('data-time'), 'UTC');
    this.startTimeTarget.value = selectedTimeMoment.format('D MMMM YYYY [from] HH:mm');

    // Mise à jour de endTime avec correction du décalage horaire
    const endTimeMoment = selectedTimeMoment.clone().add(duration, 'minutes'); // Utilisez .clone() pour éviter de modifier l'objet original
    this.endTimeTarget.value = endTimeMoment.format('D MMMM YYYY [from] HH:mm');

    // Mise à jour du statut à "Pending"
    this.statusTarget.value = "Pending";

    // Pour gérer le style de sélection
    this.slotTargets.forEach(slot => slot.classList.remove('selected-slot'));
    event.currentTarget.classList.add('selected-slot');
  }
}
