import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["showingScenarioWrapper", "editingScenarioWrapper", "hiddenDeleteScenario"];

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
    if (this.editing) {
      this.hiddenDeleteScenarioTarget.firstElementChild.value = false;
      this.showingScenarioWrapperTarget.style.display = 'none';
      this.editingScenarioWrapperTarget.style.display = 'block';
    } else {
      this.hiddenDeleteScenarioTarget.firstElementChild.value = true;
      this.showingScenarioWrapperTarget.style.display = 'block';
      this.editingScenarioWrapperTarget.style.display = 'none';
    }
  }
}
