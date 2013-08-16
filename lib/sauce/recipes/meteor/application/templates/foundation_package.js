Package.describe({
  summary: 'Meteor package for Zurb Foundation JavaScripts'
});

Package.on_use(function (api) {
  api.use('jquery', 'client');

  api.add_files([
    'foundation_init.js',
    'custom.modernizr.js',
    'foundation.js',
    'foundation.abide.js',
    'foundation.alerts.js',
    'foundation.clearing.js',
    'foundation.cookie.js',
    'foundation.dropdown.js',
    'foundation.forms.js',
    'foundation.interchange.js',
    'foundation.joyride.js',
    'foundation.magellan.js',
    'foundation.orbit.js',
    'foundation.placeholder.js',
    'foundation.reveal.js',
    'foundation.section.js',
    'foundation.tooltips.js',
    'foundation.topbar.js'
  ], 'client');
});
