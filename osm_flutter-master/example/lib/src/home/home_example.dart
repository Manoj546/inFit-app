import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MainExample extends StatefulWidget {
  MainExample({Key? key}) : super(key: key);

  @override
  _MainExampleState createState() => _MainExampleState();
}

class _MainExampleState extends State<MainExample> with OSMMixinObserver {
  late MapController controller;
  late GlobalKey<ScaffoldState> scaffoldKey;
  Key mapGlobalkey = UniqueKey();
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityOSMLayers = ValueNotifier(false);
  ValueNotifier<double> positionOSMLayers = ValueNotifier(-200);
  ValueNotifier<GeoPoint?> centerMap = ValueNotifier(null);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
  ValueNotifier<bool> showFab = ValueNotifier(true);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  Timer? timer;
  int x = 0;

  @override
  void initState() {
    super.initState();
    controller = MapController.withPosition(
      initPosition: GeoPoint(
        latitude: 12.9716,
        longitude: 77.5946,
      ),
      // areaLimit: BoundingBox(
      //   east: 10.4922941,
      //   north: 47.8084648,
      //   south: 45.817995,
      //   west: 5.9559113,
      // ),
    );
    controller.addObserver(this);
    scaffoldKey = GlobalKey<ScaffoldState>();
    controller.listenerRegionIsChanging.addListener(() async {
      if (controller.listenerRegionIsChanging.value != null) {
        print(controller.listenerRegionIsChanging.value);
        centerMap.value = controller.listenerRegionIsChanging.value!.center;
      }
    });
  }

  Future<void> mapIsInitialized() async {
    await controller.setZoom(zoomLevel: 12);
    await controller.setMarkerOfStaticPoint(
      id: "line 2",
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.train,
          color: Colors.orange,
          size: 24,
        ),
      ),
    );

    await controller.setStaticPosition(
      [
        GeoPointWithOrientation(
          latitude: 47.4433594,
          longitude: 8.4680184,
          angle: pi / 4,
        ),
        GeoPointWithOrientation(
          latitude: 47.4517782,
          longitude: 8.4716146,
          angle: pi / 2,
        ),
      ],
      "line 2",
    );
    final bounds = await controller.bounds;
    print(bounds.toString());
    Future.delayed(Duration(seconds: 5), () {
      controller.changeTileLayer(tileLayer: CustomTile.cycleOSM());
    });
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (!isReady) {
      return;
    }
    await mapIsInitialized();
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('OSM'),
        leading: ValueListenableBuilder<bool>(
          valueListenable: advPickerNotifierActivation,
          builder: (ctx, isAdvancedPicker, _) {
            if (isAdvancedPicker) {
              return IconButton(
                onPressed: () {
                  advPickerNotifierActivation.value = false;
                  controller.cancelAdvancedPositionPicker();
                },
                icon: Icon(Icons.close),
              );
            }
            return SizedBox.shrink();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.layers),
            onPressed: () async {
              if (visibilityOSMLayers.value) {
                positionOSMLayers.value = -200;
                await Future.delayed(Duration(milliseconds: 700));
              }
              visibilityOSMLayers.value = !visibilityOSMLayers.value;
              showFab.value = !visibilityOSMLayers.value;
              Future.delayed(Duration(milliseconds: 500), () {
                positionOSMLayers.value = visibilityOSMLayers.value ? 32 : -200;
              });
            },
          ),
          Builder(builder: (ctx) {
            return GestureDetector(
              onLongPress: () => drawMultiRoads(),
              onDoubleTap: () async {
                await controller.clearAllRoads();
              },
              child: IconButton(
                onPressed: () => roadActionBt(ctx),
                icon: Icon(Icons.route),
              ),
            );
          }),
          IconButton(
            onPressed: () async {
              visibilityZoomNotifierActivation.value =
                  !visibilityZoomNotifierActivation.value;
              zoomNotifierActivation.value = !zoomNotifierActivation.value;
            },
            icon: Icon(Icons.zoom_out_map),
          ),
          // IconButton(
          //   onPressed: () async {
          //     await Navigator.pushNamed(context, "/picker-result");
          //   },
          //   icon: Icon(Icons.search),
          // ),
          IconButton(
            icon: Icon(Icons.select_all),
            onPressed: () async {
              if (advPickerNotifierActivation.value == false) {
                advPickerNotifierActivation.value = true;
                await controller.advancedPositionPicker();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            OSMFlutter(
              controller: controller,
              trackMyPosition: false,
              androidHotReloadSupport: true,
              mapIsLoading: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Map is Loading.."),
                  ],
                ),
              ),
              onMapIsReady: (isReady) {
                if (isReady) {
                  print("map is ready");
                }
              },
              initZoom: 8,
              minZoomLevel: 3,
              maxZoomLevel: 19,
              stepZoom: 1.0,
              userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                  iconWidget: SizedBox.square(
                    dimension: 32,
                    child: Image.asset(
                      "asset/taxi.png",
                    ),
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  icon: Icon(
                    Icons.person_pin_circle,
                    color: Colors.red,
                    size: 150,
                  ),
                ),
              ),
              showContributorBadgeForOSM: true,
              showDefaultInfoWindow: false,
              onLocationChanged: (myLocation) {
                print(myLocation);
              },
              onGeoPointClicked: (geoPoint) async {
                if (geoPoint ==
                    GeoPoint(latitude: 47.442475, longitude: 8.4680389)) {
                  await controller.setMarkerIcon(
                      geoPoint,
                      MarkerIcon(
                        icon: Icon(
                          Icons.bus_alert,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ));
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${geoPoint.toMap().toString()}",
                    ),
                    action: SnackBarAction(
                      onPressed: () =>
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      label: "hide",
                    ),
                  ),
                );
              },
              staticPoints: [
                StaticPositionGeoPoint(
                  "line 1",
                  MarkerIcon(
                    icon: Icon(
                      Icons.train,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                  [
                    GeoPoint(latitude: 47.4333594, longitude: 8.4680184),
                    GeoPoint(latitude: 47.4317782, longitude: 8.4716146),
                  ],
                ),
              ],
              roadConfiguration: RoadConfiguration(
                startIcon: MarkerIcon(
                  icon: Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.brown,
                  ),
                ),
                middleIcon: MarkerIcon(
                  icon: Icon(Icons.location_history_sharp),
                ),
                roadColor: Colors.red,
              ),
              markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
                  icon: Icon(
                    Icons.home,
                    color: Colors.orange,
                    size: 24,
                  ),
                ),
                advancedPickerMarker: MarkerIcon(
                  icon: Icon(
                    Icons.location_searching,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: ValueListenableBuilder<bool>(
                valueListenable: advPickerNotifierActivation,
                builder: (ctx, visible, child) {
                  return Visibility(
                    visible: visible,
                    child: AnimatedOpacity(
                      opacity: visible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: child,
                    ),
                  );
                },
                child: FloatingActionButton(
                  key: UniqueKey(),
                  child: Icon(Icons.arrow_forward),
                  heroTag: "confirmAdvPicker",
                  onPressed: () async {
                    advPickerNotifierActivation.value = false;
                    GeoPoint p =
                        await controller.selectAdvancedPositionPicker();
                    print(p);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: ValueListenableBuilder<bool>(
                valueListenable: visibilityZoomNotifierActivation,
                builder: (ctx, visibility, child) {
                  return Visibility(
                    visible: visibility,
                    child: child!,
                  );
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: zoomNotifierActivation,
                  builder: (ctx, isVisible, child) {
                    return AnimatedOpacity(
                      opacity: isVisible ? 1.0 : 0.0,
                      onEnd: () {
                        visibilityZoomNotifierActivation.value = isVisible;
                      },
                      duration: Duration(milliseconds: 500),
                      child: child,
                    );
                  },
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: Icon(Icons.add),
                        onPressed: () async {
                          controller.zoomIn();
                        },
                      ),
                      ElevatedButton(
                        child: Icon(Icons.remove),
                        onPressed: () async {
                          controller.zoomOut();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: visibilityOSMLayers,
              builder: (ctx, isVisible, child) {
                if (!isVisible) {
                  return SizedBox.shrink();
                }
                return child!;
              },
              child: ValueListenableBuilder<double>(
                valueListenable: positionOSMLayers,
                builder: (ctx, position, child) {
                  return AnimatedPositioned(
                    bottom: position,
                    left: 24,
                    right: 24,
                    duration: Duration(milliseconds: 500),
                    child: OSMLayersChoiceWidget(
                      centerPoint: centerMap.value!,
                      setLayerCallback: (tile) async {
                        await controller.changeTileLayer(tileLayer: tile);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void roadActionBt(BuildContext ctx) async {
    try {
      await controller.removeLastRoad();

      ///selection geoPoint
      GeoPoint point = await controller.myLocation(
        // icon: MarkerIcon(
        //   icon: Icon(
        //     Icons.person_pin_circle,
        //     color: Colors.red,
        //     size: 150,
        //   ),
        // ),
      );

      print("location btn");
      if (!trackingNotifier.value) {
        await controller.currentLocation();
        print("location btn : $controller.currentLocation()");
        await controller.enableTracking();
        //await controller.zoom(5.0);
      } else {
        await controller.disabledTracking();
      }
      trackingNotifier.value = !trackingNotifier.value;
      GeoPoint point2 = await controller.selectPosition(
        icon: MarkerIcon(
          icon: Icon(
            Icons.person_pin_circle,
            color: Colors.red,
            size: 150,
          ),
        ),
      );

      showFab.value = false;
      ValueNotifier<RoadType> notifierRoadType = ValueNotifier(RoadType.car);

      final bottomPersistant = scaffoldKey.currentState!.showBottomSheet(
        (ctx) {
          return RoadTypeChoiceWidget(
            setValueCallback: (roadType) {
              notifierRoadType.value = roadType;
            },
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );
      await bottomPersistant.closed.then((roadType) async {
        showFab.value = true;
        RoadInfo roadInformation = await controller.drawRoad(
          point, point2,
          roadType: notifierRoadType.value,
          //interestPoints: [pointM1, pointM2],
          roadOption: RoadOption(
            roadWidth: 20,
            roadColor: Colors.red,
            showMarkerOfPOI: true,
            zoomInto: true,
          ),
        );
        print(
            "duration:${Duration(seconds: roadInformation.duration!.toInt()).inMinutes}");
        print("distance:${roadInformation.distance}Km");
        print(roadInformation.route.length);
      });
    } on RoadException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${e.errorMessage()}",
          ),
        ),
      );
    }
  }

  @override
  Future<void> mapRestored() async {
    super.mapRestored();
    print("log map restored");
  }

  void drawMultiRoads() async {

    final configs = [
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: 47.4834379430,
          longitude: 8.4638911095,
        ),
        destinationPoint: GeoPoint(
          latitude: 47.4046149269,
          longitude: 8.5046595453,
        ),
      ),
      MultiRoadConfiguration(
          startPoint: GeoPoint(
            latitude: 47.4814981476,
            longitude: 8.5244329867,
          ),
          destinationPoint: GeoPoint(
            latitude: 47.3982152237,
            longitude: 8.4129691189,
          ),
          roadOptionConfiguration: MultiRoadOption(
            roadColor: Colors.orange,
          )),
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: 47.4519015578,
          longitude: 8.4371175094,
        ),
        destinationPoint: GeoPoint(
          latitude: 47.4321999727,
          longitude: 8.5147623089,
        ),
      ),
    ];
    final listRoadInfo = await controller.drawMultipleRoad(
      configs,
      commonRoadOption: MultiRoadOption(
        roadColor: Colors.red,
      ),
    );
    print(listRoadInfo);
  }
}

class RoadTypeChoiceWidget extends StatelessWidget {
  final Function(RoadType road) setValueCallback;

  RoadTypeChoiceWidget({
    required this.setValueCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 64,
            width: 196,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setValueCallback(RoadType.car);
                    Navigator.pop(context, RoadType.car);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.directions_car),
                      Text("Car"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setValueCallback(RoadType.bike);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.directions_bike),
                      Text("Bike"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setValueCallback(RoadType.foot);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.directions_walk),
                      Text("Foot"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OSMLayersChoiceWidget extends StatelessWidget {
  final Function(CustomTile? layer) setLayerCallback;
  final GeoPoint centerPoint;
  OSMLayersChoiceWidget({
    required this.setLayerCallback,
    required this.centerPoint,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 102,
          width: 342,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setLayerCallback(CustomTile.publicTransportationOSM());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox.square(
                      dimension: 64,
                      child: IgnorePointer(
                        child: OSMFlutter(
                          controller: MapController.publicTransportationLayer(
                            initPosition: centerPoint,
                            initMapWithUserPosition: false,
                          ),
                          initZoom: 12,
                          maxZoomLevel: 12,
                        ),
                      ),
                    ),
                    Text("Transportation"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  setLayerCallback(CustomTile.cycleOSM());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox.square(
                      dimension: 64,
                      child: IgnorePointer(
                        child: OSMFlutter(
                          controller: MapController.cyclOSMLayer(
                            initPosition: centerPoint,
                            initMapWithUserPosition: false,
                          ),
                          initZoom: 12,
                          maxZoomLevel: 12,
                        ),
                      ),
                    ),
                    Text("CycleOSM"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  setLayerCallback(null);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox.square(
                      dimension: 64,
                      child: IgnorePointer(
                        child: OSMFlutter(
                          controller: MapController(
                            initPosition: centerPoint,
                            initMapWithUserPosition: false,
                          ),
                          initZoom: 10,
                          maxZoomLevel: 10,
                        ),
                      ),
                    ),
                    Text("OSM"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
