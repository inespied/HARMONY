import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  resetForm() {
    const form = this.element.querySelector("form")
    if (form) {
      form.reset()
    }
  }
}
