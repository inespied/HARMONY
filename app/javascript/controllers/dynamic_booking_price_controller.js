import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDateInput", "endDateInput", "priceHolder", "totalPriceInput"];

  connect() {
    console.log("Dynamic Booking Controller connected");
  }

  updatePrice() {
    this.priceHolderTarget.textContent = "Calcul en cours...";
    setTimeout(() => {
      try {
        const startDateValue = this.startDateInputTarget.value;
        const endDateValue = this.endDateInputTarget.value;

        if (!startDateValue || !endDateValue) {
          this.priceHolderTarget.textContent = "Veuillez remplir les deux dates";
          return;
        }

        const startDate = new Date(startDateValue);
        const endDate = new Date(endDateValue);

        if (isNaN(startDate.getTime())) {
          this.priceHolderTarget.textContent = "Date de début invalide";
          return;
        }

        if (isNaN(endDate.getTime())) {
          this.priceHolderTarget.textContent = "Date de fin invalide";
          return;
        }

        if (endDate > startDate) {
          const pricePerDay = parseFloat(this.data.get("price"));

          if (isNaN(pricePerDay)) {
            console.error("Prix par jour invalide :", pricePerDay);
            this.priceHolderTarget.textContent = "Prix invalide";
            return;
          }

          const days = (endDate - startDate) / (1000 * 3600 * 24);

          if (days > 0) {
            const totalPrice = days * pricePerDay;
            this.priceHolderTarget.textContent = `${totalPrice.toFixed(2)} €`;
            if (this.hasTotalPriceInputTarget) {
              this.totalPriceInputTarget.value = totalPrice.toFixed(2);
            }
          } else {
            this.priceHolderTarget.textContent = "La durée doit être d'au moins 1 jour";
          }
        } else {
          this.priceHolderTarget.textContent = "La date de fin doit être après la date de début";
        }
      } catch (error) {
        console.error("Erreur lors du calcul du prix :", error);
        this.priceHolderTarget.textContent = "Une erreur est survenue";
      }
    }, 200);
  }
}
