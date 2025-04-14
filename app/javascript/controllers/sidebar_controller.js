import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "menuText", "logo", "sidebarToggle"]

  initialize() {
    this.isSidebarOpen = true;
    this.isCompactMode = false;
    
    // Verificar o tamanho da tela ao inicializar
    this.checkScreenSize();
    
    // Adicionar listener para alterações no tamanho da tela
    window.addEventListener('resize', this.checkScreenSize.bind(this));
  }

  disconnect() {
    window.removeEventListener('resize', this.checkScreenSize.bind(this));
  }

  // Alternar entre modo compacto e normal, ou mostrar/esconder a sidebar dependendo do tamanho da tela
  toggle(event) {
    if (event) {
      event.preventDefault();
    }
    
    const width = window.innerWidth;
    
    // Em tablets (768-1024px) e desktop (>1024px), alternar o modo compacto
    if (width >= 768) {
      this.toggleCompactMode();
    } 
    // Em mobile (<768px), apenas mostrar/esconder a sidebar
    else {
      this.toggleVisibility();
    }
  }
  
  // Alternar a visibilidade da sidebar (mostrar/esconder)
  toggleVisibility() {
    if (this.sidebarTarget.classList.contains('-translate-x-full')) {
      this.sidebarTarget.classList.remove('-translate-x-full');
    } else {
      this.sidebarTarget.classList.add('-translate-x-full');
    }
  }

  // Alternar entre modo compacto e normal
  toggleCompactMode() {
    // Quando a sidebar está expandida
    if (this.sidebarTarget.classList.contains('w-50')) {
      // Muda para modo compacto
      this.sidebarTarget.classList.remove('w-50');
      this.sidebarTarget.classList.add('w-16');
      
      // Oculta os textos do menu
      this.menuTextTargets.forEach(el => {
        el.classList.add('hidden');
      });
      
      // Centraliza o logo
      if (this.hasLogoTarget) {
        this.logoTarget.classList.add('mx-auto');
      }
      
      // Rotaciona o ícone do toggle
      if (this.hasSidebarToggleTarget) {
        this.sidebarToggleTarget.classList.add('rotate-180');
      }
      
      this.isCompactMode = true;
    } else {
      // Muda para modo expandido
      this.sidebarTarget.classList.remove('w-16');
      this.sidebarTarget.classList.add('w-50');
      
      // Mostra os textos do menu
      this.menuTextTargets.forEach(el => {
        el.classList.remove('hidden');
      });
      
      // Remove centralização do logo
      if (this.hasLogoTarget) {
        this.logoTarget.classList.remove('mx-auto');
      }
      
      // Rotaciona o ícone do toggle
      if (this.hasSidebarToggleTarget) {
        this.sidebarToggleTarget.classList.remove('rotate-180');
      }
      
      this.isCompactMode = false;
    }
  }
  
  checkScreenSize() {
    const width = window.innerWidth;
    
    // Para mobile, a sidebar fica escondida inicialmente
    if (width < 768) {
      this.sidebarTarget.classList.add('-translate-x-full');
    } 
    // Para tablets e desktop, a sidebar fica visível inicialmente
    else {
      this.sidebarTarget.classList.remove('-translate-x-full');
    }
  }
}
