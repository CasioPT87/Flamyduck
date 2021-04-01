import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["button"];

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
        target.style.marginLeft = (i * 40) + 'px';
      } else {
        target.style.marginLeft = '0px';
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
      target.classList.add('c-link__list--left-arrow');
      target.classList.remove('c-link__list--right-arrow');
    } else {
      target.classList.add('c-link__list--right-arrow');
      target.classList.remove('c-link__list--left-arrow');
    }
  }
}
