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

        console.log("ignore sync is ");
        console.log(ignore_sync);

        // console.log(img[0]);
        // window.img = img;
        var params = [];
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
          params["kioskMode"] = hide_toolbar;
          params["showControls"] = show_controls;
          params["orthogonal"] = orthogonal;

          if (opts && opts.length > 0) {
            for (var i = 0; i < opts.length; ++i) {
              var ix = opts[i];
              iname = image_names[i];
              if (typeof ix !== 'undefined' && ix !== null) {
                params[iname] = ix;
              }
            }
          }
        }
        console.log(window);
        // img = img[0];
        // console.log(img.constructor.name);
        //params.encodedImages = ["img0"];
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
