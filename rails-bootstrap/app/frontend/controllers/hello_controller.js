import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
    this.element.textContent = "Hello World from Stimulus!"
  }
}
