import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["form"];

  initialize() {
    this.opened = false;
  }

  toggle = () => {
    this.opened = !this.opened;
    this.change();
  }

  change = () => {
    console.log(this.opened)
    if (this.opened) {
      console.log(this.formTarget)
      this.formTarget.style.display = 'flex';
      window.scrollTo(0,document.body.scrollHeight);
    }
    else this.formTarget.style.display = 'none';
  }
}
