document.addEventListener("turbo:load", () => {
  const searchToggle = document.querySelector(".search-toggle");
  const searchContainer = document.querySelector(".search-container");
  const searchInputContainer = document.querySelector(".search-input-container");
  const searchInput = document.querySelector(".search-input");
  const clearInput = document.querySelector(".clear-input");
  const plusButton = document.querySelector(".plus-btn");

  if (searchToggle && searchContainer && searchInputContainer && searchInput && clearInput) {
    // Au clic sur la loupe, affiche l'input et attend la fin de la transition pour focus
    searchToggle.addEventListener("click", (e) => {
      e.stopPropagation();
      searchContainer.classList.add("show-input");

      const onTransitionEnd = (event) => {
        if (event.propertyName === "opacity") {
          searchInput.focus();
          searchInputContainer.removeEventListener("transitionend", onTransitionEnd);
        }
      };
      searchInputContainer.addEventListener("transitionend", onTransitionEnd);
    });

    // Si on clique en dehors, cache l'input et réaffiche la loupe
    document.addEventListener("click", (evt) => {
      if (!searchContainer.contains(evt.target)) {
        searchContainer.classList.remove("show-input");
      }
    });

    // Si on appuie sur la touche Échap, cache l'input
    document.addEventListener("keyup", (evt) => {
      if (evt.key === "Escape") {
        searchContainer.classList.remove("show-input");
      }
    });

    // Affiche ou masque l'icône "x" en fonction du contenu de l'input
    searchInput.addEventListener("input", () => {
      if (searchInput.value.length > 0) {
        clearInput.style.display = "block";
      } else {
        clearInput.style.display = "none";
      }
    });

    // Au clic sur l'icône "x", efface le contenu et remet le focus sur l'input
    clearInput.addEventListener("click", (e) => {
      e.stopPropagation();
      searchInput.value = "";
      clearInput.style.display = "none";
      searchInput.focus();
    });
  }
});
