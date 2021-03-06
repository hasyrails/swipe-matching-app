//= require_tree .
//= require_jquery .

import 'bootstrap';
import '../stylesheets/application';
import '@fortawesome/fontawesome-free/js/all';

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
require('bootstrap/dist/js/bootstrap.min.js')

require("src/profile_image_upload");
require("src/user_swipe")
require("../../assets/javascripts/video")
require("../../assets/javascripts/myvideo")
