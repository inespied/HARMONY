// Importation de l'application Stimulus et des utilitaires nécessaires
import { Application } from "stimulus"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Créer l'instance de l'application Stimulus
const application = Application.start()

// Charger tous les contrôleurs à partir du répertoire "controllers"
eagerLoadControllersFrom("controllers", application)

// Importer et enregistrer ton contrôleur Flatpickr
import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)
