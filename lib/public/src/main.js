const confirmBeer = document.querySelector(".beer-confirm")

confirmBeer.addEventListener('click', (event) => {
    event.preventDefault();

    const choice = confirm(confirmBeer.dataset.confirm);

    if (choice) {
      window.location.href = confirmBeer.getAttribute('href');
    }
});
