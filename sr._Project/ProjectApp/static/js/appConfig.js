var app = angular.module("roomDraw", ["ngRoute", "navigation", "groupinfo"]);

app.config(function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);
  $routeProvider

  // route for the home page
  .when('/', {
    templateUrl : '/static/pages/navigation-main.html',
    controller  : "navCtl"
  })
  .when('/groupInfo', {
    templateUrl : '/static/pages/group-info.html',
    controller  : "groupCtl"
  })
});
