import "../stylesheets/application.scss";
import "./timezone";

import "../channels";
import "../controllers"

import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import LocalTime from "local-time";

import "@fortawesome/fontawesome-free/css/all.css";

Rails.start();
ActiveStorage.start();
LocalTime.start();

// require.context('../images', true);
