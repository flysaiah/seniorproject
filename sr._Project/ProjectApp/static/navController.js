var app = angular.module("roomDraw", ["ngRoute"]);
app.config(function($routeProvider) {
  $routeProvider

  // route for the home page
  .when('/', {
    templateUrl : '/static/pages/navigation-main.html',
    controller  : 'mapCtl'
  })

  .when('/building', {
    templateUrl : '/static/pages/building.html',
    controller  : 'buildingCtl'
  })

});



app.controller("navCtl", function($scope, $location, $http) {

  console.log($location.url())

  $scope.navigate = function(buildingName) {
    // Navigates from campus map view to floor plan of whatever building was clicked on
    $location.path("/building").search("bname", buildingName)
  };
});

// For the campus map
app.controller('mapCtl', function($scope) {
  $scope.message = 'Luther College';
});

// For each individual building
app.controller('buildingCtl', function($scope, $location, $http) {

    // get name of building from query parameter
  $scope.buildingName = $location.search()["bname"];

  $scope.getFloorNumbers = function() {
    // TODO: getting called too many times.
    // TODO: Database query for number of floors; for now just assume floors 1-5
    console.log($scope.buildingName)
    $http({
      url: '/testB',
      method: "POST",
      headers: { 'Content-Type': 'application/json' },
      data: {fun: $scope.buildingName}
    }).success(function(response) {
      console.log(response)
      var res = [];
      for (var i = 1; i <= parseInt(response); i++) {
        res.push(i);
    }
    return res;
    });
  };

});
