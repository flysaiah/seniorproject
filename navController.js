var app = angular.module("roomDraw", ["ngRoute"]);
app.config(function($routeProvider) {
    $routeProvider

        // route for the home page
        .when('/', {
            templateUrl : 'pages/navigation-main.html',
            controller  : 'mapCtl'
        })

        .when('/building', {
            templateUrl : 'pages/building.html',
            controller  : 'buildingCtl'
        })

});
app.controller("navCtl", function($scope, $location) {

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
app.controller('buildingCtl', function($scope, $location) {
    // get name of building from query parameter
    $scope.buildingName = $location.search()["bname"];
    $scope.getFloorNumbers = function() {
      // TODO: Database query for number of floors
      var answer = 5;
      var res = [];
      for (var i = 1; i <= answer; i++) {
        res.push(i);
      }
      return res;
    }
    $scope.test = function () {
      console.log($scope.floorNumber);
    }

});
