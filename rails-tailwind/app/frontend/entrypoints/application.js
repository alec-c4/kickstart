import "../stylesheets/application.scss";
import "../javascripts/timezone";
import "../channels/index.js";
import "../controllers/index.js";

import "@fortawesome/fontawesome-free/css/all.css";

import * as ActiveStorage from "@rails/activestorage";
import LocalTime from "local-time";
import Rails from "@rails/ujs";

Rails.start()
ActiveStorage.start();
LocalTime.start();

console.log('Vite ⚡️ Rails');