var app = angular.module("navigation", ["ngMaterial", "services"]);

app.controller("navCtl", function($scope, $location, $window, $mdDialog, getGroupInfo, loginService, getFloorInfo, registrationService, getRoomInfo, adminService, $mdSidenav, $mdToast) {

  // hardcoded room lists
  // TODO: Deal with this
  var room_dict = {
    'Miller': {
      "allFloorsAreSame": "true",
      "givenInRangeFormat": "true",
      "floors": [01, 23]
    },     'Dieseth': {
      "allFloorsAreSame": "true",
      "givenInRangeFormat": "true",
      "floors": [01, 23]
    }
  }//,  'Larsen': {
    //   "allFloorsAreSame": "true",
    //   "givenInRangeFormat": "true",
    //   "floors": [01, 23]
    // },    'Olson': {
    //   "allFloorsAreSame": "true",
    //   "givenInRangeFormat": "true",
    //   "floors": [01, 23]
    // },

  function generateRoomList(buildingName, floorNumber) {
    // generate list of room numbers to be used in service call for getting room occupants
    var building = room_dict[buildingName];
    // if all floor plans are identical with room names then floor number isn't as important
    if (building.allFloorsAreSame) {
      if (building.givenInRangeFormat) {
        var arr = [];
        for (var i = building.floors[0]; i < building.floors[1] + 1; i++) {
          var floorNum = parseInt(floorNumber) * 100;
          arr.push(floorNum + i)
        }
        return arr;
      }
    } else {
      // TODO: see if we need this
    }
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

  $scope.navigate = function(building) {
    // Navigate to certain building on campus
    $scope.currentBuilding = building;
    if (building !== 'campus') {
      getFloorInfo.fetchData(building.toLowerCase()).then(function(res) {
        // fetches info about number of floor sfor a given building
        $scope.floorList = res.floorList;
      });
    }
    refreshRoomInfo();
  }

  $scope.reload = function() {
    $window.location.reload();
  }

  $scope.groupInfo = function() {
    $location.path("/groupInfo");
  }

  $scope.adminPanel = function() {
    $location.path("/adminPanel")
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
    $scope.roomNumber = roomNum1.toString() + roomNum2.toString();
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
