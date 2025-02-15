// app/javascript/controllers/dynamic_booking_controller.js

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["startDateInput", "endDateInput", "priceHolder"]

  connect() {
    this.updatePrice()
  }

  updatePrice() {
    const startDate = new Date(this.startDateInputTarget.value)
    const endDate = new Date(this.endDateInputTarget.value)
    const pricePerDay = parseFloat(this.data.get("priceValue"))

    // Calcul du prix total
    if (startDate && endDate && startDate < endDate) {
      const daysDifference = Math.ceil((endDate - startDate) / (1000 * 3600 * 24)) // Différence en jours
      const totalPrice = daysDifference * pricePerDay
      this.priceHolderTarget.textContent = totalPrice.toFixed(2) // Affichage du prix total
    }
  }
}
