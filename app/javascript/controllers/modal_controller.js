import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  static targets = ["modal", "dialog"];

  connect() {
    this.show();
    this.handleEscape = this.handleEscape.bind(this);
    document.addEventListener("turbo:visit", this.hide.bind(this));
    document.addEventListener("keydown", this.handleEscape);
  }

  disconnect() {
    document.removeEventListener("turbo:visit", this.hide.bind(this));
    document.removeEventListener("keydown", this.handleEscape);
    this.hide();
  }

  show() {
    requestAnimationFrame(() => {
      this.modalTarget.classList.remove("opacity-0", "pointer-events-none");
      this.modalTarget.classList.add("opacity-100", "pointer-events-auto");
    });
  }

  hide() {
    this.modalTarget.classList.remove("opacity-100", "pointer-events-auto");
    this.modalTarget.classList.add("opacity-0", "pointer-events-none");
  }

  close() {
    this.hide();
    
    // Redirecionar para a lista adequada com base na URL atual
    const url = window.location.href;
    
    if (url.includes('/medicines/') && (url.includes('/edit') || url.includes('/new'))) {
      Turbo.visit('/medicines');
    } else if (url.includes('/symptoms/') && (url.includes('/edit') || url.includes('/new'))) {
      Turbo.visit('/symptoms');
    } else if (url.includes('/members/') && (url.includes('/edit') || url.includes('/new'))) {
      Turbo.visit('/members');
    }
  }

  closeWithBackdrop(event) {
    if (event.target === this.modalTarget) {
      this.close();
    }
  }

  stopPropagation(event) {
    event.stopPropagation();
  }

  handleEscape(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }
}
