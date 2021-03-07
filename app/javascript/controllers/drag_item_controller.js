import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['scenario'];

  initialize() {
    console.log('initialize')
    console.log(this.scenarioTargets)
  }

  connect() {
    console.log('connect')
    console.log(this.scenarioTargets)
  }

  dragstart = (event) => {
    event.dataTransfer.setData("application/drag-key", event.target.getAttribute("data-sort-id"));
    event.dataTransfer.effectAllowed = "move";
  }

  dragover(event) {
    event.preventDefault();
    const dragElement = event.target;
    this.dropElement = dragElement.closest(".droppable");
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
    const leftElement = event.target.closest(".droppable");
    this.removeOnHoverStyles(leftElement);
  }

  drop(event) {
    var data = event.dataTransfer.getData("application/drag-key");
    const dropTarget = this.dropElement;
    const draggedItem = this.element.querySelector(`[data-sort-id='${data}']`);
    const positionComparison = dropTarget.compareDocumentPosition(draggedItem);
    if ( positionComparison & 4) {
      dropTarget.insertAdjacentElement('beforebegin', draggedItem);
    } else if ( positionComparison & 2) {
      dropTarget.insertAdjacentElement('afterend', draggedItem);
    }
    this.removeOnHoverStyles(dropTarget);
    event.preventDefault();
  }

  dragend(event) {
    console.log('pal servidor que vas')
  }

  addOnHoverStyles = (element) => {
    element.style.backgroundColor = 'black';
  }

  removeOnHoverStyles = (element) => {
    element.style.backgroundColor = 'transparent';
  }
}
