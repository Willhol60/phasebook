import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["content"]

  revealWindow() {
    this.contentTarget.classList.toggle('d-none');
  }

}
