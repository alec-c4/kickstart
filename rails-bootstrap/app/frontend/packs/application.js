import "../stylesheets/application.scss";
import "./timezone";

import Rails from "@rails/ujs";
import * as ActiveStorage from "@rails/activestorage";
import LocalTime from "local-time";
import "../channels";

import "bootstrap";
import "@fortawesome/fontawesome-free/css/all.css";

import "../controllers"

Rails.start();
ActiveStorage.start();
LocalTime.start();

// require.context('../images', true);
