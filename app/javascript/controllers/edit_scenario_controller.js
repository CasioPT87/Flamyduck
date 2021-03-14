import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["showingScenarioWrapper", "editingScenarioWrapper"];

  initialize() {
    this.editing = false;
  }

  toggle = () => {
    this.editing = !this.editing;
    this.change();
  }

  cancelEditing = (e) => {
    e.preventDefault();
    this.editing = false;
    this.change();
  }

  change = () => {
    const parent = this.showingScenarioWrapperTarget.parentElement;
    if (this.editing) {
      parent.setAttribute('draggable', false);
      this.showingScenarioWrapperTarget.style.display = 'none';
      this.editingScenarioWrapperTarget.style.display = 'flex';
    } else {
      parent.setAttribute('draggable', true);
      this.showingScenarioWrapperTarget.style.display = 'flex';
      this.editingScenarioWrapperTarget.style.display = 'none';
    }
  }
}
