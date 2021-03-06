var app = angular.module("groupinfo", ["ngMaterial", "ngMessages", "services"]);

app.controller("groupCtl", function($scope, $mdDialog, $mdToast, getGroupInfo, updateGroupInfo, getAllGroupUsers, loginService, registrationService, getFloorInfo) {
  $scope.buildingNames = ["Dieseth", "Miller", "Larsen", "Olson"];
  $scope.autoRegEnabled = false;   // explicitly begin with this as false so as to make sure it is never null--this is important because it makes it easier on the back end
  $scope.numberOfAutoRegPrefs = 5;   // static number of maximum preferences a user can list
  $scope.defaultPref = {};

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
            // update information in "Registration Information" tab
            registrationService.getRegistrationStatus($scope.groupID).then(function(res) {
              $scope.hasRegistered = res.hasRegistered;
              if ($scope.hasRegistered) {
                $scope.roomNumber = res.roomNumber;
                $scope.buildingName = res.buildingName;
                $scope.hideAutoReg = true;
              } else {
                $scope.registrationTime = res.registrationTime;
              }
            });
            getGroupInfo.getAutoRegPref($scope.groupID).then(function(res) {
              $scope.autoRegPref = res.autoRegPref;
              formatAutoRegPref();
              $scope.autoRegEnabled = res.autoRegEnabled;
            })
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

  function formatAutoRegPref() {
    // reformat autoRegPref so that its data structure is easy to work with on the front end
    $scope.defaultPrefEnabled = false;
    var newAutoRegPref = [];
    for (var i = 0; i < $scope.autoRegPref.length; i++) {
      if ($scope.autoRegPref[i].defaultPref) {
        $scope.defaultPrefEnabled = true;
        $scope.defaultPref = {"buildingName": $scope.autoRegPref[i].buildingName, "floorNumber": $scope.autoRegPref[i].roomNumber == 0 ? "B" : $scope.autoRegPref[i].roomNumber};
      } else {
        newAutoRegPref.push({"buildingName": $scope.autoRegPref[i].buildingName, "roomNumber": $scope.autoRegPref[i].roomNumber});
      }
    }
    /* Makes sure $scope.autoRegPref has the extra empty objects it needs to provide
    user with a static number of preferences. I.e. if the database returns 2 saved
    preferences but we want to provide them with 5 options, we add 3 extra empty objects
    to our list. */
    var diff = $scope.numberOfAutoRegPrefs - $scope.autoRegPref.length;
    if (diff > 0) {
      for (var i = 0; i < diff; i++) {
        newAutoRegPref.push({});
      }
    }
    $scope.autoRegPref = newAutoRegPref;
  };

  function getFormattedPrefsForSaving() {
    // reformat autoRegPref back to the data structure that works well for the back-end
    var newAutoRegPref = [];
    for (var i = 0; i < $scope.autoRegPref.length; i++) {
      if ($scope.autoRegPref[i].buildingName) {
        newAutoRegPref.push({"buildingName": $scope.autoRegPref[i].buildingName, "roomNumber": $scope.autoRegPref[i].roomNumber, "defaultPref": false});
      }
    }
    if ($scope.defaultPrefEnabled) {
      newAutoRegPref.push({"buildingName": $scope.defaultPref.buildingName, "roomNumber": $scope.defaultPref.floorNumber === "B" ? 0 : $scope.defaultPref.floorNumber, "defaultPref": true});
    }
    return newAutoRegPref;
  };

  $scope.$watch('defaultPref.buildingName', function() {
    // make sure we have the correct amount of floors for the building we select
    if ($scope.defaultPref.buildingName) {
      getFloorInfo.fetchData($scope.defaultPref.buildingName.toLowerCase()).then(function(res) {
        // fetches info about number of floor sfor a given building
        $scope.floorList = res.floorList;
      });
    }
  });

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
    $mdToast.show(
      $mdToast.simple()
      .textContent('You have sent ' + userObj.searchID + ' a group request.')
      .position('top right')
      .hideDelay(5000)
    );
    // clear field
    // clear field
    $scope.searchText = "";
    $scope.selectedItem = undefined;
  };

  $scope.showAutoRegExplanation = function(ev) {
    // opens dialog with explanation of how auto registration works
    $mdDialog.show({
      contentElement: '#autoRegExplained',
      parent: angular.element(document.body),
      targetEvent: ev,
      clickOutsideToClose: true
    });
  };

  $scope.saveAutoRegPref = function() {
    // Saves group preferences for auto registration
    var autoRegPref = getFormattedPrefsForSaving();
    updateGroupInfo.saveAutoRegPref($scope.groupID, $scope.autoRegEnabled, autoRegPref).then(function(res) {
      if (!res.wasSuccessful) {
        // likely it failed because of an invalid room number
        if (res.prefStatusArr) {
          for (var i = 0; i < res.prefStatusArr.length; i++) {
            // prefStatusArr is an array of booleans, each corresponding to the index of a preference.
            // if true, then the pref is valid. false => invalid room number for preference
            if (!res.prefStatusArr[i]) {
              $scope.autoRegForm['roomNumberInput' + i.toString()].$setValidity("invalidnumber", false)
            }
          }
          $mdToast.show(
            $mdToast.simple()
            .textContent('There was a problem saving your preferences. Please check your room selections.')
            .position('bottom left')
            .hideDelay(5000)
          );
        } else {
          $mdToast.show(
            $mdToast.simple()
            .textContent('There was a problem saving your preferences. Please contact Res Life.')
            .position('bottom left')
            .hideDelay(5000)
          );
        }
      } else {
        $mdToast.show(
          $mdToast.simple()
          .textContent('Your auto registration preferences have been saved.')
          .position('bottom left')
          .hideDelay(5000)
        );
      }
    });
  }

  $scope.cancel = function() {
    $mdDialog.cancel();
  };
});

app.directive('numbersonly', function () {
  // Validation function that ensures numbers are entered for room
  return {
    require: 'ngModel',
    link: function(scope, elem, attr, ngModel) {
      ngModel.$parsers.unshift(function(value) {
        ngModel.$setValidity('numbersonly', !(isNaN(value)));
        // also reset the validity for other validation if they've changed the field
        ngModel.$setValidity('invalidnumber', true);
        return isNaN(value) ? false : value;
      });
    }
  };
});
