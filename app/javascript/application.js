// app/javascript/application.js
import "@hotwired/stimulus/dist/stimulus.umd.js";
import "sweetalert2/dist/sweetalert2.min.js";
import "bootstrap/dist/js/bootstrap.bundle.min.js";
import "./sweet_alert";

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))
import "trix"
import "@rails/actiontext"
