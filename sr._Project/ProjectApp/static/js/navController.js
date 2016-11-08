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
app.controller("navCtl", function($scope, $location, $rootScope, getGroupInfo) {

  // for testing
  $scope.isLoggedIn = true;
  $scope.hasGroup = false;


  getGroupInfo.fetchGroupMembers().then(function(res) {
    // fetches info about current group members and requesting group members
    $scope.groupMembers = res.groupMembers;
    $scope.requestingMembers = res.requestingMembers;
  });

  $scope.acceptRequest = function(userID) {
    // TODO: implement

  };

  $scope.rejectRequest = function(userID) {
    // TODO: implement
  };

  $scope.navigate = function(buildingName) {
    // Navigates from campus map view to floor plan of whatever building was clicked on
    $location.path("/building").search("bname", buildingName)
  };
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
