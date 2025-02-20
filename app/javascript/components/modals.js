document.addEventListener("turbo:load", function() {
    const newSongModal = document.getElementById("newSongModal");
    if (!newSongModal) return;
    newSongModal.addEventListener("hidden.bs.modal", function() {
      const form = document.getElementById("new_portfolio_song_form");
      if (form) {
        form.reset();
      }
    });
  });
  