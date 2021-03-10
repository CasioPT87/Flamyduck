import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['scenario', 'csrf'];

  connect() {
    this.getAuthenticityToken('csrf-token');
  }

  getOrder = () => {
    return this.order = this.scenarioTargets.map(element => {
      return element.dataset.scenarioId;
    });
  }

  dragstart = (event) => {
    event.dataTransfer.setData("application/drag-key", event.target.getAttribute("data-scenario-id"));
    event.dataTransfer.effectAllowed = "move";
  }

  dragover(event) {
    event.preventDefault();
    const dragElement = event.target;
    this.dropElement = dragElement.closest(".o-container-scenario-droppable");
    if (this.dropElement) {
      this.addOnHoverStyles(this.dropElement);
      return true;
    } else {
      return false;
    }
  }

  dragenter(event) {
    event.preventDefault();
  }

  dragleave(event) {
    event.preventDefault();
    const leftElement = event.target.closest(".o-container-scenario-droppable");
    this.removeOnHoverStyles(leftElement);
  }

  drop(event) {
    var data = event.dataTransfer.getData("application/drag-key");
    const dropTarget = this.dropElement;
    this.draggedItem = this.element.querySelector(`[data-scenario-id='${data}']`);
    const positionComparison = dropTarget.compareDocumentPosition(this.draggedItem);
    if ( positionComparison & 4) {
      dropTarget.insertAdjacentElement('beforebegin', this.draggedItem);
    } else if ( positionComparison & 2) {
      dropTarget.insertAdjacentElement('afterend', this.draggedItem);
    }
    this.removeOnHoverStyles(dropTarget);
    event.preventDefault();
  }

  dragend(event) {
    event.preventDefault();
    if (!this.draggedItem) return;
    const draggedScenarioId = this.draggedItem.dataset.scenarioId;
    const order = this.getOrder();
    const formData = new FormData();
    formData.append('order', order);

    fetch(`/sorts/${draggedScenarioId}?&authenticity_token=${this.authenticityToken}`, {
      method: 'PATCH', 
      credentials: 'same-origin',
      headers: {
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: formData
    })
  }

  getAuthenticityToken = (name) => {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    this.authenticityToken = element.getAttribute("content")
  }
  
  addOnHoverStyles = (element) => {
    element.style.backgroundColor = 'black';
  }

  removeOnHoverStyles = (element) => {
    element.style.backgroundColor = 'transparent';
  }
}
