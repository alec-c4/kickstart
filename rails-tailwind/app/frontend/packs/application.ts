import "../stylesheets/application.scss";
import "../javascripts/timezone";
import "../javascripts/current_year";

require("@rails/ujs").start();
require("@rails/activestorage").start();
require("channels");

require.context('../images', true);