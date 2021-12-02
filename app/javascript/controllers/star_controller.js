import { Controller } from "stimulus"
import { initStarRating } from '../plugins/init_star_rating';

export default class extends Controller {
  connect() {
    initStarRating();
  }
}
