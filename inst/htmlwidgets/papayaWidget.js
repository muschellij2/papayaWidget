HTMLWidgets.widget({

  name: 'papayaWidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {
        console.log("x index is ");
        console.log(x.index);
        console.log("x id are ");
        console.log(x.id);
        console.log("x images are ");
        console.log(x.images);
        var img = x.images;
        console.log("img");
        console.log(img.constructor.name);
        // console.log(img[0]);
        // window.img = img;
        var params = [];
        var mystring = [];
        for (var i = 0; i < img.length; ++i) {
          window["img"+i] = img[i];
          mystring[i] = "img"+i;
        }
        params.encodedImages = mystring ;
        console.log(window);
        // img = img[0];
        // console.log(img.constructor.name);
        //params.encodedImages = ["img0"];
        console.log(params);
        //papaya.Container.addViewer
        //papaya.Container.addViewer = function (parentName, params, callback) {
        //papaya.Container.addViewer
        //papaya.Container.buildContainer()
        papaya.Container.addViewer(id = x.id, params = params)
        // papaya.Container.resetViewer(x.index, params);

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
