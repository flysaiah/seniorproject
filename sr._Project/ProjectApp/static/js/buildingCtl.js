// For each individual building
var app = angular.module("building", ["ngMaterial", "services"]);
app.controller('buildingCtl', function($scope, $location, getFloorInfo, getRoomInfo, registrationService, $mdSidenav) {
  // get name of building from query parameter
  $scope.buildingName = $location.search()["bname"];

  getFloorInfo.fetchData($scope.buildingName).then(function(res) {
    // fetches info about current group members and requesting group members
    $scope.floorList = res.floorList;
  });

  $scope.toggleRight = function(roomNum1, roomNum2) {
    $scope.roomNumber = roomNum1.toString() + roomNum2.toString();
    $scope.headerTitle = $scope.buildingName + " " + $scope.roomNumber;

    getRoomInfo.getOccupants($scope.buildingName, $scope.roomNumber).then(function(res) {
      $scope.currentOccupants = res;
    });
    $mdSidenav('right').toggle();
  }

  $scope.registerForRoom = function() {
    registrationService.registerForRoom($scope.groupID, $scope.buildingName, $scope.roomNumber).then(function(res) {
      if (!res.wasSuccessful) {
        console.log("ERROR registering for room");
      }
    })
  }

})
.controller('RightCtrl', function ($scope, $timeout, $mdSidenav, $log) {
  $scope.close = function () {
    // Component lookup should always be available since we are not using `ng-if`
    $mdSidenav('right').close();
  };
});
