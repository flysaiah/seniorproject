// For each individual building
var app = angular.module("building", ["ngMaterial", "services"]);
app.controller('buildingCtl', function($scope, $location, getFloorInfo, getRoomInfo, getGroupInfo, registrationService, loginService, $mdSidenav) {
  // get name of building from query parameter
  $scope.buildingName = $location.search()["bname"];

  // Check if user is logged in and has a group; if not, he/she can't register

  loginService.getUserLogin().then(function(res) {
    if (res.userInfo) {
      var currentUserID = res.userInfo.email.substring(0, res.userInfo.email.indexOf("@"));
      getGroupInfo.isUserInGroup(currentUserID).then(function(res) {
        if (res.hasGroup) {
          $scope.groupID = res.groupID;
          if ($scope.groupID) {
            $scope.canRegister = true;
          }
        }
      });
    }
  });

  getFloorInfo.fetchData($scope.buildingName).then(function(res) {
    // fetches info about current group members and requesting group members
    $scope.floorList = res.floorList;
  });

  $scope.toggleRight = function(roomNum1, roomNum2) {
    $scope.roomNumber = roomNum1.toString() + roomNum2.toString();
    $scope.headerTitle = $scope.buildingName + " " + $scope.roomNumber;

    getRoomInfo.getOccupants($scope.buildingName, $scope.roomNumber).then(function(res) {
      $scope.roomOccupants = res.roomOccupants;
    });
    $mdSidenav('right').toggle();
  }

  $scope.registerForRoom = function() {
    if ($scope.canRegister) {
      registrationService.registerForRoom($scope.groupID, $scope.buildingName, $scope.roomNumber).then(function(res) {
        if (!res.wasSuccessful) {
          console.log("ERROR registering for room");
        }
      })
    }
  };
})
.controller('RightCtrl', function ($scope, $mdSidenav) {
  $scope.close = function () {
    $mdSidenav('right').close();
  };
});
