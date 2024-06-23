import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "logo", "fullLogo"]

  initialize() {
    this.isSidebarOpen = true;
  }

  toggle() {
    if (this.isSidebarOpen) {
      this.sidebarTarget.classList.add("-translate-x-full");
      this.isSidebarOpen = false;
    } else {
      this.sidebarTarget.classList.remove("-translate-x-full");
      this.isSidebarOpen = true;
    }
  }

  get isSidebarOpen() {
    return this._isSidebarOpen;
  }

  set isSidebarOpen(value) {
    this._isSidebarOpen = value;
  }

  checkSize() {
    if (window.innerWidth < 768) {
      this.sidebarTarget.classList.add("hidden");
    } else {
      this.sidebarTarget.classList.remove("hidden");
    }
  }
}
