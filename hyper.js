module.exports = {
  config: {
    fontSize: 14.5,
    fontFamily: '"Input Mono", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace'
  },


  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'hypercwd',
    'hyperlinks',
    'hyperterm-snazzy',
    'hyperterm-tab-numbers'
  ],

  // in development, you can create a directory under
  // `~/.hyperterm_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
};
