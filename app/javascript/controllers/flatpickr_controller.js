// app/javascript/controllers/flatpickr_controller.js

import { Controller } from "stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = ["startDateInput", "endDateInput"]

  connect() {
    flatpickr(this.startDateInputTarget, {
      altInput: true,  // Utiliser un champ alternatif pour afficher la date au format lisible
      dateFormat: "Y-m-d",  // Format de la date
      minDate: "today",  // Date minimale (aujourd'hui)
    })

    flatpickr(this.endDateInputTarget, {
      altInput: true,
      dateFormat: "Y-m-d",
      minDate: "today",
    })
  }
}
