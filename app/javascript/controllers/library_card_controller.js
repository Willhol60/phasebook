import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["cover", "info"]

  changeCard() {
    this.coverTarget.classList.add('d-none');
    this.infoTarget.classList.remove('d-none');
  }

  changeCardBack() {
    this.coverTarget.classList.remove('d-none');
    this.infoTarget.classList.add('d-none');
  }

}
