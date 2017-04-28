var app = angular.module("navigation", ["ngMaterial", "services"]);

app.controller("navCtl", function($scope, $location, $window, $mdDialog, $rootScope, getGroupInfo, loginService, getFloorInfo, registrationService, getRoomInfo, adminService, $mdSidenav, $mdToast) {

  // hardcoded room lists
  var room_dict = {
    'Miller': {
      "allFloorsAreSame": true,
      "givenInRangeFormat": true,
      "floors": [01, 23]
    }, 'Dieseth': {
      "allFloorsAreSame": true,
      "givenInRangeFormat": true,
      "floors": [01, 23]
    }, 'Larsen': {
      "allFloorsAreSame": false,
      "givenInRangeFormat": false,
      "floors": {
        "B": [05, 06, 07, 08],
        "1": [01, 02, 03, 04, 05, 06, 07, 12, 13, 16],
        "2": [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 16, 17, 18, 19, 20, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37],
        "3": [00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 16, 17, 18, 19, 20, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37]
      }
    }, 'Olson': {
      "allFloorsAreSame": false,
      "givenInRangeFormat": false,
      "floors": {
        "1": [01, 02, 04, 05, 06, 07, 08, 09, 10],
        "2": [01, 02, 04, 05, 06, 07, 08, 09, 10],
        "3": [32, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 48]
      }
    }
  }

  function generateRoomList(buildingName, floorNumber) {
    // generate list of room numbers to be used in service call for getting room occupants
    var building = room_dict[buildingName];
    var floorNum = floorNumber;
    if (floorNumber == "B") {
      // make sure we can parse floorNum as an integer
      floorNum = 0;
    }
    floorNum = parseInt(floorNum) * 100
    var arr = [];
    // if all floor plans are identical with room names then floor number isn't as important
    if (building.allFloorsAreSame) {
      if (building.givenInRangeFormat) {
        for (var i = building.floors[0]; i < building.floors[1] + 1; i++) {
          arr.push(floorNum + i);
        }
      }
    } else {
      var rooms = building.floors[floorNumber];
      for (var i = 0; i < rooms.length; i++) {
        arr.push(floorNum + rooms[i]);
      }
    }
    return arr;
  };

  $scope.floorMiClasses = ['miller1','miller2', 'miller3', 'miller4', 'miller5', 'miller6', 'miller7', 'miller8'];
  $scope.floorDiClasses = ['dieseth1','dieseth2', 'dieseth3', 'dieseth4', 'dieseth5', 'dieseth6', 'dieseth7', 'dieseth8']
  $scope.floorLaClasses = ['larsen2', 'larsen3']
  $scope.floorOlClasses = ['olson1','olson2']


  // List of all building names in order (according to number on campus map)
  $scope.buildingList = ["Dieseth", "Miller", "Larsen", "Olson"];
  // used to apply CSS rules on campus map buildings
  // we can't just use CSS because of dumb HTML rules
  $scope.buildingDict = {
    "Dieseth": false,
    "Miller": false,
    "Larsen": false,
    "Olson": false
  };

  // Determines which floor plan we see in the nav window--defaults to campus map
  $scope.currentBuilding = "campus";

  $scope.logoNavigate = function() {
    /* special function used to navigate back to 'main campus' view by clicking main logo
    We need this because a separate instance of navCtl will be managing that and we need
    that instance to be able to communicate with the main instance */
    $rootScope.$broadcast("logonavigate", {});
  }

  $scope.$on('logonavigate', function (event, data) {
    // listener for $scope.logoNavigate broadcast
    $scope.navigate("campus");
  });

  $scope.navigate = function(building) {
    // Navigate to certain building on campus
    $scope.currentBuilding = building;
    if (building !== 'campus') {
      getFloorInfo.fetchData(building.toLowerCase()).then(function(res) {
        // fetches info about number of floors for a given building
        $scope.floorList = res.floorList;
      });
      $scope.floorNumber = 1;
    }
    refreshRoomInfo();
  }

  $scope.groupInfo = function() {
    $location.path("/groupInfo");
  }

  $scope.adminPanel = function() {
    $location.path("/adminPanel");
  }

  $scope.importExport = function() {
    $location.path("/importExport");
  }

  $scope.logout = function() {
    $location.path("/logout");
    $window.location.reload();
  };

  $scope.login = function() {
    // let user login with google credentials
    $location.path("/login");
    $window.location.reload();
  };

  loginService.getUserLogin().then(function(res) {
    // Determine if user is logged in; if so, get group information from refresh()
    if (res.userInfo) {
      $scope.isLoggedIn = true;
      var userInfo = res.userInfo;
      $scope.currentUserName = userInfo.given_name;
      $scope.currentUserID = userInfo.email.substring(0, res.userInfo.email.indexOf("@"));
      $scope.role = res.role;
      refresh();
    } else {
      $scope.isLoggedIn = false;
      $scope.currentUserName = null;
      $scope.currentUserID = null;
      $scope.role = null;
    }
  });

  function refresh() {
    // re-fetch all data that might have been altered by user action
    if ($scope.isLoggedIn) {
      getGroupInfo.isUserInGroup($scope.currentUserID).then(function(res) {
        // Determine if user is currently in a group; used to decide what information panels to display in UI
        $scope.hasGroup = res.hasGroup;
        // Check if logged-in user has a group; if not, he/she can't register
        if (res.hasGroup) {
          $scope.groupID = res.groupID;
          if ($scope.groupID) {
            $scope.canRegister = true;
          }
        }
      });

      getGroupInfo.fetchGroupMembers($scope.currentUserID).then(function(res) {
        // fetches info about current group members and requesting group members
        $scope.groupMembers = res.groupMembers;
        $scope.requestingMembers = res.requestingMembers;
      });
    }
    refreshRoomInfo();
  };

  function refreshRoomInfo() {
    // if we're looking at a floor plan, get information about room occupants of that floor
    if ($scope.currentBuilding !== 'campus' && $scope.floorNumber) {
      var roomList = generateRoomList($scope.currentBuilding, $scope.floorNumber);
      getRoomInfo.getOccupantsDict($scope.currentBuilding, roomList).then(function(res) {
        $scope.occupantsDict = res.occupantsDict;
      });
    }
  };

  $scope.$watch('floorNumber', function() {
    // make sure we update occupantsDict when we change floor number
    refreshRoomInfo();
  });

  $scope.toggleRight = function(roomNum1, roomNum2) {
    // change B to 0 if we're in basement
    if (roomNum1 == "B") {
      roomNum1 = "0";
    }
    $scope.roomNumber = parseInt(roomNum1.toString() + roomNum2.toString());
    $scope.headerTitle = $scope.currentBuilding.toLowerCase() + " " + $scope.roomNumber;
    $scope.roomOccupants = $scope.occupantsDict[$scope.roomNumber].roomOccupants;
    $mdSidenav('right').toggle();
  };

  $scope.registerForRoom = function() {
    if ($scope.canRegister) {
      registrationService.registerForRoom($scope.groupID, $scope.currentBuilding.toLowerCase(), $scope.roomNumber).then(function(res) {
        if (!res.wasSuccessful) {
          $mdToast.show(
            $mdToast.simple()
            .textContent('Registration unsuccessful. ' + (res.reason === 'time' ? "Please wait until your registration time." : "This room is no longer available."))
            .position('top right')
            .hideDelay(5000)
          );
        } else {
          $mdToast.show(
            $mdToast.simple()
            .textContent('You have registered successfully!')
            .position('top right')
            .hideDelay(5000)
          );
          // if they registered successfully, refresh login info so we disable the remaining "REGISTER" buttons
          refresh();
        }
      })
    }
  };

  $scope.switchRoomAvailability = function() {
    // manually changes room availability (admin function)
    adminService.switchRoomAvailability($scope.currentBuilding, $scope.roomNumber).then(function(res) {
      if (!res.wasSuccessful) {
        console.log("Error switching room availability");
      } else {
        var offOrOn = res.isTaken ? "off" : "on";
        $mdToast.show(
          $mdToast.simple()
          .textContent('You have successfully turned ' + offOrOn + ' the room.')
          .position('top right')
          .hideDelay(5000)
        );
        refreshRoomInfo();
      }
    });
  };

  $scope.removeStudentFromRoom = function(ev, student) {
    // Flashes confirm message then removes a single student from the given room if confirmed
    var confirm = $mdDialog.confirm()
          .title('Confirm removal')
          .textContent('Are you sure you want to remove ' + student.userID + ' from this room?')
          .ariaLabel('Confirm removal')
          .targetEvent(ev)
          .ok('Remove student from room')
          .cancel('Cancel');

    /* TODO: If there's a way we can squelch the warning message that comes when the
    mdDialog activates, that would be nice. Right now it's an unnecessary warning */
    $mdDialog.show(confirm).then(function() {
      adminService.manuallyRemoveStudentsFromRoom($scope.currentBuilding, $scope.roomNumber, [student]).then(function(res) {
        if (!res.wasSuccessful) {
          console.log("Error removing student from room");
        } else {
          $mdToast.show(
            $mdToast.simple()
            .textContent('You have successfully removed the student from the room.')
            .position('top right')
            .hideDelay(5000)
          );
          refreshRoomInfo();
        }
      });
    });
  };
})
.controller('RightCtrl', function ($scope, $mdSidenav) {
  $scope.close = function () {
    $mdSidenav('right').close();
  };
});
