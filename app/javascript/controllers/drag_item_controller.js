import { Controller } from "stimulus"

export default class extends Controller {

  // static targets = [];

  // connect() {
  // }

  dragstart = (event) => {
    event.dataTransfer.setData("application/drag-key", event.target.getAttribute("data-sort-id"))
    event.dataTransfer.effectAllowed = "move"
  }

  dragover(event) {
    const dragElement = event.target;
    this.dropElement = dragElement.closest(".droppable")
    if (this.dropElement) {
      event.preventDefault()
      return true
    } else {
      return false;
    }
  }

  dragenter(event) {
    event.preventDefault()
  }

  drop(event) {
    var data = event.dataTransfer.getData("application/drag-key")
    const dropTarget = this.dropElement
    const draggedItem = this.element.querySelector(`[data-sort-id='${data}']`);
    const positionComparison = dropTarget.compareDocumentPosition(draggedItem)
    if ( positionComparison & 4) {
      dropTarget.insertAdjacentElement('beforebegin', draggedItem);
    } else if ( positionComparison & 2) {
      dropTarget.insertAdjacentElement('afterend', draggedItem);
    }
    event.preventDefault()
  }

  dragend(event) {
    console.log('pal servidor que vas')
  }
}
