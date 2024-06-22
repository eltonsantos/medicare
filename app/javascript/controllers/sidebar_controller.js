// app/javascript/controllers/sidebar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "logo", "fullLogo"]

  initialize() {
    this.isSidebarOpen = true; // Estado inicial da sidebar (aberta)
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
    return this.isSidebarOpen;
  }

  checkSize() {
    // Adapta o comportamento baseado no tamanho da tela
    if (window.innerWidth < 768) { // Ajuste conforme necessário
      this.sidebarTarget.classList.add("hidden");
    } else {
      this.sidebarTarget.classList.remove("hidden");
    }
  }
}
