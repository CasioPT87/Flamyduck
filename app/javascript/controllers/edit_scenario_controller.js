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
    if (this.editing) {
      this.showingScenarioWrapperTarget.style.display = 'none';
      this.editingScenarioWrapperTarget.style.display = 'flex';
    } else {
      this.showingScenarioWrapperTarget.style.display = 'flex';
      this.editingScenarioWrapperTarget.style.display = 'none';
    }
  }
}
