// For each individual building
var app = angular.module("building", ["services"]);
app.controller('buildingCtl', function($scope, $location, getFloorInfo) {
  // get name of building from query parameter
  $scope.buildingName = $location.search()["bname"];

  getFloorInfo.fetchData($scope.buildingName).then(function(res) {
    // fetches info about current group members and requesting group members
    $scope.floorList = res.floorList;
  });

});
