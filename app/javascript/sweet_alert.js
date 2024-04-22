import { Controller } from "stimulus"
import Swal from 'sweetalert2'

export default class extends Controller {
  confirmDelete(event) {
    event.preventDefault()

    Swal.fire({
      title: 'Você tem certeza?',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Sim, delete!',
      cancelButtonText: 'Não, cancelar!'
    }).then((result) => {
      if (result.isConfirmed) {
        // Enviar a solicitação de delete
        this.element.submit();
      }
    })
  }
}