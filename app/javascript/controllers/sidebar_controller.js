import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "menuText", "logo", "sidebarToggle"]

  initialize() {
    this.isSidebarOpen = false;
    this.isCompactMode = false;
    
    // Verificar o tamanho da tela ao inicializar
    this.checkScreenSize();
    
    // Adicionar listener para alterações no tamanho da tela
    window.addEventListener('resize', this.checkScreenSize.bind(this));
    
    // Registrar no log para depuração
    console.log("Sidebar controller initialized");
  }

  connect() {
    console.log("Sidebar controller connected");
  }

  disconnect() {
    window.removeEventListener('resize', this.checkScreenSize.bind(this));
  }

  toggle(event) {
    // Log para depuração do botão do menu mobile
    console.log("Toggle clicked", window.innerWidth);
    
    // Interrompe a propagação e comportamento padrão
    event.preventDefault();
    event.stopPropagation();
    
    // Em dispositivos móveis, apenas abre e fecha a sidebar
    if (window.innerWidth < 1024) {
      console.log("Mobile toggle", this.isSidebarOpen);
      
      if (this.isSidebarOpen) {
        this.closeSidebar();
      } else {
        this.openSidebar();
      }
    } else {
      // Em dispositivos maiores, alterna o modo compacto
      this.toggleCompactMode();
    }
  }
  
  // Método específico para abrir a sidebar no mobile
  openSidebar() {
    console.log("Opening sidebar");
    this.sidebarTarget.classList.remove('-translate-x-full');
    this.isSidebarOpen = true;
  }
  
  // Método específico para fechar a sidebar no mobile
  closeSidebar() {
    console.log("Closing sidebar");
    this.sidebarTarget.classList.add('-translate-x-full');
    this.isSidebarOpen = false;
  }

  toggleCompactMode() {
    // Quando a sidebar está expandida
    if (this.sidebarTarget.classList.contains('w-50')) {
      // Muda para modo compacto
      this.sidebarTarget.classList.remove('w-50');
      this.sidebarTarget.classList.add('w-16');
      
      // Oculta os textos do menu, mas deixa os ícones visíveis
      this.menuTextTargets.forEach(el => {
        el.classList.add('hidden');
      });
      
      // Centraliza o logo
      if (this.hasLogoTarget) {
        this.logoTarget.classList.add('mx-auto');
      }
      
      // Rotaciona o ícone do toggle para indicar expansão
      if (this.hasSidebarToggleTarget) {
        this.sidebarToggleTarget.classList.remove('rotate-0');
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
      
      // Rotaciona o ícone do toggle para indicar compactação
      if (this.hasSidebarToggleTarget) {
        this.sidebarToggleTarget.classList.remove('rotate-180');
        this.sidebarToggleTarget.classList.add('rotate-0');
      }
      
      this.isCompactMode = false;
    }
  }
  
  checkScreenSize() {
    if (window.innerWidth < 1024) {
      // Para dispositivos móveis, esconde a sidebar inicialmente
      this.sidebarTarget.classList.add('-translate-x-full');
      this.isSidebarOpen = false;
    } else {
      // Para desktop, mantém a sidebar visível
      this.sidebarTarget.classList.remove('-translate-x-full');
      this.isSidebarOpen = true;
    }
  }
}
