var app = angular.module("navigation", ["ngMaterial", "services"]);

app.controller("navCtl", function($scope, $window, $location, $rootScope, getGroupInfo, updateGroupInfo, getAllGroupUsers, loginService) {

  $scope.logout = function() {
    $location.path("/logout");
    $window.location.reload();
  }

  $scope.login = function() {
    // let user login with google credentials
    $location.path("/login");
    $window.location.reload();
  }

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
      });

      getGroupInfo.fetchGroupMembers($scope.currentUserID).then(function(res) {
        // fetches info about current group members and requesting group members
        $scope.groupMembers = res.groupMembers;
        $scope.requestingMembers = res.requestingMembers;
      });
    }
  }

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
  }

  $scope.navigate = function(buildingName) {
    // Navigates from campus map view to floor plan of whatever building was clicked on
    $location.path("/building").search("bname", buildingName)
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
  }

  $scope.requestMembership = function(userObj) {
    // request to be added to the group of the person currently selected in autocomplete
    updateGroupInfo.sendGroupRequest($scope.currentUserID, userObj.searchID);
  }

});
