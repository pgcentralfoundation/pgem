import { Controller } from "@hotwired/stimulus"
import Sortable from "libraries/sortablejs"

// Scoped copy of Spina core's sortable_controller.js, used only by the team_members admin
// index. forceFallback: true fixes native drag-image shrinking for these wider rows, without
// touching the shared "sortable" controller navigations/pages already rely on.
export default class extends Controller {
  static get targets() {
    return [ "form", "list" ]
  }

  connect() {
    this.sortable = Sortable.create(this.listTarget, {
      handle: '[data-sortable-handle]',
      onEnd: this.saveSort.bind(this),
      animation: 150,
      forceFallback: true
    })
  }

  saveSort(event) {
    if (this.hasFormTarget) {
      this.prepareForm()
      this.formTarget.requestSubmit()
    }
  }

  prepareForm() {
    // Empty form
    this.formTarget.innerHTML = ''

    // Add hidden fields to store ids
    this.orderedIds.forEach(function(id) {
      this.formTarget.insertAdjacentHTML("beforeend", `<input type="hidden" name="ids[]" value="${id}" />`)
    }.bind(this))
  }

  get orderedIds() {
    return this.sortable.toArray()
  }

}
