HTMLWidgets.widget({

  name: 'papayaWidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

      switch(x.passingMethod.toString()) {
        case "file":
            $('<script>var params'+el.id+' = [];params'+el.id+'["images"] = ["'+x.names.toString().split(",").join("\", \"")+'"];</' + 'script>').appendTo(document.body);
            break;
        case "embed":
            eval(x.params)
            $('<script>var paramsimg2 = [];paramsimg2["encodedImages"] = ['+x.enc_img_str+'];</script>').appendTo(document.body);
            break;
        default:
      }
       document.getElementById(el.id).innerHTML += '<div class="papaya" data-params="params'+el.id+'"></div>';

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
