HTMLWidgets.widget({

  name: 'papayaWidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        $('<script>var params'+el.id+' = [];params'+el.id+'["images"] = ["'+x.files.toString().split(",").join("\", \"")+'"];</' + 'script>').appendTo(document.body);
       document.getElementById(el.id).innerHTML += '<div class="papaya" data-params="params'+el.id+'"></div><div>&nbsp;</div>';
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
