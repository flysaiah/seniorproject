var app = angular.module("admin", ["ngMaterial", "services"]);

app.controller("adminCtl", function($scope, getGroupInfo, updateGroupInfo, getAllGroupUsers, loginService, registrationService) {
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
      // refresh();
    } else {
      $scope.isLoggedIn = false;
      $scope.currentUserName = null;
      $scope.currentUserID = null;
      $scope.role = null;
    }
  });
  // function refresh() {
  //   // re-fetch all data that might have been altered by user action
  //   if ($scope.isLoggedIn) {
  //     // do something
  //   }
  // };

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
    }
  };

  $scope.removeStudentFromGroup = function(student) {
    var index = $scope.manualAddStudentsList.indexOf(student);
    if (index > -1) {
      $scope.manualAddStudentsList.splice(index, 1);
    } else {
      console.log("Problem removing student from manual-add-students group");
    }
  }

  $scope.manuallyAssignStudentsToRoom = function() {
    adminService.manuallyAssignStudentsToRoom($scope.buildingName, $scope.roomNumber, $scope.manualAddStudentsList).then(function (res) {
      if (!res.wasSuccessful) {
        if (res.reason === "RB") {
          console.log("Room bad");
        } else {
          console.log("Unknown error in manually assigning students to room");
        }
      } else {
        console.log("Successful!");
      }
    })
  }

});
