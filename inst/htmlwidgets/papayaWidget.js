HTMLWidgets.widget({

  name: 'papayaWidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    console.log("el is");
    console.log(el);
    console.log("el.id is");
    console.log(el.id);
    var id = el.id;


    return {

      renderValue: function(x) {
        console.log("x is");
        console.log(x);


        console.log("x id are ");
        console.log(x.id);
        console.log("x images are ");
        console.log(x.images);
        console.log("x options are ");
        var opts = x.options;
        console.log(opts);
        var img = x.images;
        var image_names = x.image_names;
        console.log("image_names are ");
        console.log(image_names);

        var ignore_sync = x.ignore_sync;
        ignore_sync = Boolean(ignore_sync);

        var hide_toolbar = x.hide_toolbar;
        hide_toolbar = Boolean(hide_toolbar);

        var show_controls = x.show_controls;
        show_controls = Boolean(show_controls);

        var orthogonal = x.orthogonal;
        orthogonal = Boolean(orthogonal);

        console.log("orthogonal is ");
        console.log(orthogonal);

        console.log("x.interpolation is ");
        console.log(x.interpolation);
        var interp = x.interpolation;
        interp = Boolean(interp);
        console.log("interp is ");
        console.log(interp);

        function truefalse(x) {
          if (x === "false") {
            console.log("changing to boolean");
            x = false;
          }
          if (x === "true") {
            console.log("changing to boolean");
            x = true;
          }
          return x ;
        }

        console.log("ignore sync is ");
        console.log(ignore_sync);

        // console.log(img[0]);
        // window.img = img;
        var params = [];
        params["kioskMode"] = hide_toolbar;
        params["showControls"] = show_controls;
        params["orthogonal"] = orthogonal;
        params["interpolation"] = interp;
        params["smoothDisplay"] = interp;


        var mystring = [];
        if (img && img.length > 0) {
          console.log("img");
          console.log(img.constructor.name);
          for (var i = 0; i < img.length; ++i) {
            iname = image_names[i];
            window[iname] = img[i];
            mystring[i] = iname;
          }
          params.encodedImages = mystring ;

          if (opts && opts.length > 0) {
            for (var i = 0; i < opts.length; ++i) {
              var ix = opts[i];
              iname = image_names[i];
              console.log("iname is");
              console.log(iname);
              console.log("ix");
              console.log(ix);
              if (typeof ix !== 'undefined' && ix !== null) {
                console.log("ix.length");
                console.log(ix.length);
                console.log("typeofix");
                console.log(typeof(ix));
                // for (opt in ix) {
                //   var opt = ix[j];
                //   console.log("opt is");
                //   console.log(opt);
                //   opt = truefalse(opt) ;
                //   console.log("opt is");
                //   console.log(opt);
                //   ix[j] = opt;
                // }
                params[iname] = ix;
              }
            }
          }
        }
        console.log(window);
        // img = img[0];
        // console.log(img.constructor.name);
        //params.encodedImages = ["img0"];
        console.log("params");
        console.log(params);
        //papaya.Container.addViewer
        //papaya.Container.addViewer = function (parentName, params, callback) {
        //papaya.Container.addViewer
        //papaya.Container.buildContainer()
        if (typeof id === 'undefined' || id === null) {
          id = x.id;
        }
        papaya.Container.addViewer(id, params = params);
        papaya.Container.syncViewers = true;
        var container_number = papayaContainers.length - 1;
        papayaContainers[container_number].viewer.ignoreSync = ignore_sync;
        //papaya.Container.addViewer(x.id, params = params)
        // papaya.Container.resetViewer(x.index, params);

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
