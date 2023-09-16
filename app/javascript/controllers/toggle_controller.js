import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["content", "icon"]

  connect() {
    console.log("Toggle controller connected!")
  }

  toggle() {
    console.log("Toggle method called!")
    if (this.contentTarget.style.display === "none" || !this.contentTarget.style.display) {
      this.contentTarget.style.display = "block";
      this.iconTarget.classList.remove("fa-eye-slash");
      this.iconTarget.classList.add("fa-eye");
    } else {
      this.contentTarget.style.display = "none";
      this.iconTarget.classList.remove("fa-eye");
      this.iconTarget.classList.add("fa-eye-slash");
    }
  }
}
