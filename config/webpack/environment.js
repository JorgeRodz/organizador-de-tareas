const { environment } = require("@rails/webpacker");

// *To make jQuery available in all views - need for cocoon gem
const webpack = require("webpack");

environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    "window.jQuery": "jquery",
    Popper: ["popper.js", "default"],
  })
);
// *To make jQuery available in all views - need for cocoon gem

module.exports = environment;
