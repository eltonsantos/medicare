import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.loadTheme()
  }

  toggle() {
    const currentTheme = document.documentElement.classList.toggle('dark')
    localStorage.setItem('theme', currentTheme ? 'dark' : 'light')
  }

  loadTheme() {
    const savedTheme = localStorage.getItem('theme')
    if (savedTheme === 'dark') {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }
}
