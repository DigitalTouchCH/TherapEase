import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "icon"]

  connect() {
    console.log("Toggle controller connected!")
  }

  toggle() {
    console.log("Toggle method called!")
    if (this.contentTarget.classList.contains("hide-content")) {
      this.contentTarget.classList.remove("hide-content");
      this.iconTarget.classList.remove("fa-eye");
      this.iconTarget.classList.add("fa-eye-slash");
    } else {
      this.contentTarget.classList.add("hide-content");
      this.iconTarget.classList.remove("fa-eye-slash");
      this.iconTarget.classList.add("fa-eye");
    }
  }
}
