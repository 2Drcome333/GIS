


<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="http://localhost:8080/geoserver/openlayers3/ol.css" type="text/css">
    <style>
        .ol-zoom {
          top: 52px;
        }
        .ol-toggle-options {
          z-index: 1000;
          background: rgba(255,255,255,0.4);
          border-radius: 4px;
          padding: 2px;
          position: absolute;
          left: 8px;
          top: 8px;
        }
        #updateFilterButton, #resetFilterButton {
          height: 22px;
          width: 22px;
          text-align: center;
          text-decoration: none !important;
          line-height: 22px;
          margin: 1px;
          font-family: 'Lucida Grande',Verdana,Geneva,Lucida,Arial,Helvetica,sans-serif;
          font-weight: bold !important;
          background: rgba(0,60,136,0.5);
          color: white !important;
          padding: 2px;
        }
        .ol-toggle-options a {
          background: rgba(0,60,136,0.5);
          color: white;
          display: block;
          font-family: 'Lucida Grande',Verdana,Geneva,Lucida,Arial,Helvetica,sans-serif;
          font-size: 19px;
          font-weight: bold;
          height: 22px;
          line-height: 11px;
          margin: 1px;
          padding: 0;
          text-align: center;
          text-decoration: none;
          width: 22px;
          border-radius: 2px;
        }
        .ol-toggle-options a:hover {
          color: #fff;
          text-decoration: none;
          background: rgba(0,60,136,0.7);
        }


	<!-- 设置popup的style-->  
	

	html, body,  #map {  
            border: 0px;  
            margin: 0px;  
            padding: 0px;  
            width: 100%;  
            height: 100%;  
            font-size: 13px;  
        }  


	.ol-popup {  
            position: absolute;  
            background-color: white;  
            -moz-box-shadow: 0 1px 4px rgba(0,0,0,0.2);  
            -webkit-filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));  
            filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));  
            border: 1px solid #cccccc;  
            bottom: 12px;  
            left: -50px;  
            width: 300px;  
	    height:100px;
        }  
        .ol-popup:after, .ol-popup:before {  
            top: 100%;  
            border: solid transparent;  
            content: " ";  
            height: 0;  
            width: 0;  
            position: absolute;  
            pointer-events: none;  
        }  
        .ol-popup:after {  
            border-top-color: white;  
            border-width: 10px;  
            left: 48px;  
            margin-left: -10px;  
        }  
        .ol-popup:before {  
            border-top-color: #cccccc;  
            border-width: 11px;  
            left: 48px;  
            margin-left: -11px;  
        }  
        .popup-title{  
            font-weight: bold;   
            padding: 5px 8px;  
        }  
        .popup-content{  
            padding: 5px 8px;  
        }
      .ol-popup-closer {
        text-decoration: none;
        position: absolute;
        top: 2px;
        right: 8px;
      }
      .ol-popup-closer:after {
        content: "✖";
      }  






        body {
            font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
            font-size: small;
        }
        iframe {
            width: 100%;
            height: 250px;
            border: none;
        }
        /* Toolbar styles */
        #toolbar {
            position: relative;
            padding-bottom: 0.5em;
        }
        #toolbar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        #toolbar ul li {
            float: left;
            padding-right: 1em;
            padding-bottom: 0.5em;
        }
        #toolbar ul li a {
            font-weight: bold;
            font-size: smaller;
            vertical-align: middle;
            color: black;
            text-decoration: none;
        }
        #toolbar ul li a:hover {
            text-decoration: underline;
        }
        #toolbar ul li * {
            vertical-align: middle;
        }
        #map {
            clear: both;
            position: relative;
            width: 768px;
            height: 384px;
            border: 1px solid black;
        }
        #wrapper {
            width: 768px;
        }
        #location {
            float: right;
        }
        /* Styles used by the default GetFeatureInfo output, added to make IE happy */
        table.featureInfo, table.featureInfo td, table.featureInfo th {
            border: 1px solid #ddd;
            border-collapse: collapse;
            margin: 0;
            padding: 0;
            font-size: 90%;
            padding: .2em .1em;
        }
        table.featureInfo th {
            padding: .2em .2em;
            font-weight: bold;
            background: #eee;
        }
        table.featureInfo td {
            background: #fff;
        }
        table.featureInfo tr.odd td {
            background: #eee;
        }
        table.featureInfo caption {
            text-align: left;
            font-size: 100%;
            font-weight: bold;
            padding: .2em .2em;
        }
    </style>
    <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
    <script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>



    <title>OpenLayers map preview</title>






  </head>
 











 <body>
    <div id="toolbar" style="display: none;">
      <ul>
        <li>
          <a>WMS version:</a>
          <select id="wmsVersionSelector" onchange="setWMSVersion(value)">
            <option value="1.1.1">1.1.1</option>
            <option value="1.3.0">1.3.0</option>
          </select>
        </li>
        <li>
          <a>Tiling:</a>
          <select id="tilingModeSelector" onchange="setTileMode(value)">
            <option value="untiled">Single tile</option>
            <option value="tiled">Tiled</option>
          </select>
        </li>
        <li>
          <a>Antialias:</a>
          <select id="antialiasSelector" onchange="setAntialiasMode(value)">
            <option value="full">Full</option>
            <option value="text">Text only</option>
            <option value="none">Disabled</option>
          </select>
        </li>
        <li>
          <a>Format:</a>
          <select id="imageFormatSelector" onchange="setImageFormat(value)">
            <option value="image/png">PNG 24bit</option>
            <option value="image/png8">PNG 8bit</option>
            <option value="image/gif">GIF</option>
            <option id="jpeg" value="image/jpeg">JPEG</option>
            <option id="jpeg-png" value="image/vnd.jpeg-png">JPEG-PNG</option>
          </select>
        </li>
        <li>
          <a>Styles:</a>
          <select id="imageFormatSelector" onchange="setStyle(value)">
            <option value="">Default</option>
          </select>
        </li>
        <li>
          <a>Width/Height:</a>
          <select id="widthSelector" onchange="setWidth(value)">
             <!--
             These values come from a statistics of the viewable area given a certain screen area
             (but have been adapted a litte, simplified numbers, added some resolutions for wide screen)
             You can find them here: http://www.evolt.org/article/Real_World_Browser_Size_Stats_Part_II/20/2297/
             --><option value="auto">Auto</option>
                <option value="600">600</option>
                <option value="750">750</option>
                <option value="950">950</option>
                <option value="1000">1000</option>
                <option value="1200">1200</option>
                <option value="1400">1400</option>
                <option value="1600">1600</option>
                <option value="1900">1900</option>
            </select>
            <select id="heigthSelector" onchange="setHeight(value)">
                <option value="auto">Auto</option>
                <option value="300">300</option>
                <option value="400">400</option>
                <option value="500">500</option>
                <option value="600">600</option>
                <option value="700">700</option>
                <option value="800">800</option>
                <option value="900">900</option>
                <option value="1000">1000</option>
            </select>
          </li>
          <li>
              <a>Filter:</a>
              <select id="filterType">
                  <option value="cql">CQL</option>
                  <option value="ogc">OGC</option>
                  <option value="fid">FeatureID</option>
              </select>
              <input type="text" size="80" id="filter"/>
              <a id="updateFilterButton" href="#" onClick="updateFilter()" title="Apply filter">Apply</a>
              <a id="resetFilterButton" href="#" onClick="resetFilter()" title="Reset filter">Reset</a>
          </li>
        </ul>
      </div>












	<div id="map">  
	    <div class="ol-toggle-options ol-unselectable"><a title="Toggle options toolbar" onClick="toggleControlPanel()" href="#toggle">...</a></div>

	 
	</div> 

<div id="popup_div" class="ol-popup"> 
	<div id="popup-title" class="ol-title">
 	</div>
	<div id="popup-content" class="ol-content">
	</div> 	
	<a href="#" id="popup-closer" class="ol-popup-closer"></a>
</div>	


	



    <div id="wrapper">
        <div id="location"></div>
        <div id="scale"></div>
    </div>
    <div id="nodelist">
        <em>Click on the map to get feature info</em>
    </div>














<script type="text/javascript">
      var pureCoverage = false;
      var popup_contents=document.getElementById('popup-content');
      var popup_titles=document.getElementById('popup-title');
      var closer = document.getElementById('popup-closer');




      // if this is just a coverage or a group of them, disable a few items,
      // and default to jpeg format
      var format = 'image/png';
      var bounds = [-180, -90,
                    180, 90];
      if (pureCoverage) {
        document.getElementById('antialiasSelector').disabled = true;
        document.getElementById('jpeg').selected = true;
        format = "image/jpeg";
      }

      var supportsFiltering = true;
      if (!supportsFiltering) {
        document.getElementById('filterType').disabled = true;
        document.getElementById('filter').disabled = true;
        document.getElementById('updateFilterButton').disabled = true;
        document.getElementById('resetFilterButton').disabled = true;
      }

      var mousePositionControl = new ol.control.MousePosition({
        className: 'custom-mouse-position',
        target: document.getElementById('location'),
        coordinateFormat: ol.coordinate.createStringXY(5),
        undefinedHTML: '&nbsp;'
      });
      var untiled = new ol.layer.Image({
        source: new ol.source.ImageWMS({
          ratio: 1,
          url: 'http://localhost:8080/geoserver/wms',
          params: {'FORMAT': format,
                   'VERSION': '1.1.1',  
                STYLES: '',
                LAYERS: 'China_maker_popup',
          }
        })
      });
      var tiled = new ol.layer.Tile({
        visible: false,
        source: new ol.source.TileWMS({
          url: 'http://localhost:8080/geoserver/wms',
          params: {'FORMAT': format, 
                   'VERSION': '1.1.1',
                   tiled: true,
                STYLES: '',
                LAYERS: 'China_maker_popup',
             tilesOrigin: -180 + "," + -90
          }
        })
      });
      var projection = new ol.proj.Projection({
          code: 'EPSG:4326',
          units: 'degrees',
          axisOrientation: 'neu',
          global: true
      });
      var map = new ol.Map({
        controls: ol.control.defaults({
          attribution: false
        }).extend([mousePositionControl]),
        target: 'map',
        layers: [
          untiled,
          tiled
        ],
        view: new ol.View({
           projection: projection,
	   center: [0, 0],
          zoom: 2
        })
      });







    //+**************************制作icon标记
 
    //创建icon1——北京
    var target_style1=new ol.style.Style({ 
	      image:new ol.style.Icon({ 
              			src:'./img/icon1.png',
				scale:0.1
          		})
		
          });  


    var iconFeature1 = new ol.Feature({ 
        geometry:new ol.geom.Point([116.28,39.54])
    });  

    iconFeature1.setStyle(target_style1);

    var vsource1 = new ol.source.Vector({
          features:[iconFeature1],
	  anchor:[0.5,0.5],
          projection: 'EPSG:4326'
      });  





    var vector1 = new ol.layer.Vector({ 
          source:vsource1  
      });  
      
    map.addLayer(vector1);



    //创建icon2——成都
    var target_style2=new ol.style.Style({ 
	      image:new ol.style.Icon({ 
              	src:'./img/icon2.png',
		scale:0.1
          	})
          })  


    var iconFeature2 = new ol.Feature({ 
        geometry:new ol.geom.Point([104.06,30.67])
    });  

    iconFeature2.setStyle(target_style2);

    var vsource2 = new ol.source.Vector({
          features:[iconFeature2],
	  anchor:[0.5,0.5],
          projection: 'EPSG:4326'
      });  





    var vector2 = new ol.layer.Vector({ 
          source:vsource2  
      });  
      
    map.addLayer(vector2);


	//创建icon3——长沙
    var target_style3=new ol.style.Style({ 
	      image:new ol.style.Icon({ 
              	src:'./img/icon3.png',
		scale:0.1
          	})
          })  


    var iconFeature3 = new ol.Feature({ 
        geometry:new ol.geom.Point([113.00,28.21])
    });  

    iconFeature3.setStyle(target_style3);

    var vsource3 = new ol.source.Vector({
          features:[iconFeature3],
	  anchor:[0.5,0.5],
          projection: 'EPSG:4326'
      });  


    var vector3 = new ol.layer.Vector({ 
          source:vsource3  
      });  
      
    map.addLayer(vector3);





	//画线
      var lineStyle=new ol.style.Style({  
        stroke: new ol.style.Stroke({  
                	width: 3,  
              		color: [255,0, 0, 1]  
              })  
        });  


	var coordinates=[
		[104.06,30.67],[116.28,39.54]
			];

	var line_feature = new ol.Feature({  
     		geometry:new ol.geom.LineString(coordinates)
        });  

	line_feature.setStyle(lineStyle);

	line_source=new ol.source.Vector({
          		features: [line_feature],
			projection: 'EPSG:4326'
		});
	line_layer=new ol.layer.Vector({
			source:line_source
		});
         map.addLayer(line_layer);




	//+**************画圆
	var circle_style=new ol.style.Style({ 
	      image:new ol.style.Circle({ 
              		radius: 10,
     			fill: new ol.style.Fill({
      			  color: 'orange'})
          	})
          })  


    var circleFeature = new ol.Feature({ 
        geometry:new ol.geom.Point([117.29,31.11])
    });  

    circleFeature.setStyle(circle_style);

    var circlevsource = new ol.source.Vector({
          features:[circleFeature],
	  anchor:[0.5,0.5],
          projection: 'EPSG:4326'
      });  


    var circlevector = new ol.layer.Vector({ 
          source:circlevsource  
      });  
      
    map.addLayer(circlevector);
















	//+***************************制作popups markers

	var popups = new ol.Overlay({
 		 element: document.getElementById('popup_div'),
		 autoPan:true,  
        	 positioning:'top-center',  
        	 autoPanAnimation:{duration:250} 
	});

	map.addOverlay(popups);


	closer.onclick = function() {
        popups.setPosition(undefined);
        closer.blur();
        return false;
      };


	map.on('singleclick', function(evt) {

				var coordinate = evt.coordinate;
				var target_coordinate1=[116.28,39.54];
				var target_coordinate2=[104.06,30.67]
				var target_coordinate3=[113.00,28.21]

                		
				var hdms = ol.coordinate.toStringHDMS(coordinate);
			//任意位置的popup
						popups.setPosition(coordinate);	
						popup_contents.innerHTML ='<p>You clicked here:</p>'+hdms;
						popup_titles.innerText = "当前位置";
						map.getView().setCenter(coordinate);

			});











      map.getView().on('change:resolution', function(evt) {
        var resolution = evt.target.get('resolution');
        var units = map.getView().getProjection().getUnits();
        var dpi = 25.4 / 0.28;
        var mpu = ol.proj.METERS_PER_UNIT[units];
        var scale = resolution * mpu * 39.37 * dpi;
        if (scale >= 9500 && scale <= 950000) {
          scale = Math.round(scale / 1000) + "K";
        } else if (scale >= 950000) {
          scale = Math.round(scale / 1000000) + "M";
        } else {
          scale = Math.round(scale);
        }
        document.getElementById('scale').innerHTML = "Scale = 1 : " + scale;
      });
      map.getView().fit(bounds, map.getSize());
      map.on('singleclick', function(evt) {
        document.getElementById('nodelist').innerHTML = "Loading... please wait...";
        var view = map.getView();
        var viewResolution = view.getResolution();
        var source = untiled.get('visible') ? untiled.getSource() : tiled.getSource();
        var url = source.getGetFeatureInfoUrl(
          evt.coordinate, viewResolution, view.getProjection(),
          {'INFO_FORMAT': 'text/html', 'FEATURE_COUNT': 50});
        if (url) {
          document.getElementById('nodelist').innerHTML = '<iframe seamless src="' + url + '"></iframe>';
        }
      });

      // sets the chosen WMS version
      function setWMSVersion(wmsVersion) {
        map.getLayers().forEach(function(lyr) {
          lyr.getSource().updateParams({'VERSION': wmsVersion});
        });
        if(wmsVersion == "1.3.0") {
            origin = bounds[1] + ',' + bounds[0];
        } else {
            origin = bounds[0] + ',' + bounds[1];
        }
        tiled.getSource().updateParams({'tilesOrigin': origin});
      }

      // Tiling mode, can be 'tiled' or 'untiled'
      function setTileMode(tilingMode) {
        if (tilingMode == 'tiled') {
          untiled.set('visible', false);
          tiled.set('visible', true);
        } else {
          tiled.set('visible', false);
          untiled.set('visible', true);
        }
      }

      function setAntialiasMode(mode) {
        map.getLayers().forEach(function(lyr) {
          lyr.getSource().updateParams({'FORMAT_OPTIONS': 'antialias:' + mode});
        });
      }

      // changes the current tile format
      function setImageFormat(mime) {
        map.getLayers().forEach(function(lyr) {
          lyr.getSource().updateParams({'FORMAT': mime});
        });
      }

      function setStyle(style){
        map.getLayers().forEach(function(lyr) {
          lyr.getSource().updateParams({'STYLES': style});
        });
      }

      function setWidth(size){
        var mapDiv = document.getElementById('map');
        var wrapper = document.getElementById('wrapper');

        if (size == "auto") {
          // reset back to the default value
          mapDiv.style.width = null;
          wrapper.style.width = null;
        }
        else {
          mapDiv.style.width = size + "px";
          wrapper.style.width = size + "px";
        }
        // notify OL that we changed the size of the map div
        map.updateSize();
      }

      function setHeight(size){
        var mapDiv = document.getElementById('map');
        if (size == "auto") {
          // reset back to the default value
          mapDiv.style.height = null;
        }
        else {
          mapDiv.style.height = size + "px";
        }
        // notify OL that we changed the size of the map div
        map.updateSize();
      }

      function updateFilter(){
        if (!supportsFiltering) {
          return;
        }
        var filterType = document.getElementById('filterType').value;
        var filter = document.getElementById('filter').value;
        // by default, reset all filters
        var filterParams = {
          'FILTER': null,
          'CQL_FILTER': null,
          'FEATUREID': null
        };
        if (filter.replace(/^\s\s*/, '').replace(/\s\s*$/, '') != "") {
          if (filterType == "cql") {
            filterParams["CQL_FILTER"] = filter;
          }
          if (filterType == "ogc") {
            filterParams["FILTER"] = filter;
          }
          if (filterType == "fid")
            filterParams["FEATUREID"] = filter;
          }
          // merge the new filter definitions
          map.getLayers().forEach(function(lyr) {
            lyr.getSource().updateParams(filterParams);
          });
        }

        function resetFilter() {
          if (!supportsFiltering) {
            return;
          }
          document.getElementById('filter').value = "";
          updateFilter();
        }

        // shows/hide the control panel
        function toggleControlPanel(){
          var toolbar = document.getElementById("toolbar");
          if (toolbar.style.display == "none") {
            toolbar.style.display = "block";
          }
          else {
            toolbar.style.display = "none";
          }
          map.updateSize()
        }

    </script>





      </body>

</html>

