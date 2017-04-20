var app = angular.module("admin", ["ngMaterial", "services"]);

app.controller("adminCtl", function($scope, $mdDialog, $mdToast, getAllGroupUsers, loginService, adminService, getRoomInfo) {
  $scope.manualAddStudentsList = [];
  $scope.buildingNames = ["Dieseth", "Miller", "Larsen", "Olson"];   // TODO: Get this data from a service

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
    if ($scope.isLoggedIn && $scope.role === "admin") {
      // fetch deadline info for the deadlines tab
      adminService.fetchDeadlinesPreferences().then(function(res) {
        $scope.groupsDeadline = res.deadlinePrefs.groupsDeadline;
        $scope.firstRegistrationDate = res.deadlinePrefs.firstRegistrationDate;
        $scope.lastRegistrationDate = res.deadlinePrefs.lastRegistrationDate;
        $scope.startTime = res.deadlinePrefs.startTime;
        $scope.endTime = res.deadlinePrefs.endTime;
        $scope.timeInterval = res.deadlinePrefs.timeInterval;
      });
    }
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

  $scope.addStudentToGroup = function(student) {
    var index = $scope.manualAddStudentsList.indexOf(student);
    if (index === -1) {
      $scope.manualAddStudentsList.push(student);
      // clear field
      $scope.searchText = "";
      $scope.selectedItem = undefined;
    }
  };

  $scope.removeStudentFromGroup = function(student) {
    var index = $scope.manualAddStudentsList.indexOf(student);
    if (index > -1) {
      $scope.manualAddStudentsList.splice(index, 1);
    } else {
      console.log("Problem removing student from manual-add-students group");
    }
  };

  $scope.manuallyAssignStudentsToRoom = function() {
    adminService.manuallyAssignStudentsToRoom($scope.buildingName, $scope.roomNumber, $scope.manualAddStudentsList).then(function(res) {
      if (!res.wasSuccessful) {
        $mdToast.show(
          $mdToast.simple()
          .textContent('Error assigning student to room. Be sure you have a valid room number.')
          .position('top right')
          .hideDelay(5000)
        );
      } else {
        $mdToast.show(
          $mdToast.simple()
          .textContent('You have successfully assigned the student to the room!')
          .position('top right')
          .hideDelay(5000)
        );
        // clear fields
        $scope.manualAddStudentsList = [];
        $scope.buildingName = "";
        $scope.roomNumber = "";
        $scope.addStudentsForm.$setPristine();
        $scope.addStudentsForm.$setPristine(true);
        $scope.addStudentsForm.$setUntouched();
      }
    });
  };

  $scope.selectRoomForRemoval = function() {
    // Updates manualRemoveStudentList with list of occupants of the room that was just selected
    getRoomInfo.getOccupantsDict($scope.removeStudentRoom.buildingName, [$scope.removeStudentRoom.roomNumber]).then(function(res) {
      // TODO: We need a flag like wasSuccessful here so that we know if we can index into the dictionary with the room number
      $scope.manualRemoveStudentList =  res.occupantsDict[$scope.removeStudentRoom.roomNumber].roomOccupants;
      if (!$scope.manualRemoveStudentList.length) {
        $mdToast.show(
          $mdToast.simple()
          .textContent('The room you selected has no occupants.')
          .position('bottom left')
          .hideDelay(5000)
        );
      } else {
        $scope.selectedRemoveStudentsRoom = {"buildingName": $scope.removeStudentRoom.buildingName, "roomNumber": $scope.removeStudentRoom.roomNumber};
      }
    });
  };

  $scope.removeStudentFromRoom = function(ev, student) {
    // Flashes confirm message then removes a single student from the given room if confirmed
    // TODO: Make this a service; right now, this is just copied from navController
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
      adminService.manuallyRemoveStudentsFromRoom($scope.removeStudentRoom.buildingName, $scope.removeStudentRoom.roomNumber, [student]).then(function(res) {
        if (!res.wasSuccessful) {
          console.log("Error removing student from room");
        } else {
          $mdToast.show(
            $mdToast.simple()
            .textContent('You have successfully removed the student from the room.')
            .position('top right')
            .hideDelay(5000)
          );
          $scope.selectRoomForRemoval();   // refresh the UI
        }
      });
    });
  };

  $scope.checkRoomAvailability = function() {
    getRoomInfo.getOccupantsDict($scope.checkAvailabilityRoom.buildingName, [$scope.checkAvailabilityRoom.roomNumber]).then(function(res) {
      // TODO: We need a flag like wasSuccessful here so that we know if we can index into the dictionary with the room number
      var room = res.occupantsDict[$scope.checkAvailabilityRoom.roomNumber];
      $scope.currentRoomAvailability = (room.isTaken) ? 0 : 1;
      // occupantsInCARoom is true if there are occupants in the room; this disables the "Turn on room" button
      $scope.occupantsInCARoom = room.roomOccupants.length ? 1 : 0;
      // TODO: Have a helpful message appear saying "There are occupants in the room!"

      // scope variable that remembers the room that was last "selected"
      $scope.selectedCheckAvailabilityRoom = {"buildingName": $scope.checkAvailabilityRoom.buildingName, "roomNumber": $scope.checkAvailabilityRoom.roomNumber};
    });
  };

  $scope.switchRoomAvailability = function() {
    // manually changes room availability
    adminService.switchRoomAvailability($scope.checkAvailabilityRoom.buildingName, $scope.checkAvailabilityRoom.roomNumber).then(function(res) {
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
        $scope.checkRoomAvailability();   // refresh the UI
      }
    });
  };

  $scope.saveDeadlinePreferences = function() {
    // save preferences for all options in the deadline panel
    adminService.saveDeadlinePreferences($scope.groupsDeadline, $scope.firstRegistrationDate, $scope.lastRegistrationDate, $scope.startTime, $scope.endTime, $scope.timeInterval);
  };

  $scope.range = function(n) {
    // utility function for ng-repeat
    return new Array(n);
  };
});
