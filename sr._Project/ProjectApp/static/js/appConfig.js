var app = angular.module("roomDraw", ["ngRoute", "navigation", "groupinfo", "admin", "importexport"]);

app.config(function($routeProvider, $locationProvider, $mdAriaProvider) {
  $locationProvider.html5Mode(true);
  $mdAriaProvider.disableWarnings();
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
  .when('/adminPanel', {
    templateUrl : '/static/pages/admin-panel.html',
    controller : "adminCtl"
  })
  .when('/importExport', {
    templateUrl : '/static/pages/import-export.html',
    controller : "importExportCtl"
  })
});
