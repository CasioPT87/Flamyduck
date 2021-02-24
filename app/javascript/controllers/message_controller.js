import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["cookie"];

  connect() {
    setTimeout(() => {
      this.cookieTarget.style.display = 'none';
    }, 4000);
  }
}
