import Swal from 'sweetalert2'


document.addEventListener('DOMContentLoaded', function() {
  const deleteLinks = document.querySelectorAll('a[data-confirm][data-sweet-alert]');

  deleteLinks.forEach(function(link) {
    link.addEventListener('click', function(event) {
      event.preventDefault();

      Swal.fire({
        title: 'Você tem certeza?',
        text: "Você não será capaz de reverter isso!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sim, delete isso!'
      }).then((result) => {
        if (result.isConfirmed) {
          link.removeAttribute('data-confirm');
          link.click();
        }
      });
    });
  });
});