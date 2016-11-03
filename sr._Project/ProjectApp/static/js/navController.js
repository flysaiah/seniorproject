var app = angular.module("roomDraw", ["ngRoute", "ngMaterial", "services"]);
app.config(function($routeProvider) {
  $routeProvider

  // route for the home page
  .when('/', {
    templateUrl : '/static/pages/navigation-main.html',
    controller  : null
  })

  .when('/building', {
    templateUrl : '/static/pages/building.html',
    controller  : 'buildingCtl'
  })

});

app.controller("navCtl", function($scope, $location, $rootScope, getGroupInfo, updateGroupInfo, getAllUsers) {

  // for testing
  // TODO: Integrate authentication
  $scope.isLoggedIn = true;
  $scope.hasGroup = false;

  $scope.searchText = "";   // Used for group search autocomplete


  getGroupInfo.fetchGroupMembers("testUser").then(function(res) {
    // fetches info about current group members and requesting group members
    $scope.groupMembers = res.groupMembers;
    $scope.requestingMembers = res.requestingMembers;
  });

  $scope.acceptRequest = function(userID) {
    updateGroupInfo.acceptRequest(userID);
  };

  $scope.rejectRequest = function(userID) {
    updateGroupInfo.rejectRequest(userID);
  };

  $scope.navigate = function(buildingName) {
    // Navigates from campus map view to floor plan of whatever building was clicked on
    $location.path("/building").search("bname", buildingName)
  };

  getAllUsers.fetchData().then(function(res) {
    // get list of all users for autocomplete
    $scope.allUsers = res.allUsers.map(function(user) {
      return {
        displayName: user.firstName + " " + user.lastName + " (" + user.userID + ")",
        searchName: angular.lowercase(user.firstName) + " " + angular.lowercase(user.lastName),
        searchID: angular.lowercase(user.userID)
      }
    });

    $scope.querySearch = function(query) {
      // filter query for autocomplete based on entered text
      var results = query ? $scope.allUsers.filter( function(user) {
        return (user.searchName.indexOf(angular.lowercase(query)) === 0)
        || (user.searchID.indexOf(angular.lowercase(query)) === 0)
      } ) : $scope.allUsers,
      deferred;
      return results;
    };
  });

});

// For each individual building
app.controller('buildingCtl', function($scope, $location, getFloorInfo) {
  // get name of building from query parameter
  $scope.buildingName = $location.search()["bname"];

  getFloorInfo.fetchData().then(function(res) {
    // fetches info about current group members and requesting group members
    $scope.floorList = res.floorList;
  });

});
