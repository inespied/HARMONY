import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["startDateInput", "endDateInput", "priceHolder", "totalPriceInput"];

  connect() {
    console.log("flatpickr Controller connected");

    const pricePerDay = this.element.dataset.flatpickrPrice;
    console.log("Prix par jour récupéré:", pricePerDay);

    flatpickr(this.startDateInputTarget, {
      dateFormat: "Y-m-d",
      onChange: this.updatePrice.bind(this),
    });

    flatpickr(this.endDateInputTarget, {
      dateFormat: "Y-m-d",
      onChange: this.updatePrice.bind(this),
    });
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

        console.log("Start Date:", startDate);
        console.log("End Date:", endDate);

        if (isNaN(startDate.getTime())) {
          this.priceHolderTarget.textContent = "Date de début invalide";
          return;
        }

        if (isNaN(endDate.getTime())) {
          this.priceHolderTarget.textContent = "Date de fin invalide";
          return;
        }

        if (endDate > startDate) {
          const pricePerDay = parseFloat(this.element.dataset.flatpickrPrice);

          console.log("Price per day:", pricePerDay);

          if (isNaN(pricePerDay)) {
            console.error("Prix par jour invalide :", pricePerDay);
            this.priceHolderTarget.textContent = "Prix invalide";
            return;
          }

          const days = (endDate - startDate) / (1000 * 3600 * 24);

          console.log("Days:", days);

          if (days > 0) {
            const totalPrice = days * pricePerDay;

            console.log("Total Price:", totalPrice);

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
