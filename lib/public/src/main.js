const confirmBeer = document.querySelector(".beer-confirm")
// wrap form for delete as well which is hidden so one can be used for both
confirmBeer.addEventListener('click', (event) => {
    event.preventDefault();

    const choice = confirm(confirmBeer.dataset.confirm);

    if (choice) {
      document.querySelector("form").submit();
    }
});
