var app = angular.module("navigation", ["ngMaterial", "services"]);

app.controller("navCtl", function($scope, $location, $window, getGroupInfo, updateGroupInfo, getAllGroupUsers, loginService, getFloorInfo, registrationService, getRoomInfo, $mdSidenav) {

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
        // fetches info about current group members and requesting group members
        $scope.floorList = res.floorList;
      });
    }
  }

  $scope.reload = function() {
    $window.location.reload();
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
      $scope.currentUserName = res.userInfo.given_name;
      $scope.currentUserID = res.userInfo.email.substring(0, res.userInfo.email.indexOf("@"));
      refresh();
    } else {
      $scope.isLoggedIn = false;
      $scope.currentUserName = null;
      $scope.currentUserID = null;
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
  };

  $scope.acceptRequest = function(userID) {
    updateGroupInfo.acceptRequest(userID);
    refresh();
  };

  $scope.rejectRequest = function(userID) {
    updateGroupInfo.rejectRequest(userID);
    refresh();
  };

  $scope.leaveGroup = function() {
    updateGroupInfo.leaveGroup($scope.currentUserID);
    refresh();
  };

  getAllGroupUsers.fetchData().then(function(res) {
    // get list of all users for autocomplete
    $scope.allGroupUsers = res.allGroupUsers.map(function(user) {
      return {
        displayName: user.firstName + " " + user.lastName + " (" + user.userID + ")",
        searchName: angular.lowercase(user.firstName) + " " + angular.lowercase(user.lastName),
        searchID: angular.lowercase(user.userID)
      }
    });

    $scope.querySearch = function(query) {
      // filter query for autocomplete based on entered text
      var results = query ? $scope.allGroupUsers.filter( function(user) {
        return (user.searchName.indexOf(angular.lowercase(query)) === 0)
        || (user.searchID.indexOf(angular.lowercase(query)) === 0)
      } ) : $scope.allGroupUsers,
      deferred;
      return results;
    };
  });

  $scope.createGroup = function() {
    updateGroupInfo.createGroup($scope.currentUserID);
    refresh();
  };

  $scope.requestMembership = function(userObj) {
    // request to be added to the group of the person currently selected in autocomplete
    updateGroupInfo.sendGroupRequest($scope.currentUserID, userObj.searchID);
  };

  $scope.toggleRight = function(roomNum1, roomNum2) {
    $scope.roomNumber = roomNum1.toString() + roomNum2.toString();
    $scope.headerTitle = $scope.currentBuilding.toLowerCase() + " " + $scope.roomNumber;

    getRoomInfo.getOccupants($scope.currentBuilding.toLowerCase(), $scope.roomNumber).then(function(res) {
      $scope.roomOccupants = res.roomOccupants;
    });
    $mdSidenav('right').toggle();
  }

  $scope.registerForRoom = function() {
    if ($scope.canRegister) {
      registrationService.registerForRoom($scope.groupID, $scope.currentBuilding.toLowerCase(), $scope.roomNumber).then(function(res) {
        if (!res.wasSuccessful) {
          console.log("ERROR registering for room");
        } else {
          // if they registered successfully, refresh login info so we disable the remaining "REGISTER" buttons
          refresh();
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
