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
app.controller("navCtl", function($scope) {
  $scope.allBuildings = ["miller","dieseth","olson"];
});

// For the campus map
app.controller('mapCtl', function($scope) {
    $scope.message = 'Luther College Room Draw:';
});

// For each individual building
app.controller('buildingCtl', function($scope, $location) {
    // get name of building from query parameter
    $scope.buildingName = $location.search()["bname"];
});
