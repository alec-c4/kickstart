import "../stylesheets/application.scss";
import "./timezone";

import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import LocalTime from "local-time";
import "../channels";

import "@fortawesome/fontawesome-free/css/all";

Rails.start();
ActiveStorage.start();
LocalTime.start();

import "../controllers"

// require.context('../images', true);