const confirmBeer = document.querySelector(".beer-confirm")
confirmBeer.addEventListener('click', (event) => {
    event.preventDefault();

    const choice = confirm(confirmBeer.dataset.confirm);

    if (choice) {
      document.querySelector("form").submit();
    }
});
