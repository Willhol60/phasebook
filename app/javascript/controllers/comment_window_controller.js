import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["content"]

  revealWindow() {
    this.contentTarget.classList.toggle('d-none');
  }

  submit(event) {
    if (event.key == 'Enter') {
      event.target.parentElement.parentElement.submit()
    }
    // console.log(event.key)
  }

}
