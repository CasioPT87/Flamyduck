import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["button"];

  connect() {
    console.log('eoo')
  }

  initialize() {
    this.opened = false;
  }

  toggle = () => {
    this.opened = !this.opened;
    this.animate();
  }

  animate = () => {
    this.buttonTargets.forEach((target, i) => {
      if (this.opened) {
        target.style.marginLeft = ((i * 40) + 5) + 'px';
      } else {
        target.style.marginLeft = '5px';
      }
    });
    this.changeArrow();
  }

  lastButtonTarget = () => {
    return this.buttonTargets[this.buttonTargets.length - 1];
  }

  changeArrow = () => {
    const target = this.lastButtonTarget();
    if (this.opened) {
      target.classList.add('left-arrow');
      target.classList.remove('right-arrow');
    } else {
      target.classList.add('right-arrow');
      target.classList.remove('left-arrow');
    }
  }
}
