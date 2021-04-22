import "../stylesheets/application.scss";
import "../javascripts/timezone";
import "../javascripts/current_year";
import "../channels/index.js";
import "../controllers/index.js";

import "vite/dynamic-import-polyfill";
import "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import LocalTime from "local-time";

console.log('Vite ⚡️ Rails');

ActiveStorage.start();
LocalTime.start();