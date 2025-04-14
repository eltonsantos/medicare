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

  connect() {
    this.checkSize()
    window.addEventListener('resize', this.checkSize.bind(this))
  }

  disconnect() {
    window.removeEventListener('resize', this.checkSize.bind(this))
  }

  toggle() {
    this.sidebarTarget.classList.toggle('-translate-x-full')
    this.toggleCompactMode()
  }

  toggleCompactMode() {
    // Quando a sidebar está expandida
    if (this.sidebarTarget.classList.contains('w-50')) {
      // Muda para modo compacto
      this.sidebarTarget.classList.remove('w-50')
      this.sidebarTarget.classList.add('w-16')
      
      // Oculta os textos do menu, mas deixa os ícones visíveis
      this.menuTextTargets.forEach(el => {
        el.classList.add('hidden')
      })
      
      // Centraliza o logo
      if (this.hasLogoTarget) {
        this.logoTarget.classList.add('mx-auto')
      }
      
      // Rotaciona o ícone do toggle para indicar expansão
      this.sidebarToggleTarget.classList.remove('transform', 'rotate-0')
      this.sidebarToggleTarget.classList.add('transform', 'rotate-180')
    } else {
      // Muda para modo expandido
      this.sidebarTarget.classList.remove('w-16')
      this.sidebarTarget.classList.add('w-50')
      
      // Mostra os textos do menu
      this.menuTextTargets.forEach(el => {
        el.classList.remove('hidden')
      })
      
      // Remove centralização do logo
      if (this.hasLogoTarget) {
        this.logoTarget.classList.remove('mx-auto')
      }
      
      // Rotaciona o ícone do toggle para indicar compactação
      this.sidebarToggleTarget.classList.remove('transform', 'rotate-180')
      this.sidebarToggleTarget.classList.add('transform', 'rotate-0')
    }
  }
  
  checkSize() {
    if (window.innerWidth < 1024) {
      // Modo móvel: sidebar fica escondida
      this.sidebarTarget.classList.add('-translate-x-full')
    } else {
      // Desktop: sidebar visível
      this.sidebarTarget.classList.remove('-translate-x-full')
    }
  }
  
  checkScreenSize() {
    if (window.innerWidth < 1024) {
      // Modo móvel: sidebar fica escondida
      this.sidebarTarget.classList.add('-translate-x-full')
    } else {
      // Desktop: sidebar visível
      this.sidebarTarget.classList.remove('-translate-x-full')
    }
  }
}
