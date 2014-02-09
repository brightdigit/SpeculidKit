requirejs.config({
  shim: {
    underscore: {
      exports: '_'
    }
  },
  paths: {
    bootstrap: '../../../bower_components/bootstrap/dist/js/bootstrap',
    jquery: '../../../bower_components/jquery/jquery',
    requirejs: '../../../bower_components/requirejs/require',
    async: '../../../bower_components/requirejs-plugins/src/async',
    font: '../../../bower_components/requirejs-plugins/src/font',
    goog: '../../../bower_components/requirejs-plugins/src/goog',
    image: '../../../bower_components/requirejs-plugins/src/image',
    json: '../../../bower_components/requirejs-plugins/src/json',
    noext: '../../../bower_components/requirejs-plugins/src/noext',
    mdown: '../../../bower_components/requirejs-plugins/src/mdown',
    propertyParser: '../../../bower_components/requirejs-plugins/src/propertyParser',
    markdownConverter: '../../../bower_components/requirejs-plugins/lib/Markdown.Converter',
    depend: '../../../bower_components/requirejs-plugins/src/depend',
    'Markdown.Converter': '../../../bower_components/requirejs-plugins/lib/Markdown.Converter',
    text: '../../../bower_components/requirejs-plugins/lib/text',
    backbone: '../../../bower_components/backbone-amd/backbone',
    underscore: '../../../bower_components/underscore/underscore'
  }
});
