// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled. 

//= require jquery
//= require jquery_ujs
//= require popper
//= require turbolinks
//= require bootstrap
//= require_tree.

// Import dependencies
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Import jQuery and set it globally
// import 'bootstrap/dist/js/bootstrap.bundle.min';
import $ from 'jquery';
window.jQuery = $;
window.$ = $;

// // Import Bootstrap JavaScript components
import 'bootstrap';
// // import '@popperjs/core';
// import "bootstrap/scss/bootstrap";
// import 'bootstrap/js/dist/modal';

require("trix")
require("@rails/actiontext")
// Start Rails, Turbolinks, and ActiveStorage
Rails.start()
Turbolinks.start()
ActiveStorage.start()
