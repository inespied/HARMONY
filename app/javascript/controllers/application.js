/ app/javascript/application.js

import "flatpickr";
import "flatpickr/dist/flatpickr.min.css"; // Importation correcte du CSS

import { Application } from "stimulus";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

const application = Application.start();
eagerLoadControllersFrom("controllers", application);

import FlatpickrController from "./controllers/flatpickr_controller";
application.register("flatpickr", FlatpickrController);
